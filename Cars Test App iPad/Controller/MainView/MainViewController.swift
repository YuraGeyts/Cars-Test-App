//
//  MainViewController.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 06.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var carsTableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    //Filter
    var cars: [Car]?
    var filteredCars: [Car] = []
    var isFiltering = false
    
    var selectedFilter = "No filter"
    var filterComponents = ["No filter", "Hidden", "Available", "Disabled"]
    
    //Timer
    var counter = 0
    var timer = Timer()
    @IBOutlet weak var timerLabel: UILabel!
    private let urlString = "http://filehost.feelsoftware.com/jsonplaceholder/cars-api.php"
    
    //Video
    let firstVideoURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4"
    let secondVideoURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4"
    var firstVideoView = VideoPlayerViewController()
    var secondVideoView = VideoPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !LoginManager.isLogged {
            LoginManager.checkLogin(vc: self)
        } else {
            getAndShowUserLogin()
            performURLRequest()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let embededVC = segue.destination as! VideoPlayerViewController
        
        if segue.identifier == "firstPlayerSegue" {
            embededVC.videoURL =  firstVideoURL
            embededVC.playerName = "Front camera"
        } else if segue.identifier == "secondPlayerSegue" {
            embededVC.videoURL = secondVideoURL
            embededVC.isMuted = true
            embededVC.playerName = "Rear camera"
        }
    }
    
    //MARK: - URL Request
    func performURLRequest() {
        NetworkManager.shared.performRequest(withURLString: urlString)
        
        NetworkManager.shared.onCompletion = { result in
            DispatchQueue.main.async {
                self.cars = result.cars
                if self.isFiltering == true {
                    self.filter()
                }
                self.startTimer()
                self.carsTableView.reloadData()
            }
        }
    }
    
    @IBAction func openFilterAction(_ sender: Any) {
        openFilter()
    }
    
    
    //MARK: - Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        counter += 1
        timerLabel.text = "Data for API updated \(counter) seconds ago..."
        if counter == 10 {
            stopTimer()
            performURLRequest()
        }
    }
    
    func stopTimer() {
        counter = 0
        timer.invalidate()
    }
    
    
}
