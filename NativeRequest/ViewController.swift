//
//  ViewController.swift
//  NativeRequest
//
//  Created by Abigail Zoe Magaña on 04/02/23.
//

import UIKit

class ViewController: UIViewController {
    var personaje: Result?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var species: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let unwrappedObject = personaje{
        let stringUrl = unwrappedObject.image
        guard let url = URL(string: stringUrl) else {return}
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request){ data, response, error in
                if error == nil{
                    guard let data = data else {return}
                    DispatchQueue.main.async {
                        self.image.image = UIImage(data: data)
                        self.name.text = unwrappedObject.name
                        self.status.text = unwrappedObject.status.rawValue
                        self.species.text = unwrappedObject.species.rawValue
                        self.gender.text = unwrappedObject.gender.rawValue
                    }
                }
            }
            task.resume()
        }

    }


}

/**if let stringURL = object?.image, let url = URL(string: stringURL) {
 
 let configuration = URLSessionConfiguration.default
 let session = URLSession(configuration: configuration)
 let request = URLRequest(url: url)
 let task = session.dataTask(with: request) { data, response, error in
     if error == nil {
         guard let data = data else { return }
         DispatchQueue.main.async {
             self.image.image = UIImage(data: data)
         }
     }
 }
 task.resume()*/
