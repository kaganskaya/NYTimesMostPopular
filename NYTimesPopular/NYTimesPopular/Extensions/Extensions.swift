//
//  Extensions.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    func downloadImageFrom(urlString: String) {
    
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url)
    }
    
    func downloadImageFrom(url: URL) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                self.image = imageToCache
            }
            }.resume()
        
    }
   
    
}

extension UITableView {
    
    func setupHeader(view:UIView,name:String){
        
        let view1: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.06));
        
        let label: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.05))
        
            label.font = UIFont(name: "Beckett-Kanzlei", size: 40)
            label.textAlignment = .center

        switch name {
        case "emailed":
            label.text = "The Most Emailed"
        case "shared":
            label.text = "The Most Shared"
        case "viewed":
            label.text = "The Most Viewed"
        case "stared":
            label.text = "Favorites"
        default: break
            
        }
        
            view1.addSubview(label);
        
        self.tableHeaderView = view1
        
    }
}


extension String{
   
    func dateFormat() -> String {
        
        let df = DateFormatter()
        
        df.dateFormat = "yyyy-MM-dd"
        
        let dt = df.date(from: self)
        
        df.setLocalizedDateFormatFromTemplate("MMMM d")
        
        return df.string(from: dt!)
    }
    
}
