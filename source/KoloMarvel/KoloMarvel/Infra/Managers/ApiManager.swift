//
//  ApiManager.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class ApiManager: NSObject, URLSessionTaskDelegate {
    
    static let shared: ApiManager = ApiManager()
    
    var session: URLSession!
    
    override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    func getRequest(serviceURL: String, httpMethod: HttpMethod = .get) -> URLRequest {
        var request = URLRequest(url: URL(string: "\(getFullEndpointUrl(serviceUrl: serviceURL))")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    func dataTask(serviceURL: String, httpMethod: HttpMethod = .get, completion: @escaping (Data?, Error?) -> Void) {
        let request = getRequest(serviceURL: serviceURL, httpMethod: httpMethod)
        makeApiCall(serviceURL: serviceURL, request: request, completion: completion)
    }
    
    private func makeApiCall(serviceURL: String, request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let sessionTask = self.session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        sessionTask.resume()
    }
    
    func getFullEndpointUrl(serviceUrl: String) -> String {
        return (APIEndPoints.API_BASE_URL + serviceUrl).urlEncoded
    }
    
}
