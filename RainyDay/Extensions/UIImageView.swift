//
//  UIImageView.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/09/14.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(url: String) {
        
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(url)@2x.png") else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        Network.downloadImageData(from: url, completion: { data, error in
            
            if let data = data as? Data {
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: url as AnyObject)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "noImage")
                }
            }
        })
    }
}
