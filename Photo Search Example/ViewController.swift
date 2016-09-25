//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Daniel Cleaves on 9/24/16.
//  Copyright © 2016 Daniel Cleaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var UiScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 
        
        let manager = AFHTTPSessionManager()
        
        let searchParameters = ["method": "flickr.photos.search",
                                "api_key": "bdbe0deceb8a1639505830d210b6dcea",
                                "format": "json",
                                "nojsoncallback": 1,
                                "text": "dogs",
                                "extras": "url_m",
                                "per_page": 5]
        
        manager.GET("https://api.flickr.com/services/rest/",
                    parameters: searchParameters,
                    progress: nil,
                    success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let responseObject = responseObject {
                            print("Response: " + responseObject.description)
                            if let photos = responseObject["photos"] as? [String: AnyObject] {
                            if let photoArray = photos["photo"] as? [[String: AnyObject]] {
                            for (i,photoDictionary) in photoArray.enumerate() {
                                if let imageURLString = photoDictionary["url_m"] as? String {
                                    let imageData = NSData(contentsOfURL: NSURL(string: imageURLString)!)
                                    if let imageDataUnwrapped = imageData {
                                        let imageView = UIImageView(image: UIImage(data: imageDataUnwrapped))
                                        imageView.frame = CGRect(x: 0, y: 320 * CGFloat(i), width: 320, height: 320)
                                        self.scrollView.addSubview(imageView)
                                    }
                                }
                            }
                        }
                            }
                        }
            },
                    failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

