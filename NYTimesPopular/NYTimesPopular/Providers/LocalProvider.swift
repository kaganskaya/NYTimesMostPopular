//
//  LocalProvider.swift
//  NYTimesPopular
//
//  Created by liza_kaganskaya on 6/1/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//
import Foundation
import RxSwift
import Alamofire
import CoreData

class LocalProvider{
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var managedContext = appDelegate!.persistentContainer.viewContext
    
    
    func saveItem(article: Any, type:String) -> Observable<Bool>{
        
        do {
            
            let entity =  NSEntityDescription.entity(forEntityName: "Favorites",in: managedContext)!
            
            let entityItem = NSManagedObject(entity: entity,insertInto: managedContext) as! Favorites
            
            switch type {
            case "emailed":
                
                entityItem.title = (article as! Emailed).title
                entityItem.abstract = (article as! Emailed).abstract
                entityItem.date = (article as! Emailed).publishedDate.dateFormat()
                entityItem.link = (article as! Emailed).url
                entityItem.star = true
                
                do{  let imageData = try Data(contentsOf: URL(string: getMediaData(media: (article as! Emailed).media)[1])!)
                    entityItem.image = imageData
                    
                }catch let er as NSError{
                    print(er)
                }
                
                entityItem.copywrite = getMediaData(media: (article as! Emailed).media)[0]
                
            case "shared":
                
                entityItem.title = (article as! Shared).title
                entityItem.abstract = (article as! Shared).abstract
                entityItem.date = (article as! Shared).publishedDate.dateFormat()
                entityItem.link = (article as! Shared).url
                entityItem.star = true
                do{  let imageData = try Data(contentsOf: URL(string: getMediaData(media: (article as! Shared).media)[1])!)
                    entityItem.image = imageData
                    
                }catch let er as NSError{
                    print(er)
                }
                entityItem.copywrite = getMediaData(media: (article as! Shared).media)[0]
                
            case "viewed":
                
                entityItem.title = (article as! Viewed).title
                entityItem.abstract = (article as! Viewed).abstract
                entityItem.date = (article as! Viewed).publishedDate.dateFormat()
                entityItem.link = (article as! Viewed).url
                entityItem.star = true
                do{  let imageData = try Data(contentsOf: URL(string: getMediaData(media: (article as! Viewed).media)[1])!)
                    entityItem.image = imageData
                    
                }catch let er as NSError{
                    print(er)
                }
                entityItem.copywrite = getMediaData(media: (article as! Viewed).media)[0]
            case "stared":
                
                entityItem.title = (article as! Favorites).title
                entityItem.abstract = (article as! Favorites).abstract
                entityItem.date = (article as! Favorites).date
                entityItem.link = (article as! Favorites).link
                entityItem.star = true
                entityItem.image = (article as! Favorites).image
                entityItem.copywrite = (article as! Favorites).copywrite
            default:break
            }
            
            do{
                try managedContext.save()
                
                return Observable.just(true)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return Observable.just(false)
            }
            
            
        }}
    
    
    func deleteData(title:String){
        
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        fetchRequest.predicate = NSPredicate(format: "title == %@", "\(title)")
        
        do {
            
            let fetchedResults =  try managedContext.fetch(fetchRequest)
            
            for entity in fetchedResults {
                
                managedContext.delete(entity as! NSManagedObject)
            }
            
            
            do{
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
            
            
        }catch let error as NSError {
            
            print("Detele all my data in error : \(error) \(error.userInfo)")
            
        }
        
    }
    
    func getFavorites()->Observable<[Favorites]>{
        
        
        return Observable<[Favorites]>.create { observer -> Disposable in
            
            let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            
            do {
                
                let res  = try self.managedContext.fetch(fetchRequest) as! [Favorites]
                
                observer.onNext(res)
                observer.onCompleted()
                
                
            }catch let error as NSError {
                
                print("Detele all my data in error : \(error) \(error.userInfo)")
                observer.onError(error)
            }
            
            return Disposables.create(with: {})
            
        }
    }
    
    
    
    func getMediaData(media:[Media]) -> [String]{
        
        
        var data:[String] = []
        
        _ = media.compactMap { a in
            data.append(a.copyright)
            
        }
        
        _ = media.flatMap { a in
            a.mediaMetadata.map({ s in
                if s.height == 293 {
                    data.append( s.url)
                }
            })
        }
        
        return data
    }
}
