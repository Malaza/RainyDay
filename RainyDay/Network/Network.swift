//
//  Network.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

public enum NetworkError: Error {
    case failed
}

class Network: Networkable {
    
    func networkGet(request: WeatherForecastRequest) async throws -> Any {
        
        let request = getURLRequest(lat: request.lat ?? 0, long: request.long ?? 0, cnt: request.cnt ?? 0, apiKey: Constants.apiKey)
        request.httpMethod = "GET"
        
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                if (error != nil) {
                    continuation.resume(throwing: error!)
                }
                else {
                    guard let result = data else {
                        fatalError("Expected non-nil result in the non-error case")
                    }
                    continuation.resume(returning: result)
                }
            })
            dataTask.resume()
        }
    }
    
    //MARK: - URL
    private func getURLRequest(lat: Double, long: Double, cnt: Int, apiKey: String) -> NSMutableURLRequest {
        return NSMutableURLRequest(url: NSURL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&cnt=\(cnt)&appid=\(apiKey)")! as URL,
                                   cachePolicy: .useProtocolCachePolicy,
                                   timeoutInterval: 10.0)
    }
}
