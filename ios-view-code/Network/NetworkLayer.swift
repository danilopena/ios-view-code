//
//  NetworkLayer.swift
//  ios-swiftui-project
//
//  Created by Danilo Pena on 27/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
public typealias ErrorHandler = (String) -> Void

open class NetworkLayer {
    static let genericError = "Ops! Something went wrong. Please try again later."

    public init() {}

    open func get<T: Decodable>(urlString: String,
                                headers: [String: String] = [:],
                                successHandler: @escaping (T) -> Void,
                                errorHandler: @escaping ErrorHandler) {

        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(NetworkLayer.genericError)
                return
            }

            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(NetworkLayer.genericError)
                }
                do {
                    let test = try JSONDecoder().decode(T.self, from: data)
                    successHandler(test)
                    return
                } catch {
                    print(error.localizedDescription)
                    errorHandler(NetworkLayer.genericError)
                }
            }
        }

        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }

    open func post<T: Encodable>(urlString: String,
                                 body: T,
                                 headers: [String: String] = [:],
                                 errorHandler: @escaping ErrorHandler) {

        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(NetworkLayer.genericError)
                return
            }

            if !self.isSuccessCode(urlResponse) {
                errorHandler(NetworkLayer.genericError)
                return
            }
        }

        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 90
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        guard let data = try? JSONEncoder().encode(body) else {
            return errorHandler("Cannot encode given object into Data")
        }
        request.httpBody = data
        URLSession.shared
            .uploadTask(with: request,
                        from: data,
                        completionHandler: completionHandler)
            .resume()
    }

    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }

    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}

extension NetworkLayer {
    enum Constants {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
}
