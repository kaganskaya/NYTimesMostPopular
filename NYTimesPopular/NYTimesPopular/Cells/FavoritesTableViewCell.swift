//
//  FavoritesTableViewCell.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/2/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    weak var delegate: CellUpdater?


    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var star: UIButton!
    
    let presenter = MasterPresenter()
    let stared:UIImage = UIImage(named: "star1")!
    let empty:UIImage = UIImage(named: "star")!
    
    @IBAction func pressed(_ sender: UIButton) {
        sender.setBackgroundImage(empty, for: .normal)
        self.presenter.deleteFromBd(title: self.title.text!)
        delegate?.updateTableView()
    }
    
    func fillCell(article:Favorites){
        
        self.articleImage.image = UIImage(data: (article.image)!)
        
        self.title.text = article.title
        
        self.date.text = article.date
        
        self.star.setBackgroundImage(stared, for: .normal)
        
        
    }
        
        
    
}
