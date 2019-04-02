//
//  HorizentalPickerCell.swift
//  InfinitePicker_Example
//
//  Created by Meng Li on 2019/04/02.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import InfinitePicker

class HorizentalPickerCell: InfinitePickerCell<String> {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var bounds: CGRect {
        didSet {
            guard bounds != .zero else {
                return
            }
            titleLabel.layer.cornerRadius = bounds.height / 2
        }
    }
    
    override var model: String? {
        didSet {
            titleLabel.text = model
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.backgroundColor = isSelected ? .yellow : .lightGray
        }
    }
    
    private func createConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }
    }
    
}
