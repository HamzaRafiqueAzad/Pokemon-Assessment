//
//  DetailsViewController.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var pokeImageView: UIImageView!
    
    @IBOutlet weak var abilitiesTableView: UITableView!
    @IBOutlet weak var movesTableView: UITableView!
    
    @IBOutlet weak var abilitiesHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movesHeightConstraint: NSLayoutConstraint!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abilitiesTableView.register(UINib(nibName: Constants.UICells.detailsTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.UICells.detailsTableViewCell)
        movesTableView.register(UINib(nibName: Constants.UICells.detailsTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.UICells.detailsTableViewCell)
        // Do any additional setup after loading the view.
        nameLabel.text = pokemon?.name
        pokeImageView.sd_setImage(with: URL(string: pokemon?.image ?? ""))
        
        let abilityTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(abilitiesExpandCollapsePressed(tapGestureRecognizer:)))
        abilitiesLabel.isUserInteractionEnabled = true
        abilitiesLabel.addGestureRecognizer(abilityTapGestureRecognizer)
        
        let moveTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(movesExpandCollapsePressed(tapGestureRecognizer:)))
            movesLabel.isUserInteractionEnabled = true
            movesLabel.addGestureRecognizer(moveTapGestureRecognizer)
        
        self.abilitiesTableView.reloadData()
        self.movesTableView.reloadData()
        
    }
    
    
    @objc func abilitiesExpandCollapsePressed(tapGestureRecognizer: UITapGestureRecognizer) {
        
        // Your action
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            if self.abilitiesHeightConstraint.constant == 0 {
                self.abilitiesLabel.text = "Abilities ↑"
                self.abilitiesHeightConstraint.constant = 150
            } else {
                self.abilitiesLabel.text = "Abilities ↓"
                self.abilitiesHeightConstraint.constant = 0
            }
        })
        
    }
    
    @objc func movesExpandCollapsePressed(tapGestureRecognizer: UITapGestureRecognizer) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            if self.movesHeightConstraint.constant == 0 {
                self.movesLabel.text = "Moves ↑"
                self.movesHeightConstraint.constant = 335
            } else {
                self.movesLabel.text = "Moves ↓"
                self.movesHeightConstraint.constant = 0
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.abilitiesTableView {
            return pokemon?.abilities.count ?? 0
        } else if tableView == self.movesTableView {
            return pokemon?.moves.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UICells.detailsTableViewCell, for: indexPath) as! DetailsTableViewCell
        
        if tableView == self.abilitiesTableView {
            let ability = pokemon?.abilities[indexPath.row]
            
            cell.nameLabel.text = ability?.name
            
        } else if tableView == self.movesTableView {
            let move = pokemon?.moves[indexPath.row]
            
            cell.nameLabel.text = move?.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
