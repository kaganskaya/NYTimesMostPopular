//
//  FavoritesViewController.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/2/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = MasterPresenter()
    
    var favorites:[Favorites] = []
    
    var stared:Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        self.tableView.setupHeader(view: self.view, name: "stared")
        
        presenter.favoritesView = self
        presenter.getFavorites()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension FavoritesViewController: FavoritesView,CellUpdater, UITableViewDelegate,UITableViewDataSource {
    
    func updateTableView() {
        presenter.getFavorites()
        
        tableView.reloadData()
    }
    func showFavorites(articles: [Favorites]) {
        self.favorites = articles
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite",for: indexPath) as? ArticleTableViewCell
        
        cell!.delegate = self
        
        cell?.favorite = self.favorites[indexPath.row]
        
        cell?.favorites = self.favorites
        
        cell?.fillCell()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailsViewController else { return }
        
        detailVC.favorites = favorites[indexPath.row]
                
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

