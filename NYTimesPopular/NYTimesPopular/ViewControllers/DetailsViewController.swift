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
    var article:Any? = nil
    var type:String = " "
    var url:URL!
    var ifStared:Bool!
    
    
    @IBAction func pressed(_ sender: UIButton) {
        
        switch type {
            
        case "emailed":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                _ = presenter.deleteFromBd(title: (article as! Emailed).title)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                _ = presenter.saveToBd(article: article as! Emailed, type:"emailed")
                self.ifStared = true
            }
            
        case "shared":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                presenter.deleteFromBd(title: (article as! Shared).title)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                _ = presenter.saveToBd(article: article as! Shared, type:"shared")
                self.ifStared = true
            }
            
        case "viewed":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                _ = presenter.deleteFromBd(title: (article as! Viewed).title)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                _ = presenter.saveToBd(article: article as! Viewed, type:"viewed")
                self.ifStared = true
            }
        case "stared":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                _ = presenter.deleteFromBd(title: (article as! Favorites).title!)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                _ = presenter.saveToBd(article: article as! Favorites, type:"stared")
                self.ifStared = true
            }
            
        default:break
        }
        
        
    }
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readMore(_ sender: Any) {
        
        var url:URL!
        
        switch type {
            
        case "emailed":
            url = URL(string: (article as! Emailed).url)!
            
        case "shared":
            url = URL(string: (article as! Shared).url)!
            
        case "viewed":
            url = URL(string: (article as! Viewed).url)!
            
        case "stared":
            url = URL(string: (article as! Favorites).link!)!
            
        default:break
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
        
        switch type {
            
        case "emailed":
            self.articleTitle.text = (article as! Emailed).title
            self.date.text = (article as! Emailed).publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article as! Emailed).media))
            self.abstract.text = (article as! Emailed).abstract
            self.imageDescription.text = getCopyright(media: (article as! Emailed).media)
            self.readMore((article as! Emailed).url as NSString)
            self.url = URL(string: (article as! Emailed).url)!
            
            
        case "shared":
            self.articleTitle.text = (article as! Shared).title
            self.date.text = (article as! Shared).publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article as! Shared).media))
            self.abstract.text = (article as! Shared).abstract
            self.imageDescription.text = getCopyright(media: (article as! Shared).media)
            self.readMore((article as! Shared).url as NSString)
            self.url = URL(string: (article as! Shared).url)!
            
        case "viewed":
            self.articleTitle.text = (article as! Viewed).title
            self.date.text = (article as! Viewed).publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: (article as! Viewed).media))
            self.abstract.text = (article as! Viewed).abstract
            self.imageDescription.text = getCopyright(media: (article as! Viewed).media)
            self.readMore((article as! Viewed).url as NSString)
            self.url = URL(string: (article as! Viewed).url)!
            
        case "stared":
            self.articleTitle.text = (article as! Favorites).title
            self.date.text = (article as! Favorites).date
            self.articleImage.image =  UIImage(data: (article as! Favorites).image!)
            self.abstract.text = (article as! Favorites).abstract
            self.imageDescription.text = (article as! Favorites).copywrite
            self.readMore((article as! Favorites).link! as NSString)
            self.url = URL(string: (article as! Favorites).link!)!
        default:break
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
