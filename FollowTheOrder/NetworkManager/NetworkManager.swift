////
////  NetworkManager.swift
////  FollowTheOrder
////
////  Created by Ann Yesip on 12.01.2022.
////
//
import Foundation
import Alamofire

final class NetworkManager {
    
    private let queue = DispatchQueue(label: "download_queue", qos: .utility)

    func fetchAWishes(completion: @escaping (Fortune?) -> Void) {
        queue.async {
            AF.request("http://yerkee.com/api/fortune")
                .responseData { response in
                    guard let data = response.data else { return }
                    if let wishes = try? JSONDecoder().decode(Fortune.self, from: data) {
                        print(wishes)
                        completion(wishes)
                    } else {
                        print(" NetworkManager error ")
                    }
                }
        }
    
    }

}

