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
    
    private var disposeBag = DisposeBag()
    
    func deleteFromBd(title:String){
        return localProvider.deleteData(title:title)
    }

    func saveEmailedToBd(article:Emailed,type:String) ->Observable<Bool>{
        return localProvider.saveEmailed(article: article,type: type)
    }
    
    func getFavorites()->[Favorites]{
        
        return localProvider.getFavorites()
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
