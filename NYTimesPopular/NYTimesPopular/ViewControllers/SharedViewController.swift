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
    
    var articles:[Shared] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setupHeader(view: self.view, name: "shared")
        
        presenter.view = self
        presenter.getShareddArticles()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

extension SharedViewController: MasterView, UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    func showArticles(articles: [Any]) {
        
        self.articles = articles as! [Shared]
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shared",for: indexPath) as? SharedTableViewCell
        
        cell?.fillCell(article: articles[indexPath.row])
        
        return cell!
    }
    
    
    
    
    
    
    
}

