//
//  SharedTableViewCell.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class SharedTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var star: UIButton!
    
    var favorites:[Favorites] = []
    var isTapped:Bool = false
    var article:Shared? = nil
    
    let presenter = MasterPresenter()
    let stared:UIImage = UIImage(named: "star1")!
    let empty:UIImage = UIImage(named: "star")!
    
    
    @IBAction func tapped(_ sender: UIButton) {
        
        if !isTapped{
            
            sender.setBackgroundImage(stared, for: .normal)
            isTapped = true
            
            presenter.saveToBd(article: self.article!,type:"shared")
            
        }else{
            
            sender.setBackgroundImage(empty, for: .normal)
            isTapped = false
            
            presenter.deleteFromBd(title: (self.article?.title)!)
        }
    }
    func getImgUrl(media:[Media]) -> String{
        
        var url:String = " "
        
        media.flatMap { a in
            a.mediaMetadata.map({ s in
               
                url = s.url
                
            })
        }
        return url
    }
    
    func fillCell(article:Shared){
        
        self.articleImage.downloadImageFrom(urlString: getImgUrl(media: article.media))
                
        self.title.text = article.title
        
        self.date.text = article.publishedDate.dateFormat()
       
        if favorites.count == 0{
            self.star.setBackgroundImage(empty, for: .normal)
        }
            
        
        for i in favorites{
            
            if self.title.text == i.title {
                
                self.star.setBackgroundImage(stared, for: .normal)
                self.isTapped = true
                break
                
            } else{
                
                self.isTapped = false
                self.star.setBackgroundImage(empty, for: .normal)
            }
        }
        
        
    }
}
