//
//  ViewModel.swift
//  RxInfinitePicker_Example
//
//  Created by Meng Li on 2019/03/15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    
    let items = BehaviorRelay<[Int]>(value: Array(1 ... 10))
    
    var itemsString: Observable<[String]> {
        return items.map { $0.map { String($0) } }
    }
    

}
