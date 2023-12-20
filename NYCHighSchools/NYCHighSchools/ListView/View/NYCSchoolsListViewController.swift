//
//  NYCSchoolsListViewController.swift
//  NYCHighSchools
//
//  Created by Rambabu on 20/12/23.
//

import UIKit

class NYCSchoolsListViewController: UIViewController {
    
    // MARK: - User interface objects
    @IBOutlet weak var tableView: UITableView!
    
    var schoolsListViewModel = NYCSchoolsListViewModel()
    
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        loadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        self.navigationItem.title = Constants.nycSchoolsList
    }
    
    //MARK: - Initial Methods
    
    private func initialSetup() {
        tableView.rowHeight =  UITableView.automaticDimension
    }
    
    //MARK: - Loading Data
    
    private func loadData() {
        
        if !Reachability.isConnectedToNetwork() {
            self.displayNetworkFailureAlert()
            return
        }
        // Create an async task to fetch schools data,
        // and takes appropriate action when fetch completes.
        Task {
            // Optionally, show a loading indicator while data is loading.
            showMessage("Loading...")
            
            // Fetch schools.
            await schoolsListViewModel.fetchSchools()
            
            // Act on the school data fetched.
            switch schoolsListViewModel.dataLoadingState {
                case .loaded:
                    setUpSchoolsTableView()
                case .failedToLoad:
                    // Provide retry option here.
                    showMessage("Failed to load schools data.")
                case .noDataFound:
                    showMessage("No data found.")
                default:
                    print("Do nothing")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "showSchoolDetails" {
            guard let schoolDetailsViewController = segue.destination as? NYCSchoolDetailsViewController, let indexPath = tableView.indexPathForSelectedRow, let school: NYCSchool = schoolsListViewModel.school(indexPath.row, cityIndex: indexPath.section) else {
                return
            }
            schoolDetailsViewController.setUp(school)
        }
    }
    
    //MARK: - Interface
    
    private func setUpSchoolsTableView() {
        
        if (tableView.superview == nil) {
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
            ])
        }
        
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func showMessage(_ message: String) {
        tableView.isHidden = true
       
    }
}
// MARK: - TableView DataSource Methods

extension NYCSchoolsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schoolsListViewModel.numberOfCities() == 0 ? 1 : schoolsListViewModel.numberOfCities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if schoolsListViewModel.numberOfCities() == 0 {
            tableView.setFallbackView(withTitle: "Oops!",withText: "No Schools found")
            return 0
        }
        return schoolsListViewModel.numberOfSchoolsInCity(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let school: NYCSchool = schoolsListViewModel.school(indexPath.row, cityIndex: indexPath.section),
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SchoolsListTableViewCell.self), for: indexPath) as? SchoolsListTableViewCell else { return UITableViewCell() }
        
        cell.setUp(school)
        return cell
    }
}

