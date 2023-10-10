//
//  Network.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

class Network: Networkable {
    
    func networkGet(request: WeatherForecastRequest) async throws -> Any {
        
        let request = getMutableURLRequest(lat: request.lat ?? 0, long: request.long ?? 0, cnt: request.cnt ?? 0, apiKey: Constants.apiKey)
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
    
    public static func downloadImageData(from icon: String, completion: @escaping (Any?, Error?) -> Void) {
        
        let request = URLRequest(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if (error == nil) {
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        })
        dataTask.resume()

    }
    
    
    //MARK: - URL
    private func getMutableURLRequest(lat: Double, long: Double, cnt: Int, apiKey: String) -> NSMutableURLRequest {
        return NSMutableURLRequest(url: NSURL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&cnt=\(cnt)&appid=\(apiKey)")! as URL,
                                   cachePolicy: .useProtocolCachePolicy,
                                   timeoutInterval: 10.0)
    }
}

