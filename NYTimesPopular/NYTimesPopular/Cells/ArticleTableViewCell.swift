//
//  EmailedTableViewCell.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var star: UIButton!
    
    weak var delegate: CellUpdater?
    
    var favorites:[Favorites] = []
    var isTapped:Bool = false
    var article:Any? = nil
    var type:String = " "
    
    let presenter = MasterPresenter()
    let stared:UIImage = UIImage(named: "star1")!
    let empty:UIImage = UIImage(named: "star")!
    
    
    @IBAction func pressed(_ sender: UIButton) {
        
        
        if !isTapped{
            
            sender.setBackgroundImage(stared, for: .normal)
            isTapped = true
            switch self.type {
                
            case "emailed":
                _ = presenter.saveToBd(article: self.article as! Emailed,type:"emailed")
            case "shared":
                _ = presenter.saveToBd(article: self.article as! Shared, type:"shared")
            case "viewed":
                _ = presenter.saveToBd(article: self.article as! Viewed,type:"viewed")
                
            default:break
            }
            
        }else{
            
            sender.setBackgroundImage(empty, for: .normal)
            
            isTapped = false
            
            if self.type == "favorite" {
                
                self.presenter.deleteFromBd(title: self.title.text!)
                delegate?.updateTableView()
                
            }else{
                presenter.deleteFromBd(title: (self.title.text)!)
            }
            
        }
    }
    
    func fillCell(){
        
        switch type{
            
        case "emailed":
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article as! Emailed).media))
            
            self.title.text = (article as! Emailed).title
            
            self.date.text = (article as! Emailed).publishedDate.dateFormat()
        case "shared":
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article as! Shared).media))
            
            self.title.text = (article as! Shared).title
            
            self.date.text = (article as! Shared).publishedDate.dateFormat()
        case "viewed":
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article as! Viewed).media))
            
            self.title.text = (article as! Viewed).title
            
            self.date.text = (article as! Viewed).publishedDate.dateFormat()
        case "favorite":
            self.articleImage.image = UIImage(data: ((article as! Favorites).image)!)
            
            self.title.text = (article as! Favorites).title
            
            self.date.text = (article as! Favorites).date
            
        default:break
            
        }
        
        self.favorites.count == 0 ? self.star.setBackgroundImage(empty, for: .normal) : ()
        
        for i in favorites {
            
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
    
    func getImgUrl(media:[Media]) -> String{
        
        var url:String = " "
        
        _ = media.flatMap { a in
            a.mediaMetadata.map({ s in
                url = s.url
            })
        }
        return url
    }
    
}



