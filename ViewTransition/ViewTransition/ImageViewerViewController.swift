//
//  ImageViewerViewController.swift
//  ViewTransition
//
//  Created by Fábio Salata on 14/11/19.
//  Copyright © 2019 Fábio Salata. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
    }

}
