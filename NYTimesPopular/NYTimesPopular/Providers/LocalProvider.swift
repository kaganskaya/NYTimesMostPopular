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
    
    
    func saveItem(article: Article) -> Observable<Bool>{
        
        do {
            
            let entity =  NSEntityDescription.entity(forEntityName: "Favorites",in: managedContext)!
            
            let entityItem = NSManagedObject(entity: entity,insertInto: managedContext) as! Favorites
            
                entityItem.title = (article).title!
                entityItem.abstract = (article).abstract
                entityItem.date = (article).publishedDate!.dateFormat()
                entityItem.link = (article).url
                entityItem.star = true
            
            do{
                let imageData = try Data(contentsOf: URL(string: getMediaData(media: (article).media!)[1])!)
                
                entityItem.image = imageData
            
            }catch let er as NSError{
                  print(er)
            }
            
            entityItem.copywrite = getMediaData(media: (article).media!)[0]
            
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
