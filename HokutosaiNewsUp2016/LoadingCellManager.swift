//
//  LoadingCellManager.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/05/01.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import UIKit

enum LoadingCellStatus {
    case Loading
    case ReadyReload
}

class LoadingCellManager {
    
    let cell: UITableViewCell
    private let loadingView: SimpleLoadingView
    private let readyReloadView: UILabel
    
    static let cellRowHeight: CGFloat = 50
    
    init(cellWidth: CGFloat, backgroundColor: UIColor, textColor: UIColor, textForReadyReload: String) {
        self.cell = UITableViewCell()
        self.cell.separatorInset = UIEdgeInsetsMake(0, CGFloat(UInt16.max), 0, 0)
        
        let frame = CGRect(x: 0, y: 0, width: cellWidth, height: LoadingCellManager.cellRowHeight)
        
        self.loadingView = SimpleLoadingView(frame: frame, backgroundColor: backgroundColor)
        
        self.readyReloadView = UILabel(frame: frame)
        self.readyReloadView.backgroundColor = backgroundColor
        self.readyReloadView.textColor = textColor
        self.readyReloadView.textAlignment = .Center
        self.readyReloadView.font = UIFont.systemFontOfSize(18.0)
        self.readyReloadView.text = textForReadyReload
        
        self.cell.selectionStyle = .None
        self.cell.contentView.addSubview(loadingView)
    }
    
    var status: LoadingCellStatus = .Loading {
        didSet {
            switch self.status {
            case .ReadyReload:
                self.cell.selectionStyle = .Default
                self.loadingView.removeFromSuperview()
                self.cell.contentView.addSubview(self.readyReloadView)
            default:
                self.cell.selectionStyle = .None
                self.readyReloadView.removeFromSuperview()
                self.cell.contentView.addSubview(self.loadingView)
            }
        }
    }
    
}