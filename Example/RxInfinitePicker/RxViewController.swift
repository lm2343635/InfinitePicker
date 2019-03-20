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
//        picker.rx.itemSelected.subscribe(onNext: { [unowned self] in
//            print("itemSelected \($0)")
//        }).disposed(by: disposeBag)
        return picker
    }()

    private let viewModel = RxViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(numberPicker)
        createConstraints()
    }
    
    private func createConstraints() {
        numberPicker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50, height: 200))
        }
    }
    
}
