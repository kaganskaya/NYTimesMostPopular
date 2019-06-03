//
//  MasterPresenter.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift

class MasterPresenter{
    
    var localProvider = LocalProvider()
    var globalProvider = GlobalProvider()
    
    weak var view:MasterView?
    weak var favoritesView:FavoritesView?
    
    private var disposeBag = DisposeBag()
    
    
    
    func deleteFromBd(title:String){
        return localProvider.deleteData(title:title)
    }
    
    func saveToBd(article:Article) ->Observable<Bool>{
        return localProvider.saveItem(article: article)
    }
    
    func getFavorites(){
        
        localProvider.getFavorites()
            .subscribe(
                onNext: { n in
                    self.favoritesView?.showFavorites(articles: n)
                    
            }, onError: { err in
                print(err.localizedDescription)
                
            }, onCompleted: {
                //print(" onCompleted")
            }, onDisposed: {
                //print("onDisposed")
            }).disposed(by: disposeBag)
    }
    
    
    func getEmailedArticles(){
        
        globalProvider.getEmailedArticles()
            .subscribe(
                onNext: { n  in
                    
                    self.view?.showArticles(articles: n)
                    
            }, onError: { err in
                print(err.localizedDescription)
                
            }, onCompleted: {
                //print(" onCompleted")
            }, onDisposed: {
                //print("onDisposed")
            }).disposed(by: disposeBag)
    }
    
    func getShareddArticles(){
        
        globalProvider.getSharedArticles()
            .subscribe(
                onNext: { n  in
                    
                    self.view?.showArticles(articles: n)
                    
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                //print(" onCompleted")
            }, onDisposed: {
                //print("onDisposed")
            }).disposed(by: disposeBag)
    }
    
    func getViewedArticles(){
        
        globalProvider.getViewedArticles()
            .subscribe(
                onNext: { n  in
                    
                    self.view?.showArticles(articles: n)
                    
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                //print(" onCompleted")
            }, onDisposed: {
                //print("onDisposed")
            }).disposed(by: disposeBag)
    }
    
    
}
