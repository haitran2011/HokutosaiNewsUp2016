//
//  NewsViewController.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/21.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    private var articles: [Article]?
    
    private var timeline: UITableView!
    
    private let cellIdentifier = "Timeline"
    
    private var updatingTimeline: Bool = false
    var updatingContents: Bool { return self.updatingTimeline }
    
    private let onceGetArticleCount: UInt = 25
    private var articlesHitBottom: Bool = false
    private var loadingCellManager: LoadingCellManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "お知らせ"
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "WriteIcon"), style: .Plain, target: self, action: #selector(NewsViewController.writeArticle))
        ]
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.generateTimeline()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(NewsViewController.cellLongPressed(_:)))
        longPressRecognizer.delegate = self
        self.timeline.addGestureRecognizer(longPressRecognizer)
        
        self.loadingCellManager = LoadingCellManager(cellWidth: self.timeline.width, backgroundColor: UIColor.whiteColor(), textColor: UIColor.blueColor(), textForReadyReload: "もう一度読み込む")
        
        let loadingView = SimpleLoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        self.updateContents() {
            if !self.updatingContents {
                loadingView.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        if self.articles != nil {
            while (UInt(self.articles!.count) > self.onceGetArticleCount) {
                self.articles!.removeLast()
            }
            self.articlesHitBottom = false
            self.timeline?.reloadData()
            self.timeline?.setContentOffset(CGPointZero, animated: false)
        }
    }
    
    private func generateTimeline() {
        self.timeline = UITableView(frame: self.view.frame)
        self.view.addSubview(self.timeline)
        
        self.timeline.registerClass(NewsTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        self.timeline.rowHeight = NewsTableViewCell.rowHeight
        self.timeline.layoutMargins = UIEdgeInsetsZero
        self.timeline.separatorInset = UIEdgeInsetsZero
        
        self.timeline.dataSource = self
        self.timeline.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NewsViewController.onRefresh(_:)), forControlEvents: .ValueChanged)
        self.timeline.addSubview(refreshControl)
    }
    
    private func updateTimeline(completion: (() -> Void)? = nil) {
        self.updateTimeline(nil, completion: completion)
    }
    
    private func updateTimeline(lastId: UInt?, completion: (() -> Void)? = nil) {
        guard !self.updatingTimeline else { return }
        self.updatingTimeline = true
        
        var params: [String: UInt] = ["count": self.onceGetArticleCount]
        if let lastId = lastId {
            params["last_id"] = lastId - 1
        }
        
        HokutosaiApi.GET(HokutosaiApi.News.Timeline(), parameters: params) { response in
            guard response.isSuccess, let data = response.model else {
                if lastId != nil {
                    self.loadingCellManager.status = .ReadyReload
                }
                self.updatingTimeline = false
                completion?()
                return
            }
            
            self.loadingCellManager.status = .Loading
            self.articlesHitBottom = UInt(data.count) < self.onceGetArticleCount
            
            if let articles = self.articles where lastId != nil {
                self.articles = articles + data
            }
            else {
                self.articles = data
            }
            
            self.timeline.reloadData()
            self.updatingTimeline = false
            completion?()
        }
    }
    
    private func updateContents(completion: () -> Void) {
        self.updateTimeline(completion)
    }
    
    func updateContents() {
        guard self.timeline != nil else { return }
        self.updateTimeline() {
            self.timeline.setContentOffset(CGPointZero, animated: false)
        }
    }
    
    var requiredToUpdateWhenDidChengeTab: Bool { return true }
    var requiredToUpdateWhenWillEnterForeground: Bool { return true }
    
    func onRefresh(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        
        self.updateContents() {
            if !self.updatingContents {
                refreshControl.endRefreshing()
            }
        }
    }
    
    func tabBarIconTapped() {
        self.timeline?.setContentOffset(CGPointZero, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = self.articles else {
            return 0
        }
        
        // 底に着いていればLoadingCellを表示しない
        return articles.count + (self.articlesHitBottom ? 0 : 1)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let articles = self.articles else { return NewsTableViewCell.rowHeight }
        guard indexPath.row < articles.count else {
            return LoadingCellManager.cellRowHeight
        }
        
        return NewsTableViewCell.rowHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard indexPath.row < self.articles!.count else {
            self.updateTimeline(self.articles!.last?.newsId)
            return self.loadingCellManager.cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! NewsTableViewCell
        
        cell.changeData(indexPath.row, article: self.articles![indexPath.row])
        
        return cell
    }
    
    func reloadData() {
        self.timeline.reloadData()
    }
    
    func cellLongPressed(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.locationInView(self.timeline)
        guard recognizer.state == UIGestureRecognizerState.Began,
            let indexPath = self.timeline.indexPathForRowAtPoint(point),
            let data = self.articles,
            let newsId = data[indexPath.row].newsId
            else { return }
        
        self.tappedCell(newsId, title: data[indexPath.row].title)
    }
    
    func tappedCell(newsId: UInt, title: String?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "お知らせを削除する", style: .Destructive) { action in
            let confirmAlert = UIAlertController(title: "[削除] ID: \(newsId)", message: "title: \(title ?? "タイトル無し")", preferredStyle: .Alert)
            confirmAlert.addAction(UIAlertAction(title: "削除", style: .Default) { action in
                self.deleteArticle(newsId)
            })
            confirmAlert.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
            self.presentViewController(confirmAlert, animated: true, completion: nil)
        }
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func deleteArticle(newsId: UInt) {
        HokutosaiApi.DELETE(HokutosaiApi.News.DeleteOnlyArticle(newsId: newsId)) { response in
            guard response.isSuccess, let _ = response.model else {
                let code = response.statusCode ?? 0
                let cause = response.error?.cause ?? "不明"
                let alertController = UIAlertController(title: "Failured (#\(code))", message: "[ID:\(newsId)]の削除に失敗しました。(\(cause))", preferredStyle: .ActionSheet)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
    }
    
    func writeArticle() {
        
    }
    
}
