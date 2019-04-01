//
//  PickerCell.swift
//  RxInfinitePicker_Example
//
//  Created by Meng Li on 2019/03/15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import InfinitePicker
import ShapeView

fileprivate extension UIColor {
    @objc convenience init(hex: UInt32) {
        let mask = 0x0000ff
        
        let r = CGFloat(Int(hex >> 16) & mask) / 255
        let g = CGFloat(Int(hex >> 8) & mask) / 255
        let b = CGFloat(Int(hex) & mask) / 255
        
        self.init(red:r, green:g, blue:b, alpha:1)
    }
}

fileprivate struct Const {
    
    static func competitorColor(with index: Int) -> UIColor? {
        let competitorColors = [
            UIColor(hex: 0xd5d5d5),
            UIColor(hex: 0x444444),
            UIColor(hex: 0xdb4b3e),
            UIColor(hex: 0x0091d4),
            UIColor(hex: 0xf4c724),
            UIColor(hex: 0x208d54),
            UIColor(hex: 0xe27534),
            UIColor(hex: 0xe4688d),
            UIColor(hex: 0x996abb)
        ]
        guard 0 ..< competitorColors.count ~= index else {
            return nil
        }
        return competitorColors[index]
    }
    
    struct number {
        static let size: CGFloat = 40
    }
    
}

class NumberPickerCell: InfinitePickerCell<Int> {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = ShapeView()
        view.path = .corner(radius: Const.number.size / 2) { [unowned view] in
            return view.bounds
        }
        view.innerShadow = ShapeShadow(radius: 4, color: .white, opacity: 0.5)
        view.addSubview(numberLabel)
        return view
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
            containerView.backgroundColor = Const.competitorColor(with: number - 1)
        }
    }
    
    private func createConstraints() {
        
        containerView.snp.makeConstraints {
            $0.size.equalTo(Const.number.size)
            $0.center.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
}
