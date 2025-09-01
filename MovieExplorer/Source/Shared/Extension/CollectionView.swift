//
//  CollectionView.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import UIKit


extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    func register<T: UICollectionReusableView>(headerType: T.Type, bundle: Bundle? = nil) {
        let className = headerType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: Self.elementKindSectionHeader, withReuseIdentifier: className)
    }
    func register<T: UICollectionReusableView>(footerType: T.Type, bundle: Bundle? = nil) {
        let className = footerType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: Self.elementKindSectionFooter, withReuseIdentifier: className)
    }
    
    func dequeueHeaderView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: Self.elementKindSectionHeader, withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    func dequeueFooterView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: Self.elementKindSectionFooter, withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
