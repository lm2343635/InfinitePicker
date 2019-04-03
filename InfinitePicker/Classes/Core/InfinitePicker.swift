//
//  InfinitePicker.swift
//  InfinitePicker
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

import UIKit
import InfiniteLayout

fileprivate struct Const {
    static let pickerCellIdentider = "RxInfinitePicker.CellIdentider"
}

public protocol InfinitePickerProtocol: class {
    associatedtype Model
    var items: [Model] { get set }
    
    func pick(at index: Int)
}

public protocol InfinitePickerDelegate: class {
    func didSelectItem(at index: Int)
}

public class InfinitePicker<Model>: UIControl,
    UICollectionViewDataSource, UICollectionViewDelegate,
    InfinitePickerProtocol, InfiniteCollectionViewDelegate,
    UIGestureRecognizerDelegate {

    private let itemSize: CGSize
    private let scrollDirection: UICollectionView.ScrollDirection
    private let spacing: CGFloat
    private let cellType: InfinitePickerCell<Model>.Type
    
    var currentIndex = 0
    var selectedIndex = 0
    
    private var moving = false
    
    private lazy var gesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognizer(_:)))
        gesture.delegate = self
        return gesture
    }()
    
    private lazy var collectionView: InfiniteCollectionView = {
        let collectionView = InfiniteCollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = 0
            layout.itemSize = itemSize
            layout.scrollDirection = scrollDirection
            switch scrollDirection {
            case .vertical:
                layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: 0)
            case .horizontal:
                layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
            @unknown default:
                break
            }
            return layout
        }())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isItemPagingEnabled = true
        collectionView.register(cellType, forCellWithReuseIdentifier: Const.pickerCellIdentider)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.infiniteDelegate = self
        collectionView.addGestureRecognizer(gesture)
        return collectionView
    }()
    
    public var items: [Model] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.performBatchUpdates(nil) { [unowned self] _ in
                self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0))?.isSelected = true
            }
        }
    }
    
    public weak var delegate: InfinitePickerDelegate?
    
    deinit {
        collectionView.removeGestureRecognizer(gesture)
    }
    
    public init(
        frame: CGRect = .zero,
        itemSize: CGSize,
        scrollDirection: UICollectionView.ScrollDirection,
        spacing: CGFloat = 0,
        cellType: InfinitePickerCell<Model>.Type
    ) {
        self.itemSize = itemSize
        self.scrollDirection = scrollDirection
        self.spacing = spacing
        self.cellType = cellType
        super.init(frame: frame)

        addSubview(collectionView)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private var scrollPosition: UICollectionView.ScrollPosition {
        switch scrollDirection {
        case .vertical:
            return .centeredVertically
        case .horizontal:
            return .centeredHorizontally
        @unknown default:
            return .centeredVertically
        }
    }
    
    @objc private func gestureRecognizer(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .began:
            moving = true
        case .ended, .cancelled, .failed:
            moving = false
            delegate?.didSelectItem(at: selectedIndex)
            collectionView.cellForItem(at: IndexPath(row: currentIndex, section: 0))?.isSelected = true
        default:
            break
        }
    }
    
    public var isScrollEnabled: Bool = true {
        didSet {
            collectionView.isScrollEnabled = isScrollEnabled
        }
    }
    
    public func pick(at index: Int) {
        guard 0 ..< items.count ~= index else {
            return
        }
        let indexPath = IndexPath(row: currentIndex - currentIndex % items.count + index, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: scrollPosition)
    }
    
    // MARK: UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = self.collectionView.indexPath(from: indexPath).row
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.pickerCellIdentider, for: indexPath) as? InfinitePickerCell<Model>,
            0 ..< items.count ~= index
        else {
            return UICollectionViewCell()
        }
        cell.model = items[index]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isSelected = true
        collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
        selectedIndex = self.collectionView.indexPath(from: indexPath).row
        delegate?.didSelectItem(at: selectedIndex)
    }
    
    //  MARK: InfiniteCollectionViewDelegate
    public func infiniteCollectionView(_ infiniteCollectionView: InfiniteCollectionView, didChangeCenteredIndexPath centeredIndexPath: IndexPath?) {
        guard let indexPath = centeredIndexPath else {
            return
        }
        // Set the isSelected of last selected cell to false.
        collectionView.cellForItem(at: IndexPath(row: currentIndex, section: 0))?.isSelected = false
        
        // Set new current index.
        currentIndex = indexPath.row
        selectedIndex = collectionView.indexPath(from: indexPath).row
    }
    
    // MARK: UIGestureRecognizerDelegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
