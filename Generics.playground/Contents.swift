import UIKit

protocol LocalStorage {
    associatedtype StoredType
    
    func fetch(_ identifier: String) -> StoredType?
    func persist(_ item: StoredType)
}

protocol RemoteStorage {
    associatedtype StoredType
    
    func fetch(_ identifier: String, _ completion: (StoredType?) -> Void)
}

struct CacheBackedDataStorage<Local: LocalStorage, Remote: RemoteStorage> where Local.StoredType == Remote.StoredType {
    let localStore: Local
    let remoteStore: Remote
    
    func fetch(_ identifier: String, _ completion: @escaping (Remote.StoredType?) -> Void) {
        if let object = localStore.fetch(identifier) {
            completion(object)
        } else {
            remoteStore.fetch(identifier) { object in
                if let object = object {
                    localStore.persist(object)
                }
                completion(object)
            }
        }
    }
}
