//
//  NYCSchoolDetailsViewController.swift
//  NYCHighSchools
//
//  Created by Rambabu on 20/12/23.
//

import UIKit
import MapKit

class NYCSchoolDetailsViewController: UIViewController {
    let detailsViewModel = NYCSchoolDetailsViewModel()
    // MARK: - User interface objects
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var studentsLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    // MARK: - Lazy loading
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Times New Roman", size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - ViewController delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.satScores
        setUpContainerViewUI()
    }
    
    func setUp(_ school: School) {
        loadData(school)
    }
   
    //MARK: - Loading Data
    
    private func loadData(_ school: School) {
        // Create an async task to fetch school details,
        // and take appropriate action when fetch completes.
        Task {
            // Optionally, show a loading indicator while data is loading.
            showMessage("Loading SAT Scores for \(school.name)")
            setUpSchoolNameAndMap(school)
            
            // Fetch school SAT data.
            await detailsViewModel.fetchSchooolSATScores(school)
            
            // Act on the school data fetched.
            switch detailsViewModel.dataLoadingState {
                case .loaded:
                    // Display data
                    if let score = detailsViewModel.scores.first {
                        updateLabels(score)
                    }
                    
                case .failedToLoad:
                    // Provide retry option here.
                    showMessage("Failed to load SAT scores.")
                case .noDataFound:
                    showMessage("No data found. Try again later.")
                default:
                    print("Do nothing")
            }
        }
    }
    
    //MARK: - Interface
    
    private func setUpLoadingLabel() {
        view.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            loadingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func showMessage(_ message: String) {
        if (loadingLabel.superview == nil) {
            setUpLoadingLabel()
        }
        
        loadingLabel.isHidden = false
        loadingLabel.text = message
        containerView.isHidden = true
        map.isHidden = true
    }
    
    func setUpSchoolNameAndMap(_ school: School) {
        schoolNameLabel.text = school.name
        guard let coordinates = school.coordinates, let latitude = coordinates["latitude"], let longitude = coordinates["longitude"], let latValue = Double(latitude), let longValue = Double(longitude) else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: latValue, longitude: longValue)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let schoolAnnotation = MKPointAnnotation()
        schoolAnnotation.title = school.name
        schoolAnnotation.coordinate = center
        map.addAnnotation(schoolAnnotation)
        self.map.setRegion(region, animated: true)
    }
    
    func setUpContainerViewUI() {
        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    /**
        Updating labels content based on server data
     */
    func updateLabels(_ score: SATScore) {
        loadingLabel.isHidden = true
        containerView.isHidden = false
        map.isHidden = false
        studentsLabel.attributedText = getAttributedString("Students appeared for SAT: ", score.studentsCount)
        readingLabel.attributedText = getAttributedString("Critical reading score: ", score.readingScore)
        mathLabel.attributedText = getAttributedString("Math score: ", score.mathScore)
        writingLabel.attributedText = getAttributedString("Writing score: ", score.writingScore)
    }
    
    /*
        Creating attributed string based on static content and server response
     */
    func getAttributedString(_ header: String, _ value: String)
    -> NSAttributedString {
        let headerAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Times New Roman", size: 20)]
        let valueAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Times New Roman", size: 22)]
        
        let headerAttributedString = NSMutableAttributedString(string: header, attributes: headerAttributes as [NSAttributedString.Key : Any])
        let valueAttributedString = NSMutableAttributedString(string: value, attributes: valueAttributes as [NSAttributedString.Key : Any])
        
        headerAttributedString.append(valueAttributedString)
        return headerAttributedString
    }
}
