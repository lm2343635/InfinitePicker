
import RxDataSources
import InfiniteLayout

// SectionedReloadDataSource
struct SingleSectionModel<T>: SectionModelType {
    
    typealias Item = T
    
    var items: [T]
    
    init(items: [T]) {
        self.items = items
    }
    
    init(original: SingleSectionModel<T>, items: [T]) {
        self = original
    }
    
    static func create(_ items: [T]) -> SingleSection<T> {
        return [SingleSectionModel(items: items)]
    }
    
}

typealias SingleSection<T> = [SingleSectionModel<T>]

extension SingleSection where Element: SectionModelType {
    static func create(_ items: [Element.Item]) -> SingleSection<Element.Item> {
        return [SingleSectionModel(items: items)]
    }
}

typealias InfiniteCollectionViewSingleSectionDataSource<T> = RxInfiniteCollectionViewSectionedReloadDataSource<SingleSectionModel<T>>
