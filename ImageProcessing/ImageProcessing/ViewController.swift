//
//  ViewController.swift
//  ImageProcessing
//
//  Created by taehy.k on 2022/05/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originImage = UIImage(named: "sunrise")
        let thumbnail = originImage?.preparingThumbnail(of: CGSize(width: 1000, height: 500))
        
        imageView.image = originImage
    }

}

