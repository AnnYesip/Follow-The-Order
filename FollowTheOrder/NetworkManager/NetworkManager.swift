////
////  NetworkManager.swift
////  FollowTheOrder
////
////  Created by Ann Yesip on 12.01.2022.
////
//
//import Foundation
//import Alamofire
//




/// !!!! подтянуть эту надпись !!!!
//  http://yerkee.com/api/fortune


//class NetworkManager {
//    func fetchAWishes(completion: ([Fortune]?) -> Void) {
//        AF.request("http://localhost:5984/rooms/_all_docs")
//            .responseData { response in
//                guard let data = response.data else { return }
//                if let wishes = try? JSONDecoder().decode(Fortune.self, from: data) {
//                    print(wishes)
//                } else {
//
//                }
//            }
//    }
//
//}
//
//
//struct MainNetworkManager: NetworkManager {
//  /// This is main method for downloading data
//  /// - Parameters:
//  ///   - url: Url to download data
//  ///   - dataModel: Any data model by which the response should be decoded
//  ///   - completionHandler: completion handler with Result type to work with downloaded data and manage possible errors
//  func downloadData<DataModel>(
//    withURL url: URL,
//    decodeBy dataModel: DataModel.Type,
//    completionHandler: @escaping (Result<DataModel, Error>
//    ) -> Void) where DataModel: Decodable, DataModel: Encodable {
//
//    let downloadQueue = DispatchQueue(label: "networkManagerQueue", qos: .utility)
//    guard ConnectionManager.isConnectedToNetwork() else {
//      let error = NetworkManagerErrors.noConnection
//      completionHandler(.failure(error))
//      return
//    }
//    downloadQueue.async {
//      let request = AF.request(url)
//      request.responseJSON { (response) in
//        if let error = response.error {
//          completionHandler(.failure(error))
//        } else {
//          guard let JSONData = response.data, let JSONResponse = response.response else { return }
//          Log.v(JSONResponse)
//          guard JSONResponse.statusCode == 200 else {
//            let error = NetworkManagerErrors.badRequest
//            completionHandler(.failure(error))
//            return
//          }
//
//          do {
//            let decodedData = try JSONDecoder().decode(dataModel.self, from: JSONData)
//            completionHandler(.success(decodedData))
//
//          } catch let error as NSError {
//            assertionFailure("NETWORK MANAGER FAILURE \(error), \(#line)")
//          }
//        }
//      }
//    }
//  }
//}

