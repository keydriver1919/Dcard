//
//  DetailTableViewController.swift
//  Dcard1210
//
//  Created by change on 2021/12/10.
//

import UIKit

class DetailTableViewController: UITableViewController {
  
    var dcardFront: DcardFront!
    var dcardDetail: DcardDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://dcard.tw/_api/posts/\(dcardFront.id)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let dcardDetail = try? JSONDecoder().decode(DcardDetail.self, from: data) {
                    self.dcardDetail = dcardDetail
                    print("URL:\(url)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    //    print(dcardDetail.content)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Table view data source
    

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailTableCell", for: indexPath)
            as! DetailTableViewCell
            
      
            let contentArray = dcardDetail?.content.split(separator: "\n").map(String.init)
            let mutableAttributedString = NSMutableAttributedString()
            contentArray?.forEach {row in
                
                if row.contains("http") {
                    mutableAttributedString.append(imageFrom: row, textView: cell.detailArticle)
                } else {
                    mutableAttributedString.append(string: row)
                }
            }
            DispatchQueue.main.async {
                cell.detailArticle.attributedText = mutableAttributedString
                cell.detailArticle.font = UIFont.systemFont(ofSize: 20)

            }
        if dcardFront.school != nil{
            cell.detailType.text = dcardFront.school
        }else {
            cell.detailType.text = "匿名"
        }
        cell.detailTitle.text = dcardFront.title
        if dcardFront.gender == "M" {
            cell.detailUserImage.image = UIImage(named: "boy")
        }else{
            cell.detailUserImage.image = UIImage(named: "girl")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM HH:mm"
        let timeText = formatter.string(from: dcardFront.updatedAt)
        cell.timeLabel.text = timeText
        return cell
    }
}

extension UIImage {
    static func image(from url: URL, handel: @escaping (UIImage?) -> ()) {
        
        guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
            handel(nil)
            return
        }
        handel(image)
    }
    
    func scaled(with scale: CGFloat) -> UIImage? {
        let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension NSMutableAttributedString {
    func append(string: String) {
        self.append(NSAttributedString(string: string + "\n"))
    }
    
    func append(imageFrom: String, textView: UITextView) {
        guard let url = URL(string: imageFrom) else { return }
        
        UIImage.image(from: url) { (image) in
            guard let image = image else { return }
            let scaledImg = image.scaled(with: UIScreen.main.bounds.width / image.size.width * 0.8)
            let attachment = NSTextAttachment()
            attachment.image = scaledImg
            self.append(NSAttributedString(attachment: attachment))
            self.append(NSAttributedString(string: "\n"))
        }
    }
}
