//
//  ScoreViewController.swift
//  SwiftPi
//
//  Created by Josselin Abel on 11/02/2021.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var modele = piModele()
    private var vue = ScoreView()
    
    @IBOutlet weak var tableZone: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        vue.tableau = modele.fillTableau()
        //print(modele.getScoreTableau[0])
        
        tableZone.dataSource = self
        tableZone.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vue.tableau.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = vue.tableau[indexPath.row]
        
        return cell
    }
}
