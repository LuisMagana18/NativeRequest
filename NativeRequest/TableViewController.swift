//
//  TableViewController.swift
//  NativeRequest
//
//  Created by Abigail Zoe Magaña on 04/02/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    var objects = [Result] ()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Consultar API y serializar el JSON
        guard let laUrl = URL(string: "https://rickandmortyapi.com/api/character") else {return}
        do{
            let bytes = try Data(contentsOf: laUrl)
            let rickAndMorty = try? JSONDecoder().decode(RickAndMorty.self, from: bytes)
            objects = rickAndMorty!.results
            self.tableView.reloadData()
        }catch{
            print("Error al descargar el JSON: " + String(describing: error))
        }
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "https://rickandmortyapi.com/api/character") {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { jsondata, response, error in
                if error == nil {
                    guard let jsonData = try? Data(contentsOf: url) else { return }
                    let rickAndMorty = try? JSONDecoder().decode(RickAndMorty.self, from: jsonData)
                    guard let rickAndMorty = rickAndMorty else { return }
                    self.objects = rickAndMorty.results
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let personaje = objects[indexPath.row]
        cell.textLabel?.text = personaje.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "show"){
                let detailViewControler = segue.destination as! ViewController
                guard let indexPath = tableView.indexPathForSelectedRow else {return}
                var personaje = objects[indexPath.row]
                detailViewControler.personaje = personaje
            }
        }

    

}
