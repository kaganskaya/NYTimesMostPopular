//
//  DetailsViewController.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var imageDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readMore(_ sender: Any) {
      
        var url:URL!

        switch type {

        case "emailed":
            url = URL(string: emailed.url)!

        case "shared":
            url = URL(string: shared.url)!

        case "viewed":
            url = URL(string: viewed.url)!

        default:break
        }

        let svc = SFSafariViewController(url: url)

        present(svc, animated: true, completion: nil)

    }
    
    
    var emailed:Emailed!
    var shared:Shared!
    var viewed:Viewed!
    var type:String = " "
    var url:URL!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    func setupView(){
        
        
        switch type {
            
        case "emailed":
            self.articleTitle.text = emailed.title
            self.date.text = emailed.publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: emailed.media))
            self.abstract.text = emailed.abstract
            self.imageDescription.text = getCopyright(media: emailed.media)
            self.readMore(emailed.url as NSString)
            self.url = URL(string: emailed.url)!
            
        case "shared":
            self.articleTitle.text = shared.title
            self.date.text = shared.publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: shared.media))
            self.abstract.text = shared.abstract
            self.imageDescription.text = getCopyright(media: shared.media)
            
        case "viewed":
            self.articleTitle.text = viewed.title
            self.date.text = viewed.publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: viewed.media))
            self.abstract.text = viewed.abstract
            self.imageDescription.text = getCopyright(media: viewed.media)
            
        default:break
        }
        
    }
    
   
    func getImgUrl(media:[Media]) -> String{
        
        var url:String = " "
        
        media.flatMap { a in
            a.mediaMetadata.map({ s in
                url =  s.url
            })
        }
        
        return url
    }
    
    func getCopyright(media:[Media]) -> String{
        
        var res:String = " "
        
        media.flatMap { a in
            res = a.copyright
        }
        
        
        return res
    }
    
   
}
