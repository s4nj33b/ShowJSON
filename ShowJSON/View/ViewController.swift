//
//  ViewController.swift
//  ShowJSON
//
//  Created by Sanjeeb on 10/03/21.
//

import UIKit

class ViewController: UIViewController {
    static let endPointUrl = "https://cat-fact.herokuapp.com/facts"
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let network = NetworkService.shared
        let url = URL(string: ViewController.endPointUrl)!
        network.request(url: url) { [weak self] (response) in
            response.callBlocks { (error) in
                print(error)
            } successblock: { (animals) in
                print(animals)
                DispatchQueue.main.async {
                    self?.setInView(animals: animals)
                }
            }

        }
        
    }

    func setInView(animals: [Animal]) {
        var textToDisplay: String = ""
        animals.forEach { (animal) in
            textToDisplay.append( "Type: " + animal.type + "\n")
            textToDisplay.append("User: " + animal.user + "\n")
            textToDisplay.append("Text: " + animal.text + "\n")
            textToDisplay.append("Source: " + animal.source + "\n")
            textToDisplay.append("=======================\n")
        }
        
        label.text = textToDisplay
    }

    

}

extension ViewController {
    
}
