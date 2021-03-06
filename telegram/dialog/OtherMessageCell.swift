//
//  OtherMessageCell.swift
//  telegram
//
//  Created by Zalkar on 9/7/21.
//

import Foundation
import UIKit
import SnapKit

class OtherMessageCell: BaseCell {
    
    private var contentMessageView: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var messageLable: UILabel = {
        let view = UILabel()
        view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        view.textColor = .white
        return view
    }()
    
    override func addSubViews() {
        addSubview(contentMessageView)
        contentMessageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.bottom.top.right.equalToSuperview()
        }
        
        contentMessageView.addSubview(messageLable)
        messageLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func fill(message: String) {
        messageLable.text = message
    }
}
