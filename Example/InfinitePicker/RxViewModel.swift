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
    
    let numbers = BehaviorRelay<[Int]>(value: Array(1 ... 9))
    let items = BehaviorRelay<[String]>(value: ["wide", "win2", "place2", "win3", "place3"])
    let selectedIndex = PublishSubject<Int>()
    
    var number: Observable<String?> {
        return selectedIndex.map { String($0) }
    }
    
    func pickNumber(at index: Int) {
        print("number itemSelected \(index)")
    }
    
    func pickType(at index: Int) {
        print("type itemSelected \(index)")
    }
    
    func update() {
        selectedIndex.onNext(Int.random(in: 0 ..< 5))
    }
    
}
