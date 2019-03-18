# RxInfinitePicker

[![CI Status](https://img.shields.io/travis/lm2343635/RxInfinitePicker.svg?style=flat)](https://travis-ci.org/lm2343635/RxInfinitePicker)
[![Version](https://img.shields.io/cocoapods/v/RxInfinitePicker.svg?style=flat)](https://cocoapods.org/pods/RxInfinitePicker)
[![License](https://img.shields.io/cocoapods/l/RxInfinitePicker.svg?style=flat)](https://cocoapods.org/pods/RxInfinitePicker)
[![Platform](https://img.shields.io/cocoapods/p/RxInfinitePicker.svg?style=flat)](https://cocoapods.org/pods/RxInfinitePicker)

`RxInfinitePicker` is an iOS infinite picker based on RxSwift, it helps you to create a infinite picker using a customized cell.
Using `RxInfinitePicker` requires the base `RxSwift` (https://github.com/ReactiveX/RxSwift) knowledge.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Documentation

RxInfinitePicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxInfinitePicker'
```

#### Customized cell

The following code is a demo of a customized cell.
A customized cell class `NumberPickerCell` is a subclass of the generic class RxInfinitePickerCell.
`Int` is the model type of this customized cell.

```Swift
class NumberPickerCell: RxInfinitePickerCell<Int> {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
   	
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var model: Int? {
        didSet {
            guard let number = model else {
                return
            }
            numberLabel.text = String(number)
        }
    }

    // ...
    
}
```

#### Using RxInfinitePicker

Create a picker in your view controller class.
The generic type must be same as which in your customized class.

```Swift
private lazy var numberPicker: RxInfinitePicker<Int> = {
    let picker = RxInfinitePicker<Int>(
        itemSize: CGSize(width: 50, height: 50),
        scrollDirection: .vertical,
        cellType: NumberPickerCell.self
    )
    picker.itemSelected.subscribe(onNext: { [unowned self] in
        print("itemSelected \($0)")
    }).disposed(by: disposeBag)
    return picker
}()
```

Bind your data to the picker.
```Swift
override func viewDidLoad() {
    super.viewDidLoad()
    //...

    viewModel.items.bind(to: numberPicker.items).disposed(by: disposeBag)
}
```

After scrolling or selecting a new item, the `itemSelected` signal that contains the selected model  will be updated.

## Author

lm2343635, lm2343635@126.com

## License

RxInfinitePicker is available under the MIT license. See the LICENSE file for more info.
