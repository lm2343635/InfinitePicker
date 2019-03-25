//
//  RxViewModel.swift
//  RxInfinitePicker_Example
//
//  Created by Meng Li on 2019/03/15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa

class RxViewModel {
    
    let items = BehaviorRelay<[Int]>(value: Array(1 ... 9))
    let selectedIndex = BehaviorRelay<Int>(value: 0)
    
    var itemsString: Observable<[String]> {
        return items.map { $0.map { String($0) } }
    }
    
    func pick(at index: Int) {
        print("itemSelected \(index)")
    }
    

}
