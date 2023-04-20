//
//  SimpleIGController.swift
//  SimpleExtend
//
//  Created by Quan on 29/11/2022.
//
import UIKit
import RxSwift
import Core
import IGListKit
import RxCocoa

open class SimpleIGController: UIViewController, ListAdapterDataSource {
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: RefreshControl
    var m_refreshControl: UIRefreshControl?
    open func initCollectionRefresh(){
        self.m_refreshControl = UIRefreshControl(frame: CGRect.zero)
        guard let collection = self.getCollectionView(),
            let refresher = m_refreshControl else{
                return
        }
        collection.addSubview(refresher)
        collection.alwaysBounceVertical = true
        refresher.subviews.first?.frame = CGRect(x: 0, y: 40, width: collection.width, height:0)
        refresher.addTarget(self, action: #selector(self.m_selectorBeginRefresh), for: UIControl.Event.valueChanged)
    }
    
    @objc func m_selectorBeginRefresh() {
        m_refreshControl?.endRefreshing()
        self.refresherDidBegined()
    }
    
    //MARK: - IG ListAdapterDataSource
    
    static var m_loadingSection = LoadingSectionModel()
    public var adapter: ListAdapter?
    public var sectionsDatas: [BaseSectionModel] = [SimpleIGController.m_loadingSection]
    var disposed = DisposeBag()
    public var loadNextLastOffset = 0
    
    open func initCollection() {
        guard let collectionView = self.getCollectionView() else{
            return
        }
        let viewController = self
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: viewController, workingRangeSize:5)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        self.adapter = adapter
        
        collectionView.rx.willDisplayCell.subscribe(onNext:{ [weak self] (cell, index) in
            self?.willDisplaySectionIndex(index.section)
            self?.willDisplayIndexPath(index)
        }).disposed(by: disposed)
    }
    //MARK: IG Delegate
    open func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.sectionsDatas
    }
    
    open func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = SectionBuilder().getSection(object: object, presenter: getSectionDelegate())
        return section
    }
    
    open func getSectionDelegate() -> AnyObject{
        return self
    }
    
    open func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    //MARK: - Collection
    
    open func willDisplaySectionIndex(_ sectionIndex: Int){
        let sectionCallIndex = self.sectionsDatas.count - loadNextLastOffset - 1
        if sectionIndex == sectionCallIndex{
            tryLoadNext(sectionIndex)
        }
        //        self.controller.getNextAfterIndex(sectionIndex)
    }
    
    open func willDisplayIndexPath(_ index: IndexPath){
        //        self.controller.getNextAfterIndex(sectionIndex)
    }
    
    open func tryLoadNext(_ sectionIndex: Int){
        
    }
    
    open func getCollectionView() -> UICollectionView?{
        return nil
    }
    
    open func refresherDidBegined(){
        
    }
    
    open func reloadSections(){
        adapter?.reloadData {[weak self] (finished) in
            if finished{
                self?.reloadSectionsComplete()
            }
        }
    }
    
    open func reloadSectionsComplete(){
        
    }
    
    open func removeLoading(){
        var removes = [BaseSectionModel]()
        sectionsDatas.forEach { (section) in
            if section is LoadingSectionModel{
                removes.append(section)
            }
        }
        if !removes.isEmpty{
            sectionsDatas.removeObjects(removes)
        }
    }
    
    open func addLoadingSection(remove: Bool = true){
        if remove{
            removeLoading()
        }
        sectionsDatas.safeAppend(sequence: getLoadingSections())
    }
    
    open func getLoadingSections() -> [BaseSectionModel]{
        return [SimpleIGController.m_loadingSection]
    }
}

public enum SectionError{
    case empty
    case networkError
    case other
    
    public static func createFromCode(_ code: Int) -> SectionError{
        switch code {
        case -1001,
             -1009,
             408:
            return SectionError.networkError
        default:
            
            return SectionError.other
        }
    }
    
    public func getImage() -> UIImage?{
        switch self {
        case .networkError:
            return AppImage.close_dark.image
        default:
            return AppImage.close_light.image
        }
    }
    
}

public enum SectionLoadingState{
    case error(SectionError)
    case loading
    case update([BaseSectionModel])
    case append([BaseSectionModel])
    case updateFinished([BaseSectionModel])
    case appendFinished([BaseSectionModel])
    case insert([BaseSectionModel], Int = 0)
    
    
    public func getSections() -> [BaseSectionModel]{
        switch self {
        case .append(let sections):
            return sections
            
        case .appendFinished(let sections):
            return sections
            
        case .update(let sections):
            return sections
            
        case .updateFinished(let sections):
            return sections
            
        case .insert(let sections, _):
            return sections
        default:
            return []
        }
    }
    
    public func mergeWithSources(_ datas: [BaseSectionModel], headers: [BaseSectionModel]? = nil, finished: Bool = false) -> SectionLoadingState{
        var m_finished = finished
        var result = datas
        switch self {
        case .loading:
            result = []
            result.safeAppend(sequence: headers)
            
        case .append(let sections):
            result.append(contentsOf: sections)
            
        case .appendFinished(let sections):
            result.append(contentsOf: sections)
            m_finished = true
            
        case .update(let sections):
            result = []
            result.safeAppend(sequence: headers)
            result.append(contentsOf: sections)
            
        case .updateFinished(let sections):
            result = []
            result.safeAppend(sequence: headers)
            result.append(contentsOf: sections)
            m_finished = true
            
        case .insert(let sections, let index):
            var fixedIndex = index + (headers?.count ?? 0)
            if fixedIndex < 0 {
                fixedIndex = 0
            }
            if fixedIndex >= result.count{
                fixedIndex = result.count
            }
            result.insert(contentsOf: sections, at: fixedIndex)
            
        default:
            return self
        }
        
        if m_finished{
            return SectionLoadingState.updateFinished(result)
        }else{
            return SectionLoadingState.update(result)
        }
    }
    
}

public enum IGLoadingState{
    case loading
    case error
    case done
    case none
    
}
