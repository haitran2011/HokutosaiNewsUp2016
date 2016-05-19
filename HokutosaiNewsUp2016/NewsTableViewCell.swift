//
//  NewsTableViewCell.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/30.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

class NewsTableViewCell: UITableViewCell {
    
    var firstImageView: UIImageView!
    var newsContentView: UIView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizerLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var topicIcon: UIImageView!
    
    var index: Int!
    var data: Article!
    
    private static let contentHeight: CGFloat = 76.0
    static let rowHeight: CGFloat = 77.0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsZero
        
        self.firstImageView = UIImageView()
        self.contentView.addSubview(self.firstImageView)
        self.firstImageView.hidden = true
        self.firstImageView.contentMode = .ScaleAspectFill
        self.firstImageView.clipsToBounds = true
        
        self.newsContentView = NSBundle.mainBundle().loadNibNamed("NewsTableViewCellContent", owner: self, options: nil).first as! UIView
        self.contentView.addSubview(self.newsContentView)
        self.newsContentView.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func changeData(index: Int, article: Article) {
        self.data = article
        self.index = index
        
        self.initLayout()
        
        if let id = article.newsId {
            self.idLabel.text = "ID: \(id)"
        }
        else {
            self.idLabel.text = "ID不明"
        }
        
        self.titleLabel.text = article.title ?? "タイトル無し"
        
        self.organizerLabel.text = article.relatedTitle
        
        if let datetime = article.datetime {
            self.datetimeLabel.text = datetime.stringElapsedTime()
        }
        else {
            self.datetimeLabel.text = nil
        }
        
        if let topic = article.isTopic where topic {
            self.topicIcon.hidden = false
        }
        else {
            self.topicIcon.hidden = true
        }
        
        self.firstImageView.image = UIImage(named: "PlaceholderImageMini")
        var contentViewLeft = self.contentView.snp_left
        if let imageUrl = article.medias?.first?.url, let url = NSURL(string: imageUrl) {
            contentViewLeft = self.firstImageView.snp_right
            self.firstImageView.hidden = false
            self.firstImageView.af_setImageWithURL(url, placeholderImage: UIImage(named: "PlaceholderImageMini"))
            self.firstImageView.snp_makeConstraints { make in
                make.left.equalTo(self.contentView)
                make.top.equalTo(self.contentView)
                make.width.height.equalTo(NewsTableViewCell.contentHeight)
            }
        }
        
        self.newsContentView.snp_makeConstraints { make in
            make.left.equalTo(contentViewLeft)
            make.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.height.equalTo(NewsTableViewCell.contentHeight)
        }
    }
    
    private func initLayout() {
        self.firstImageView.hidden = true
        self.newsContentView.hidden = false
        self.firstImageView.snp_removeConstraints()
        self.newsContentView.snp_removeConstraints()
    }
    
}
