//
//  ViewController.swift
//  RxInfinitePicker
//
//  Created by Meng Li on 03/15/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

