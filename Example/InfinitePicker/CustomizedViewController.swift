//
//  CustomizedViewController.swift
//  RxInfinitePicker
//
//  Created by Meng Li on 03/15/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit
import InfinitePicker

class CustomizedViewController: UIViewController {
    
    private lazy var typePicker: InfinitePicker<String> = {
        let picker = InfinitePicker<String>(
            itemSize: CGSize(width: 70, height: 30),
            scrollDirection: .horizontal,
            spacing: 20,
            cellType: HorizentalPickerCell.self
        )
        picker.isScrollEnabled = false
        picker.delegate = self
        return picker
    }()

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
        view.addSubview(typePicker)
        createConstraints()
        
        numberPicker.items = Array(1 ... 9)
        typePicker.items = ["wide", "win2", "place2", "win3", "place3"]
    }
    
    private func createConstraints() {
        
        numberPicker.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50, height: 200))
            $0.bottom.equalTo(typePicker.snp.top).offset(-20)
        }
        
        typePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: UIScreen.main.bounds.width, height: 50))
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
