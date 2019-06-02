//
//  EmailedTableViewCell.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class EmailedTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var star: UIButton!
    
    var isTapped:Bool = false
    var article:Emailed? = nil
    
    let presenter = MasterPresenter()
    let stared:UIImage = UIImage(named: "star1")!
    let empty:UIImage = UIImage(named: "star")!
    
  
    @IBAction func press(_ sender: UIButton) {
        
        if !isTapped{
            
            sender.setBackgroundImage(stared, for: .normal)
            isTapped = true
       
            presenter.saveEmailedToBd(article: self.article!,type:"emailed") 

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
    
    func fillCell(article:Emailed){

        self.articleImage.downloadImageFrom(urlString: getImgUrl(media: article.media))
        
        self.title.text = article.title
        
        self.date.text = article.publishedDate.dateFormat()
        
        var checkTitels:[String] = []
        
        presenter.getFavorites().flatMap { a in
            checkTitels.append(a.title!)
        }
        
        for i in checkTitels {
            
            if i == self.title.text {
                
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
