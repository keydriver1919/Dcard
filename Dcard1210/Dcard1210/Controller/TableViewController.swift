//
//  TableViewController.swift
//  Dcard1210
//
//  Created by change on 2021/12/10.
//

import UIKit

class TableViewController: UITableViewController {
    var timer: Timer?

    var dcards = [DcardFront]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //closure寫法
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { [weak self] timer in self?.getData()})
        
        //開始下拉更新的功能
        refreshControl = UIRefreshControl()
        //設定元件顏色
        refreshControl?.tintColor = UIColor.black
        //設定背景顏色
        refreshControl?.backgroundColor = UIColor.white
        //將元件加入TableView的視圖中
        refreshControl?.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl

        DcardClient.shared.getDecard(urlString: "https://dcard.tw/_api/posts/") { (dcards) in
            if let dcards = dcards {
                self.dcards = dcards
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
         // 將timer的執行緒停止
         if self.timer != nil {
              self.timer?.invalidate()
         }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dcards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
       // cell.selectionStyle = .none//取消選擇效果
        let dcard = dcards[indexPath.row]
        var school:String

        
        cell.titleLabel.text = dcard.title
        if dcard.school != nil{
            school = dcard.school!
            cell.titleType.text = "\(dcard.forumName)|\(school)"
        }else{
            cell.titleType.text = dcard.forumName
        }
        cell.likeCount.text = "\(dcard.likeCount)"
        cell.recallLabel.text = "\(dcard.commentCount)"
        cell.articleLabel.text = dcard.excerpt
        
        if dcard.gender == "M" {
            cell.userImage.image = UIImage(named: "boy")
        }else{
            cell.userImage.image = UIImage(named: "girl")
        }
        if !dcard.media.isEmpty {
            DcardClient.shared.getImage(urlStr: dcard.media[0]?.url) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.articleImage.isHidden = false
                    cell.articleImage.image = image
                }
            }
        }
        
        }else{
            cell.articleImage.isHidden = true
        }
        return cell
    }
    
    @objc func getData() -> () {
        DcardClient.shared.getDecard(urlString:

            "https://dcard.tw/_api/posts/"
        ) { (dcards) in
            if let dcards = dcards {
                self.dcards = dcards
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()

            }
        }
    }

    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailTableViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            let controller = DetailTableViewController(coder: coder)
            controller?.dcardFront = dcards[row]
            return controller
        }else{
        return nil
        }
    }
    
    
    
    deinit {
            timer?.invalidate()
            timer = nil;
        }
}




