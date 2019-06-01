//
//  MostViewedController.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class MostViewedController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    
  
    let presenter = MasterPresenter()
    
    var articles:[Viewed] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setupHeader(view: self.view, name: "viewed")
        
        presenter.view = self
        presenter.getViewedArticles()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

extension MostViewedController: MasterView, UITableViewDelegate,UITableViewDataSource {
    
    
    func showArticles(articles: [Any]) {
        
        self.articles = articles as! [Viewed]
        self.tableView.reloadData()
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewed",for: indexPath) as? ViewedTableViewCell
        
        cell?.fillCell(article: articles[indexPath.row])
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articles[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailsViewController else { return }
        detailVC.viewed = article
        detailVC.type = "viewed"
        self.showDetailViewController(detailVC, sender: self)
    }
    
    
    
    
}

