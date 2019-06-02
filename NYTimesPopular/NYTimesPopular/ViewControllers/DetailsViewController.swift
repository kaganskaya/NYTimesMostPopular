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
    
    @IBAction func pressed(_ sender: UIButton) {
        
        switch type {
            
        case "emailed":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                presenter.deleteFromBd(title: (self.emailed?.title)!)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                presenter.saveToBd(article: self.emailed!,type:"emailed")
                self.ifStared = true
            }
            
        case "shared":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                presenter.deleteFromBd(title: (self.shared?.title)!)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                presenter.saveToBd(article: self.shared!,type:"shared")
                self.ifStared = true
            }
            
        case "viewed":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                presenter.deleteFromBd(title: (self.viewed?.title)!)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                presenter.saveToBd(article: self.viewed!,type:"viewed")
                self.ifStared = true
            }
        case "stared":
            if self.ifStared == true {
                self.star.setBackgroundImage(UIImage(named: "star")!, for: UIControl.State.normal)
                presenter.deleteFromBd(title: (self.favorites?.title)!)
                
                self.ifStared = false
            }else{
                self.star.setBackgroundImage(UIImage(named: "star1")!, for: UIControl.State.normal)
                presenter.saveToBd(article: self.favorites!,type:"stared")
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
            url = URL(string: emailed.url)!

        case "shared":
            url = URL(string: shared.url)!

        case "viewed":
            url = URL(string: viewed.url)!
        case "stared":
            url = URL(string: favorites.link!)!

        default:break
        }

        let svc = SFSafariViewController(url: url)

        present(svc, animated: true, completion: nil)

    }
    
    let presenter = MasterPresenter()

    var emailed:Emailed!
    var shared:Shared!
    var viewed:Viewed!
    var favorites:Favorites!
    var type:String = " "
    var url:URL!
    var ifStared:Bool!

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
            self.readMore(shared.url as NSString)
            self.url = URL(string: shared.url)!
            
        case "viewed":
            self.articleTitle.text = viewed.title
            self.date.text = viewed.publishedDate.dateFormat()
            self.articleImage.downloadImageFrom(urlString: getImgUrl(media: viewed.media))
            self.abstract.text = viewed.abstract
            self.imageDescription.text = getCopyright(media: viewed.media)
            self.readMore(viewed.url as NSString)
            self.url = URL(string: viewed.url)!
            
        case "stared":
            self.articleTitle.text = favorites.title
            self.date.text = favorites.date
            self.articleImage.image =  UIImage(data: favorites.image!)
            self.abstract.text = favorites.abstract
            self.imageDescription.text = favorites.copywrite
            self.readMore(favorites.link! as NSString)
            self.url = URL(string: favorites.link!)!
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
