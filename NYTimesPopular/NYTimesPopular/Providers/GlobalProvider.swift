//
//  GlobalProvider.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 5/31/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift


class GlobalProvider{
    
    let apiKey = "m2prG2EJvsU1zVmiOSIe68LhoP1vrtTR"
    
    let headers: HTTPHeaders = ["Authorization": "Bearer D1OLBwqLhC5_27J_oSLIjXhAqJs17p6urXveZCxdAyuIQaba9toeFnc1kCWBL8DG9cAsDKsIUX-qki8Ey5fL_eK-XtUQfngg6HSrdWtQmXW4Q4hBOBJ76Z1L-eplXHYx"]
    
    
    func getViewedArticles() -> Observable<[Viewed]> {
        
        let url = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=\(apiKey)"
        
        return Observable<[Viewed]>.create { observer  in
            
            let keyList = "results"
            
            let request = Alamofire
                
                .request(url, method: .get, headers: self.headers )
                
                .validate()
                
                .responseJSON { response in
                    
                    let value:  NSDictionary?  = response.result.value as? NSDictionary
                    
                    if let listValues =  value?[keyList] {
                        
                        
                        let decoder = JSONDecoder()
                        
                        if let data = try? JSONSerialization.data(withJSONObject: listValues as! NSArray , options:[]){
                            do{
                                
                                let content:[Viewed] = try decoder.decode([Viewed].self, from: data)
                                observer.onNext(content)
                                observer.onCompleted()
                            }catch let er as NSError{
                                
                                observer.onError(er)
                            }
                        }else{
                            let error : NSError = NSError(
                                domain: "GlobalProvider",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey:"error while serialization"])
                            
                            observer.onError(error)
                        }
                    } else{
                        let error : NSError = NSError(
                            domain: "GlobalProvider",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey:"Под данному запросу нету информации"])
                        
                        observer.onError(error)
                    }
                    
            }
            
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
        
    }
    
    
    func getSharedArticles() -> Observable<[Shared]> {
        
        let url = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key=\(apiKey)"
        
        return Observable<[Shared]>.create { observer  in
            
            let keyList = "results"
            
            let request = Alamofire
                
                .request(url, method: .get, headers: self.headers )
                
                .validate()
                
                .responseJSON { response in
                    
                    let value:  NSDictionary?  = response.result.value as? NSDictionary
                    
                    if let listValues =  value?[keyList] {
                        
                        
                        let decoder = JSONDecoder()
                        
                        if let data = try? JSONSerialization.data(withJSONObject: listValues as! NSArray , options:[]){
                            do{
                                
                                let content:[Shared] = try decoder.decode([Shared].self, from: data)
                                observer.onNext(content)
                                observer.onCompleted()
                            }catch let er as NSError{
                                
                                observer.onError(er)
                            }
                        }else{
                            let error : NSError = NSError(
                                domain: "GlobalProvider",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey:"error while serialization"])
                            
                            observer.onError(error)
                        }
                    } else{
                        let error : NSError = NSError(
                            domain: "GlobalProvider",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey:"Под данному запросу нету информации"])
                        
                        observer.onError(error)
                    }
                    
            }
            
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
        
    }
    
    
    func getEmailedArticles() -> Observable<[Emailed]> {

        let url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=\(apiKey)"
        
        return Observable<[Emailed]>.create { observer  in
            
            let keyList = "results"
            
            let request = Alamofire
                
                .request(url, method: .get, headers: self.headers )
                
                .validate()
                
                .responseJSON { response in
                    
                    let value:  NSDictionary?  = response.result.value as? NSDictionary
                    
                    if let listValues =  value?[keyList] {
                        
                        
                        let decoder = JSONDecoder()
                        
                        if let data = try? JSONSerialization.data(withJSONObject: listValues as! NSArray , options:[]){
                            do{
                                
                                let content:[Emailed] = try decoder.decode([Emailed].self, from: data)
                                observer.onNext(content)
                                observer.onCompleted()
                            }catch let er as NSError{
                                
                                observer.onError(er)
                            }
                        }else{
                            let error : NSError = NSError(
                                domain: "GlobalProvider",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey:"error while serialization"])
                            
                            observer.onError(error)
                        }
                    } else{
                        let error : NSError = NSError(
                            domain: "GlobalProvider",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey:"Под данному запросу нету информации"])
                        
                        observer.onError(error)
                    }
                    
            }
            
        
            return Disposables.create(with: {
                request.cancel()
            })
        }
        
    }
    
}
