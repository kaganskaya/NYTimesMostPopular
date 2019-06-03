//
//  SharedViewController.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class SharedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = MasterPresenter()
    
    var articles:[Article] = []
    
    var favorites:[Favorites] = []
    
    var stared:Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        self.tableView.setupHeader(view: self.view, name: "shared")
        
        presenter.view = self
        presenter.favoritesView = self
        
        presenter.getShareddArticles()
        presenter.getFavorites()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

extension SharedViewController: MasterView,FavoritesView, UITableViewDelegate,UITableViewDataSource {
    
    func showFavorites(articles: [Favorites]) {
        self.favorites = articles
        self.tableView.reloadData()
        
    }
    
    
    func showArticles(articles: [Article]) {
        
        self.articles = articles 
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shared",for: indexPath) as? ArticleTableViewCell
                
        cell?.favorites = self.favorites
        
        cell?.article = self.articles[indexPath.row]
        
        cell?.fillCell()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailsViewController else { return }
        
        detailVC.article = articles[indexPath.row]
                
        let cell = self.tableView.cellForRow(at: indexPath) as! ArticleTableViewCell
        
        if cell.star.currentBackgroundImage == UIImage(named: "star") {
            self.stared = false
        }
        if cell.star.currentBackgroundImage == UIImage(named: "star1") {
            self.stared = true
        }
        
        detailVC.ifStared = self.stared
        
        self.showDetailViewController(detailVC, sender: self)
        
    }
    
    
    
    
    
    
}


