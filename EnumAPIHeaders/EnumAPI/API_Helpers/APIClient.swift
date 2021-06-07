//
//  APIClient.swift
//  EnumAPIHeaders
//
//  Created by Karthik on 06/06/21.
//

import Foundation
import Alamofire

enum APIError: Error {
    
    //typealias RawValue = Int

    case apiError(message: String)

}

class APIClient {
    
    static var defaultJSONDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return decoder
    }
    
    @discardableResult
    static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = defaultJSONDecoder, completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder) { (response: AFDataResponse<T>) in
                completion(response.result)
            }
    }
    
    @discardableResult
    static func performRequest(route:APIRouter, completion:@escaping (Result<String, AFError>)->Void) -> DataRequest {
        
        print("URL--->>\(String(describing: route.urlRequest))")
        return AF.request(route)
            .responseString { response in
                completion(response.result)
            }
    }
    
    @discardableResult
    static func performRequestWithStatusCode(route:APIRouter, completion:@escaping (Result<String, AFError>,Int)->Void) -> DataRequest {
        return AF.request(route)
            .responseString { response in
                completion(response.result,response.response?.statusCode ?? 401)
            }
    }

    @discardableResult
    static func performDownload(route:APIRouter, completion:@escaping (Data?, Error?)->Void) -> DownloadRequest {
        AF.download(route).responseData { response in
            if let data = response.value {
                completion(data, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    @discardableResult
    static func performUpload(route:APIRouter, completion:@escaping (Result<String, AFError>,Int)->Void) -> DataRequest {
        
        AF.upload(multipartFormData: route.multipartFormData, with: route).uploadProgress(closure: { (progress) in
            print("Progress\(progress)")
         })
        .responseString { response in
            completion(response.result,response.response?.statusCode ?? 401)
        }
//        AF.upload(multipartFormData: {
//            multipartFormData in
//            if let urlString = urlBase2 {
//                let pdfData = try! Data(contentsOf: urlString.asURL())
//                var data : Data = pdfData
//
//                multipartFormData.append(data, withName: "pdfDocuments", fileName: "test.pdf", mimeType: "application/pdf")
//                for (key, value) in body {
//                    multipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
//                }
//
//                print("Multi part Content -Type")
//                print(multipartFormData.contentType)
//                print("Multi part FIN ")
//                print("Multi part Content-Length")
//                print(multipartFormData.contentLength)
//                print("Multi part Content-Boundary")
//                print(multipartFormData.boundary)
//            }
//        }, with: route).responseString { response in
//            completion(response.result,response.response?.statusCode ?? 401)
//        }
    }
    
    // MARK: - Background Drawing
    
    // MARK: - Equipment
    
    // MARK: - Bus
    
    // MARK: - Switch
    
    // MARK: - AST
    
    // MARK: - Wire

    // MARK: - Lock

    // MARK: - Connection
    
    // MARK: - Activity Log

    
    
}


extension APIClient {
    static func login(email: String, password: String, deviceId: String, completion:@escaping (Result<String, AFError>)->Void) {
        performRequest(route: .login(email: email, password: password, deviceId: deviceId), completion: completion)
    }
    
    
    static func getRSS(pageNo:Int, completion:@escaping (Result<RSSFeedResponseModel, AFError>)->Void) {
        performRequest(route: .getRSSFeedPosts(posts: pageNo), completion: completion)
    }
}
