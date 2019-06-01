//
//  ViewController.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 5/31/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit
import RxSwift

class EmailedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = MasterPresenter()
    
    var articles:[Emailed] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setupHeader(view: self.view, name: "emailed")        
        
        presenter.view = self
        presenter.getEmailedArticles()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
   

}

extension EmailedViewController: MasterView, UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    func showArticles(articles: [Any]) {
        
        self.articles = articles as! [Emailed] 
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "emailed",for: indexPath) as? EmailedTableViewCell
        
        cell?.fillCell(article: articles[indexPath.row])
        
        return cell!
    }
    
    
    
  
    
   
    
}

