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

        
    }
    
}
