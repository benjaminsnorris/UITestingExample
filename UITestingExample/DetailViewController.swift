//
//  DetailViewController.swift
//  UITestingExample
//
//  Created by Ben Norris on 9/18/18.
//  Copyright © 2018 Ben Norris. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Int? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

