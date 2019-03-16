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
    
    private lazy var picker: RxInfinitePicker = {
        let picker = RxInfinitePicker(itemSize: CGSize(width: 100, height: 50))
        picker.backgroundColor = .lightGray
        picker.itemSelected.subscribe(onNext: { [unowned self] in
            self.viewModel.pick(at: $0)
        }).disposed(by: disposeBag)
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
        view.addSubview(picker)
        createConstraints()
        
        viewModel.items.bind(to: picker.items).disposed(by: disposeBag)
    }
    
    private func createConstraints() {
        picker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 200))
        }
    }

}

