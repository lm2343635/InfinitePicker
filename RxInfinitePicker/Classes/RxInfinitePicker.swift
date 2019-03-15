
import UIKit
import InfiniteLayout
import Reusable
import RxSwift
import RxCocoa



public class RxInfinitePicker: UIView {
    
    public var itemSize: CGSize = .zero
    
    private lazy var collectionView: RxInfiniteCollectionView = {
        let collectionView = RxInfiniteCollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: 100, height: 40)
            layout.scrollDirection = .vertical
            return layout
        }())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isItemPagingEnabled = true
        collectionView.register(cellType: LabelPickerCell.self)
        /**
        
        collectionView.rx.itemSelected.bind { [unowned self] in
            self.viewModel.pickComeptitor(at: $0.row)
            self.competitorCollectionView.scrollToItem(at: $0, at: .centeredHorizontally, animated: true)
            }.disposed(by: disposeBag)
        collectionView.layer.mask = competitorGradientLayer
        collectionView.rx.didScroll.bind { [unowned self] in
            self.updateGradientFrame()
            }.disposed(by: disposeBag)
 */
        return collectionView
    }()
    
    private lazy var dataSource = InfiniteCollectionViewSingleSectionDataSource<Int>(configureCell: { (_, collectionView, indexPath, data) in
        let cell = collectionView.dequeueReusableCell(for: indexPath) as LabelPickerCell
        cell.title = String(data)
        return cell
    })
    
    public var items = PublishSubject<[Int]>()
    
    private let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        createConstraints()
        
        items.map { SingleSection.create($0) }
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
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
    
}
