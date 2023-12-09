//
//  SearchCruiseViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-05.
//

import UIKit

class SearchCruiseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let backgroundImageView = UIImageView()

    
    @IBOutlet weak var cruiseTableView: UITableView!
    var cruiseList = [Cruise]()
    var filteredCruises = [Cruise]()
    let searchController = UISearchController()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
        setBackground()
        

        // Do any additional setup after loading the view.
    }
    
    // Hardcoded list of Cruises with their pictures and IDs
    
    func initList() {
        let bahamas = Cruise(id: "0", name: "Bahamas 1", imageName: "001_resized")
        cruiseList.append(bahamas)
        
        let Caribbean = Cruise(id: "1", name: "Caribbean 1", imageName: "002_resized")
        cruiseList.append(Caribbean)
        
        let Cuba = Cruise(id: "2", name: "Cuba 1", imageName: "003_resized")
        cruiseList.append(Cuba)
        
        let Sampler = Cruise(id: "3", name: "Sampler 1", imageName: "004_resized")
        cruiseList.append(Sampler)
        
        let star = Cruise(id: "4", name: "star 1", imageName: "005_resized")
        cruiseList.append(star)
        
        let bahamas2 = Cruise(id: "5", name: "Bahamas 2", imageName: "006_resized")
        cruiseList.append(bahamas2)
        
        let Caribbean2 = Cruise(id: "6", name: "Caribbean 2", imageName: "007_resized")
        cruiseList.append(Caribbean2)
        
        let Cuba2 = Cruise(id: "7", name: "Cuba 2", imageName: "008_resized")
        cruiseList.append(Cuba2)
        
        let Sampler2 = Cruise(id: "8", name: "Sampler 2", imageName: "009_resized")
        cruiseList.append(Sampler2)
        
        let star2 = Cruise(id: "9", name: "star 2", imageName: "010_resized")
        cruiseList.append(star2)
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cruiseList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cruiseViewCell = tableView.dequeueReusableCell(withIdentifier: "cruiseViewCellID") as! SearchCruiseCell
        
        let thisCruise = cruiseList[indexPath.row]
        
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
