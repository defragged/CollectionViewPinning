//
//  NoStoryboardViewController.swift
//  CollectionViewExperiments
//
//  Created by Mark Danks on 27/01/2017.
//
//

import Foundation
import UIKit

class NoStoryboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var layout: UICollectionViewFlowLayout {
        get {
            return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Programmatic"
        
        view.backgroundColor = UIColor.blue
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(VariableHeightCell.self, forCellWithReuseIdentifier: VariableHeightCell.identifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Header.identifier)
        
        layout.sectionHeadersPinToVisibleBounds = true
        
        view.addSubview(collectionView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let size = CGSize(width: collectionView.bounds.size.width, height: 50)
        layout.itemSize = size
        layout.estimatedItemSize = size
        
        layout.headerReferenceSize = CGSize(width: collectionView.bounds.size.width, height: 40)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 55
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VariableHeightCell.identifier, for: indexPath) as! VariableHeightCell
        
        cell.heightConstraint.constant = CGFloat(indexPath.row * 10 % 100) + 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Header.identifier, for: indexPath)
    }
}

class VariableHeightCell: UICollectionViewCell {
    static let identifier = "VariableHeightCell"
    
    var heightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        heightConstraint.priority = 999 // Makes an unsatisfiable constraint warning go away
        
        addConstraint(heightConstraint)
        
        backgroundColor = UIColor.green
    }
}

class Header : UICollectionReusableView {
    static let identifier = "Header"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.purple
    }
}
