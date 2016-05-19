//
//  NewsUploadViewController.swift
//  HokutosaiNewsUp2016
//
//  Created by Shuka Takakuma on 2016/05/19.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import UIKit
import Eureka
import ObjectMapper

extension String {
    
    var isBlank: Bool {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet()).isEmpty
    }
    
}

class NewsUploadViewController: FormViewController {
    
    private var article: UploadingArticle!
    
    private var sendButton: UIBarButtonItem!
    private var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancelButton = UIBarButtonItem(title: "キャンセル", style: .Plain, target: self, action: #selector(NewsUploadViewController.cancel))
        self.navigationItem.leftBarButtonItems = [self.cancelButton]
        self.sendButton = UIBarButtonItem(title: "送信", style: .Done, target: self, action: #selector(NewsUploadViewController.send))
        self.sendButton.enabled = false
        self.navigationItem.rightBarButtonItems = [self.sendButton]
        
        self.article = UploadingArticle()
        
        self.generateForm()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateForm() {
        form +++ Section()
            <<< TextRow("Title") {
                $0.title = "タイトル"
                $0.placeholder = "タイトル (必須)"
            }.onChange { row in
                self.article.title = row.value
                self.validate()
            }
            <<< SwitchRow("Topic") {
                $0.title = "トピック"
            }.onChange { row in
                self.article.isTopic = row.value ?? false
            }
            <<< TextAreaRow("Text") {
                $0.title = "本文"
                $0.placeholder = "本文 (必須)"
            }.onChange { row in
                self.article.text = row.value
                self.validate()
            }
            <<< ImageRow("Image") {
                $0.title = "画像"
            }

    }
    
    func validate() -> Bool {
        guard let title = self.article.title,
              let text = self.article.text
              where !title.isEmpty && !text.isEmpty else {
            self.sendButton.enabled = false
            return false
        }
        
        self.sendButton.enabled = true
        return true
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func send() {
        guard self.validate() else {
            let alertController = UIAlertController(title: "Validation Error", message: "内容に欠陥があります。", preferredStyle: .ActionSheet)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        self.sendButton.enabled = false
        self.cancelButton.enabled = false
        
        let json = Mapper<UploadingArticle>().toJSON(self.article)
        HokutosaiApi.POST(HokutosaiApi.News.PostOnlyArticle(), parameters: json, encoding: .JSON) { response in
            guard response.isSuccess, let _ = response.model else {
                let code = response.statusCode ?? 0
                let cause = response.error?.cause ?? "不明"
                let alertController = UIAlertController(title: "Failured (#\(code))", message: "お知らせの投稿に失敗しました。(\(cause))", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.sendButton.enabled = true
                self.cancelButton.enabled = true
                return
            }

            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
