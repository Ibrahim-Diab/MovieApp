//
//  UIImage.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import UIKit.UIImage


extension UIImage {
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Cannot create image source with data")
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        var duration: Double = 0.0
        
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            images.append(UIImage(cgImage: cgImage))
            
            // Add frame duration
            let frameDuration = UIImage.frameDuration(from: source, index: i)
            duration += frameDuration
        }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
    
    private class func frameDuration(from source: CGImageSource, index: Int) -> Double {
        var frameDuration = 0.1
        
        guard let frameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [String: Any],
              let gifProperties = frameProperties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
            return frameDuration
        }
        
        if let delayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? Double {
            frameDuration = delayTime
        } else if let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double {
            frameDuration = delayTime
        }
        

        if frameDuration < 0.011 {
            frameDuration = 0.1
        }
        
        return frameDuration
    }
}

