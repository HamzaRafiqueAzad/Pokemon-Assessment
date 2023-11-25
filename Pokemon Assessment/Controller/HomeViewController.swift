//
//  HomeViewController.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    var page = 0
    var pokemonArray: [Pokemon] = []
    
    let activityIndicatorView: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .gray
            indicator.hidesWhenStopped = true
            return indicator
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.tabBarController?.tabBar.isHidden = false
        userNameLabel.text = Utility.shared.getUserDetails().0
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: Constants.UICells.pokemonTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.UICells.pokemonTableViewCell)
        callPokeArrayDataApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = Utility.shared.getUserDetails().0

    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
        Utility.shared.saveUserDetails(userName: "", email: "")
    }
    
    func callPokeArrayDataApi() {
        let url = "\(Constants.Urls.pokeApi)\(page)"
        activityIndicatorView.startAnimating()
        Utility.shared.callApiWithCompletion(url: url) { response, error in
            if error == nil {
                guard let results = response?["results"] as? [[String : Any]] else { return }
                for result in results {
                    if let pokeUrl = result["url"] as? String {
                        Utility.shared.callApiWithCompletion(url: pokeUrl) { response1, error1 in
                            let pokeData = response1 ?? [:]
                            let pokemon = Pokemon(dict: pokeData)
                            self.pokemonArray.append(pokemon)
                            self.tableView.reloadData()
                            if result["name"] as? String == results[results.count-1]["name"] as? String {
                                self.activityIndicatorView.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UICells.pokemonTableViewCell, for: indexPath) as! PokemonTableViewCell
        
        let pokemon = pokemonArray[indexPath.row]
        
        cell.nameLabel.text = pokemon.name
        cell.pokeImageView.sd_setImage(with: URL(string: pokemon.image))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pokemon = pokemonArray[indexPath.row]

        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.UIViewControllers.detailsViewController) as! DetailsViewController
        detailsVC.pokemon = pokemon
        self.present(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.pokemonArray.count - 1
        if indexPath.row == lastItem {
            page += 10
            callPokeArrayDataApi()
            //Get data from Server
        }
    }
}
