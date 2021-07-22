//
//  NDCell.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import UIKit
import SnapKit

class NDCell: BaseCell {
    
    private lazy var name: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.black
        return view
    }()
    
    private lazy var userImage: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func addSubViews() {
        addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        addSubview(name)
        name.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(10)
            make.top.equalToSuperview().offset(8)
        }
        
        addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.right.equalToSuperview()
            make.left.equalTo(name)
            make.bottom.equalToSuperview()
        }
    }
    
    func fill(chat: ChatModel) {
        userImage.kf.setImage(with: URL(string: chat.urlImage))
        name.text = chat.name
    }

}
