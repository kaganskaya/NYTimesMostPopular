//
//  TableViewCell.swift
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
    var article:Article? = nil
    var favorite:Favorites? = nil
    
    let presenter = MasterPresenter()
    let stared:UIImage = UIImage(named: "star1")!
    let empty:UIImage = UIImage(named: "star")!
    
    
    @IBAction func pressed(_ sender: UIButton) {
        
        
        if !isTapped{
            
            sender.setBackgroundImage(stared, for: .normal)
            isTapped = true
            
            _ = presenter.saveToBd(article: self.article!)
                
           
        }else{
            
            sender.setBackgroundImage(empty, for: .normal)
            
            isTapped = false
            
            self.presenter.deleteFromBd(title: self.title.text!)
            
            delegate?.updateTableView()
                
        }
    }
    
    func fillCell(){
        
        if favorite != nil {
            self.articleImage.image = UIImage(data: (favorite?.image)!)
            
            self.title.text = favorite!.title
            
            self.date.text = favorite?.date
            
        }else{
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article)!.media!))
            
            self.title.text = (article)!.title
            
           self.date.text = (article)!.publishedDate!.dateFormat()
        
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



