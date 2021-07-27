//
//  UIExtensions.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import SnapKit
import UIKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
    }
}
