//
//  CustomizedViewController.swift
//  RxInfinitePicker
//
//  Created by Meng Li on 03/15/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit
import InfinitePicker
import SnapKit
import RxSwift

class CustomizedViewController: UIViewController {

    private lazy var numberPicker: InfinitePicker<Int> = {
        let picker = InfinitePicker<Int>(
            itemSize: CGSize(width: 50, height: 50),
            scrollDirection: .vertical,
            cellType: NumberPickerCell.self
        )
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(numberPicker)
        createConstraints()
        
        numberPicker.items = Array(1 ... 9)
    }
    
    private func createConstraints() {
        
        numberPicker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50, height: 200))
        }
        
    }

    @IBAction func update(_ sender: Any) {
        numberPicker.pick(at: Int.random(in: 0 ..< 9))
    }
    
}

extension CustomizedViewController: InfinitePickerDelegate {
    
    func didSelectItem(at index: Int) {
        numberLabel.text = "didSelectItem \(index)"
    }
    
}
