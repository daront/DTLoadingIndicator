//
//  FullScreenLoadingViewController.swift
//  DTLoadingIndicator
//
//  Created by Daron Tancharoen on 7/26/16.
//  Copyright © 2016 daront. All rights reserved.
//

import UIKit

class FullScreenLoadingViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startLoading()
        self.perform(#selector(FullScreenLoadingViewController.stopLoading), with: nil, afterDelay: 3)
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }

    func startLoading() {
        self.label.text = "Loading..."
        let _ = DTLoadingIndicator.startGiftFullScreenLoadingIndicator()
    }
    
    func stopLoading() {
        self.label.text = "Loaded"
        DTLoadingIndicator.stopFullScreenLoadingIndicator()
    }
}
