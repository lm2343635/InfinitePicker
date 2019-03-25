//
//  RxViewController.swift
//  RxInfinitePicker_Example
//
//  Created by Meng Li on 2019/03/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import InfinitePicker
import SnapKit

class RxViewController: UIViewController {
    
    private lazy var numberPicker: InfinitePicker<Int> = {
        let picker = InfinitePicker<Int>(
            itemSize: CGSize(width: 50, height: 50),
            scrollDirection: .vertical,
            cellType: NumberPickerCell.self
        )
        picker.rx.itemSelected.subscribe(onNext: { [unowned self] in
            self.viewModel.pick(at: $0)
        }).disposed(by: disposeBag)
        return picker
    }()
    
    private lazy var numberLabel = UILabel()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Update Randomly", for: .normal)
        button.rx.tap.bind { [unowned self] in
            self.viewModel.update()
        }.disposed(by: disposeBag)
        return button
    }()

    private let viewModel = RxViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(numberPicker)
        view.addSubview(numberLabel)
        view.addSubview(updateButton)
        createConstraints()
        
        viewModel.items.bind(to: numberPicker.rx.items).disposed(by: disposeBag)
        viewModel.selectedIndex.bind(to: numberPicker.rx.selectedIndex).disposed(by: disposeBag)
        viewModel.number.bind(to: numberLabel.rx.text).disposed(by: disposeBag)
    }
    
    private func createConstraints() {
        
        numberPicker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50, height: 200))
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(numberPicker.snp.bottom).offset(30)
        }
        
        updateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(numberLabel.snp.bottom).offset(30)
        }
        
    }
    
}