//
//  ViewController.swift
//  RxInfinitePicker
//
//  Created by Meng Li on 03/15/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit
import RxInfinitePicker
import SnapKit
import RxSwift

class ViewController: UIViewController {

    private lazy var numberPicker: RxInfinitePicker<Int> = {
        let picker = RxInfinitePicker<Int>(
            itemSize: CGSize(width: 50, height: 50),
            scrollDirection: .vertical,
            cellType: NumberPickerCell.self
        )
        /*
        picker.itemSelected.subscribe(onNext: { [unowned self] in
            print("itemSelected \($0)")
        }).disposed(by: disposeBag)
 */
        picker.delegate = self
        return picker
    }()
    
    private let viewModel: ViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

}

extension ViewController: RxInfinitePickerDelegate {
    
    func didSelectItem(at index: Int) {
        print("didSelectItem \(index)")
    }
    
}
