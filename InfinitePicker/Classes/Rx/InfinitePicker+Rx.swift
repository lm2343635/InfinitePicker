//
//  InfinitePicker.swift
//  InfinitePicker+Rx
//
//  Created by Meng Li on 2019/03/15.
//  Copyright © 2019 MuShare. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import RxSwift
import RxCocoa

extension Reactive where Base: InfinitePickerProtocol {
    
    public var items: Binder<[Base.Model]> {
        return Binder(self.base) { (picker, items) in
            picker.items = items
        }
    }
    
    public var selectedIndex: Binder<Int> {
        return Binder(self.base) { (picker, selectedIndex) in
            picker.pick(at: selectedIndex)
        }
    }
    
    private var delegate: RxInfinitePickerDelegateProxy<Base.Model> {
        guard let base = base as? InfinitePicker<Base.Model> else {
            fatalError("Cannot create a RxInfinitePickerDelegateProxy due to the error type of infinite picker.")
        }
        return RxInfinitePickerDelegateProxy.proxy(for: base)
    }
    
    public var itemSelected: ControlEvent<Int> {
        return delegate.didSelectItem
    }
    
}
