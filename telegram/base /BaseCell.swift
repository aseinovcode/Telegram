//
//  BaseCell.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import UIKit

class BaseCell: UITableViewCell {
    var isLoaded = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        if !isLoaded {
            isLoaded = true
            
            addSubViews()
            setupUI()
            onViewLoaded()
        }
    }
    
    open func onViewLoaded() {
    }
    
    open func addSubViews() {
    }
    
    open func setupUI() {
    }
}
