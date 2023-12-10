//
//  SearchCruiseViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-05.
//

import UIKit

class SearchCruiseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    let backgroundImageView = UIImageView()

    @IBOutlet weak var cruiseTableView: UITableView!
    var cruiseList = [Cruise]()
    var filteredCruises = [Cruise]()
    let searchController = UISearchController()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        initList()
        initSearchController()

        

        // Do any additional setup after loading the view.
    }
    
    func initSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles =  ["All", "Bahamas", "Star", "Coral Reef", "Blue Mist", "Sea Queen"]
       
        searchController.searchBar.delegate = self
    }
    
    // Hardcoded list of Cruises with their pictures and IDs
    
    
    func initList() {
        let bahamas = Cruise(id: "0", name: "Bahamas 1", imageName: "001_resized", details: "Embark on a tropical odyssey to the Bahamas, where sun-kissed beaches and azure waters await your every desire.", ratings: "five")
        cruiseList.append(bahamas)
        
        let Caribbean = Cruise(id: "1", name: "Star 1", imageName: "002_resized" , details: "Experience the epitome of luxury aboard the Star cruise, where every moment is a shining constellation of comfort and elegance.", ratings: "five" )
        cruiseList.append(Caribbean)
        
        let Cuba = Cruise(id: "2", name: "Coral Reef 1", imageName: "003_resized" , details: "Dive into the vibrant world of the Coral Reef cruise, where adventure meets serenity beneath the waves of breathtaking marine wonders.", ratings: "four")
        cruiseList.append(Cuba)
        
        let Sampler = Cruise(id: "3", name: "Blue Mist 1", imageName: "004_resized",  details: "Sail through the enchanting allure of the Blue Mist cruise, where mystery and relaxation blend seamlessly in a sea of tranquility.", ratings: "five")
        cruiseList.append(Sampler)
        
        let star = Cruise(id: "4", name: "Sea Queen 1", imageName: "005_resized",  details:  "Set sail with the majestic Sea Queen, a cruise fit for royalty, promising grandeur, sophistication, and endless nautical allure.", ratings: "four")
        cruiseList.append(star)
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive)
        {
            return filteredCruises.count
        }
        return cruiseList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cruiseViewCell = tableView.dequeueReusableCell(withIdentifier: "cruiseViewCellID") as! SearchCruiseCell
        
        let thisCruise : Cruise!
        if (searchController.isActive)
        {
            thisCruise = filteredCruises[indexPath.row]
        }
        else
        {
            thisCruise = cruiseList[indexPath.row]

        }
        cruiseViewCell.cruiseName.text = thisCruise.id + " " + thisCruise.name
        cruiseViewCell.cruiseImage.image = UIImage(named: thisCruise.imageName)
        
        return cruiseViewCell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            self.performSegue(withIdentifier: "detailSegue", sender: self)
//        let controller = storyboard?.instantiateViewController(withIdentifier: "CruiseDetails") as! CruiseViewDetails
//
//        controller.title = "Cruise Details"
//        self.navigationController?.pushViewController(controller, animated: true)

        
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "detailSegue")
        {
            let indexPath = self.cruiseTableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? CruiseViewDetails
            
            let  selectedCruise : Cruise!
            
            if(searchController.isActive)
            {
                selectedCruise = filteredCruises[indexPath.row]
            }
            else
            {
                selectedCruise = cruiseList[indexPath.row]
            }
            tableViewDetail!.selectedCruise = selectedCruise
            
            self.cruiseTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
        
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All")
    {
        filteredCruises = cruiseList.filter
        {
            shape in
            let scopeMatch = (scopeButton == "All" || shape.name.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = shape.name.lowercased().contains(searchText.lowercased())
                
                return scopeMatch && searchTextMatch
            }
            else
            {
                return scopeMatch
            }
        }
        cruiseTableView.reloadData()
    }
    
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "teal_background3")
        view.sendSubviewToBack(backgroundImageView)
    }
    
}
