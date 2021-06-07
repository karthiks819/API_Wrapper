//
//  Loader.swift
//  demoApp
//
//  Created by ram Mobile on 9/20/17.
//  Copyright © 2017 IBC Mobile. All rights reserved.
//

import UIKit

class Loader: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        image.loadGif(name: "ajax-loader")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
