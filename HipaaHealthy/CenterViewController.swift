//
//  CenterViewController.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/4/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit

protocol CenterViewControllerDelegate: class {
    
    func toggleLeftPanel()
}

class CenterViewController: UIViewController {

    weak var delegate: CenterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleLeftPanelButton(_ sender: Any) {
        self.delegate?.toggleLeftPanel()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
