//
//  APIClient.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation
import Alamofire

class APIClient: APIClientTypeProtocol {
    func performRequest<T: Decodable>(route: MedicationReminderRoute) async  -> Result<T, NetworkError> {
        let urlRequest: URLRequest
        do {
            urlRequest = try route.asURLRequest()
        } catch {
            return .failure(NetworkError.other(error.localizedDescription))
        }
        
        if let requestBody = try? JSONSerialization.data(withJSONObject: route.parameters ?? [:], options: .prettyPrinted),
           let requestBodyString = String(data: requestBody, encoding: .utf8) {
            print("Request Body:")
            print(requestBodyString)
        }
        print("URL: \(urlRequest.url?.absoluteString ?? "Invalid URL")")
        let response = await AF.request(urlRequest)
            .validate()
            .serializingDecodable(T.self)
            .response
        
        print(response.result)
        switch response.result {
        case .success(let model):
            return .success(model)
        case .failure(let error):
            return .failure(NetworkError.serverError(error.localizedDescription))
        }
    }
}
