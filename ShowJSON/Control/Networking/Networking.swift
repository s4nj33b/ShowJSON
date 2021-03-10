//
//  Networking.swift
//  ShowJSON
//
//  Created by Sanjeeb on 10/03/21.
//

import Foundation


public class NetworkService: NSObject {
   
    public static let shared = NetworkService()
    var session: URLSession
    private override init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        super.init()
    }

    func request(url: URL, response: @escaping ResponseBlock<[Animal]>) {
        session.dataTask(with: url) { data, responseV, error in
            if let data = data {
                do {
                   let animals = try JSONDecoder().decode([Animal].self, from: data)
                    response(.object(value: animals))
                } catch let error {
                    response(.error(value: error))
                }
             }
         }.resume()
        
    }

}

public enum Response<T: Any> {
    case object(value: T)
    case error(value: Error)
    
    public func callBlocks(error errorBlock: (Error) -> (), successblock: (T) throws -> ()) {
        do {
            switch self {
            case .error(let value):
                throw value
            case .object(let value):
                try successblock(value)
            }
        } catch {
            errorBlock(error)
        }
    }
}

public typealias ResponseBlock<T: Any> = (Response<T>) -> ()
