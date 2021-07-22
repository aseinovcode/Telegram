//
//  ProfileCell.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import UIKit
import SnapKit

class ProfileCell: BaseCell {
    
    private lazy var logout: UILabel = {
        let view = UILabel()
        view.textColor = .red
        return view
    }()
    
    override func addSubViews() {
        addSubview(logout)
        logout.snp.makeConstraints{ ( make) in
            make.center.equalTo(self)
        }
    }
    
    func loadData(text: String) {
        logout.text = text
    }
    
}
