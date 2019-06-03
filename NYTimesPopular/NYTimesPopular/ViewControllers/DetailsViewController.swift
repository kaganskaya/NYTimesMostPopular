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
    @IBOutlet weak var star: UIButton!
    
    let presenter = MasterPresenter()
    var article:Article? = nil
    var favorites:Favorites? = nil
    var url:URL!
    var ifStared:Bool!
    
    
    @IBAction func pressed(_ sender: UIButton) {
        
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                _ = presenter.deleteFromBd(title: self.articleTitle.text!)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                _ = presenter.saveToBd(article: article!)
                self.ifStared = true
            }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readMore(_ sender: Any) {
        
        var url:URL!
    
        if favorites != nil {
            url = URL(string: favorites!.link!)!
        }else{
            url = URL(string: (article)!.url!)!

        }
        let svc = SFSafariViewController(url: url)
        
        present(svc, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    func setupView(){
        
        
        if self.ifStared == true {
            self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
        }else{
            self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
            
        }
                   
        if favorites != nil {
            self.articleTitle.text = favorites!.title
            self.date.text = favorites!.date
            self.articleImage.image =  UIImage(data: favorites!.image!)
            self.abstract.text = favorites!.abstract
            self.imageDescription.text = favorites!.copywrite
            self.readMore(favorites!.link! as NSString)
            self.url = URL(string: favorites!.link!)!
        }else{
            self.articleTitle.text = (article)!.title
            self.date.text = (article)!.publishedDate!.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article)!.media!))
            self.abstract.text = (article)!.abstract
            self.imageDescription.text = getCopyright(media: (article)!.media!)
            self.readMore((article)!.url! as NSString)
            self.url = URL(string: (article)!.url!)!
        }

    }
    
    
    func getImgUrl(media:[Media]) -> String{
        
        var url:String = " "
        
        _ = media.flatMap { a in
            a.mediaMetadata.map({ s in
                url =  s.url
            })
        }
        
        return url
    }
    
    func getCopyright(media:[Media]) -> String{
        
        var res:String = " "
        
        _ = media.compactMap { a in
            res = a.copyright
        }
        
        
        return res
    }
    
    
}
