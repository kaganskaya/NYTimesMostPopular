//
//  MasterView.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

protocol MasterView: class {
    func showArticles(articles:[Article])
}

protocol FavoritesView:class {
    func showFavorites(articles:[Favorites])

}
protocol CellUpdater: class {
    func updateTableView()
}
