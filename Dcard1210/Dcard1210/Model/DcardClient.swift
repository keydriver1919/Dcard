//
//  DcardClient.swift
//  Dcard1210
//
//  Created by change on 2021/12/10.
//

import Foundation
import UIKit
struct DcardClient {
    
    static var shared = DcardClient()
    
    func getDecard(urlString: String, completionHandler: @escaping ([DcardFront]?) -> ()) {
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                let decoder = JSONDecoder()
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let data = try decoder.singleValueContainer().decode(String.self)
                    return dateFormatter.date(from: data) ?? Date()
                })
                if let data = data {
                    do {
                        _ = try decoder.decode([DcardFront].self, from: data)
                    } catch {
                        print(error)
                    }
                    let dcardFront = try? decoder.decode([DcardFront].self, from: data)
                    completionHandler(dcardFront)
                }else{
                    completionHandler(nil)
                }
            }.resume()
        }
    }
    
    func getImage(urlStr: String?, completionHandler: @escaping(UIImage?) -> ()) {
        if let url = URL(string: urlStr!) {
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                if let data = data, let image = UIImage(data: data) {
                    completionHandler(image)
                }else{
                    completionHandler(nil)
                }
            }.resume()
        }
    }
}
