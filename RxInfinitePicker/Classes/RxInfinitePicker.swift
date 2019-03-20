
import UIKit
import InfiniteLayout
import RxSwift
import RxCocoa

fileprivate struct Const {
    static let pickerCellIdentider = "RxInfinitePicker.CellIdentider"
}

public protocol RxInfinitePickerDelegate: class {
    func didSelectItem(at index: Int)
}

public class RxInfinitePicker<Model>: UIView, UICollectionViewDataSource, UICollectionViewDelegate, InfiniteCollectionViewDelegate {

    private let itemSize: CGSize
    private let scrollDirection: UICollectionView.ScrollDirection
    private let cellType: RxInfinitePickerCell<Model>.Type
    
    private lazy var collectionView: InfiniteCollectionView = {
        let collectionView = InfiniteCollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = itemSize
            layout.scrollDirection = scrollDirection
            return layout
        }())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isItemPagingEnabled = true
        collectionView.register(cellType, forCellWithReuseIdentifier: Const.pickerCellIdentider)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.infiniteDelegate = self
        /**
        collectionView.rx.itemSelected.bind { [unowned self] in
            switch self.scrollDirection {
            case .vertical:
                collectionView.scrollToItem(at: $0, at: .centeredVertically, animated: true)
            case .horizontal:
                collectionView.scrollToItem(at: $0, at: .centeredHorizontally, animated: true)
            }
        }.disposed(by: disposeBag)
        collectionView.rx.itemCentered.filter { $0 != nil }.map { $0! }.skip(1).bind { [unowned self] in
            self.pick(at: $0.row)
        }.disposed(by: disposeBag)
 */
        return collectionView
    }()
    
    public var items: [Model] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public weak var delegate: RxInfinitePickerDelegate?
    
    public init(
        frame: CGRect = .zero,
        itemSize: CGSize,
        scrollDirection: UICollectionView.ScrollDirection,
        cellType: RxInfinitePickerCell<Model>.Type
    ) {
        self.itemSize = itemSize
        self.scrollDirection = scrollDirection
        self.cellType = cellType
        super.init(frame: frame)

        addSubview(collectionView)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = self.collectionView.indexPath(from: indexPath).row
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.pickerCellIdentider, for: indexPath) as? RxInfinitePickerCell<Model>,
            0 ..< items.count ~= index
            
        else {
            return UICollectionViewCell()
        }
        cell.model = items[index]
        return cell
    }
    
    // UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch scrollDirection {
        case .vertical:
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        case .horizontal:
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    // InfiniteCollectionViewDelegate
    public func infiniteCollectionView(_ infiniteCollectionView: InfiniteCollectionView, didChangeCenteredIndexPath centeredIndexPath: IndexPath?) {
        guard let indexPath = centeredIndexPath else {
            return
        }
        delegate?.didSelectItem(at: collectionView.indexPath(from: indexPath).row)
    }
    
}
