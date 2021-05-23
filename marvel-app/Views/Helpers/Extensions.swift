//
//  Extensions.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 21/5/21.
//
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadCachedImageWithUrlString (urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        
                        self.image = downloadedImage
                    }
                }
            }.resume()
        }
    }
}
