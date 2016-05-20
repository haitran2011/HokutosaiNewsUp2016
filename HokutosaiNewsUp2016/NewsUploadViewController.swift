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
    private var images: [UIImage?]!
    
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
        self.images = [UIImage?](count: 10, repeatedValue: nil)
        
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
        form
        +++ Section("内容")
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
        +++ Section("画像")
            <<< ImageRow("Image0") {
                $0.title = "画像0"
            }.onChange { row in
                self.images[0] = row.value
            }
            <<< ImageRow("Image1") {
                $0.title = "画像1"
            }.onChange { row in
                self.images[1] = row.value
            }
            <<< ImageRow("Image2") {
                $0.title = "画像2"
            }.onChange { row in
                self.images[2] = row.value
            }
            <<< ImageRow("Image3") {
                $0.title = "画像3"
            }.onChange { row in
                self.images[3] = row.value
            }
            <<< ImageRow("Image4") {
                $0.title = "画像4"
            }.onChange { row in
                self.images[4] = row.value
            }
            <<< ImageRow("Image5") {
                $0.title = "画像5"
            }.onChange { row in
                self.images[5] = row.value
            }
            <<< ImageRow("Image6") {
                $0.title = "画像6"
            }.onChange { row in
                self.images[6] = row.value
            }
            <<< ImageRow("Image7") {
                $0.title = "画像7"
            }.onChange { row in
                self.images[7] = row.value
            }
            <<< ImageRow("Image8") {
                $0.title = "画像8"
            }.onChange { row in
                self.images[8] = row.value
            }
            <<< ImageRow("Image9") {
                $0.title = "画像9"
            }.onChange { row in
                self.images[9] = row.value
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
        
        let uploadingImages = self.makeUploadingImages()
        if uploadingImages.count > 0 {
            HokutosaiApi.uploadMedias(uploadingImages, quality: 0.8) { response in
                guard response.isSuccess, let medias = response.model else {
                    let code = response.statusCode ?? 0
                    let cause = response.error?.cause ?? "不明"
                    let alertController = UIAlertController(title: "Failured (#\(code))", message: "お知らせの投稿に失敗しました。(\(cause))", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    self.sendButton.enabled = true
                    self.cancelButton.enabled = true
                    return
                }
                
                let articleWithMedia = UploadingArticle(other: self.article)
                articleWithMedia.medias = medias
                self.postArticle(articleWithMedia)
            }
        }
        else {
            self.postArticle(self.article)
        }
    }
    
    func postArticle(article: UploadingArticle) {
        let json = Mapper<UploadingArticle>().toJSON(article)
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
    
    func makeUploadingImages() -> [UIImage] {
        var images = [UIImage]()
        for image in self.images {
            if let img = image {
                images.append(img)
            }
        }
        return images
    }

}
