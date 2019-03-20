
import UIKit

open class InfinitePickerCell<Model>: UICollectionViewCell {
    open var model: Model?
}

public class LabelPickerCell: InfinitePickerCell<String> {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public override var model: String? {
        didSet {
            guard let title = model else {
                return
            }
            titleLabel.text = title
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .blue : .darkGray
        }
    }
    
}
