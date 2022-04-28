//
//  CarsTableViewController.swift
//  Cars Test App
//
//  Created by Юра Гейц on 01.04.2022.
//

import UIKit

class CarsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cars: [Car]?
    
    var counter = 0
    var timer = Timer()
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performURLRequest()
    }
    
    
    //MARK: - Timer
    private func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        counter += 1
        timerLabel.text = "Data for API updated \(counter) seconds ago..."
        if counter == 10 {
            counter = 0
            performURLRequest()
        }
    }
    
    //MARK: - URL Request func
    private func performURLRequest() {
        NetworkManager.shared.getCars()
        
        NetworkManager.shared.onCompletion = { result in
            DispatchQueue.main.async {
                self.cars = result.cars
                if self.isFiltering == true {
                    self.filter()
                    
                }
                self.tableView.reloadData()
                self.startTimer()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let carsCount = cars?.count else { return 0 }
        return isFiltering == true ? filteredCars.count : carsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarTableViewCell
        guard let cars = self.cars else { return cell }
        let car = isFiltering == true ? filteredCars[indexPath.row] : cars[indexPath.row]
        cell.configureCell(with: car)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show info about car
        print("IndexPath row \(indexPath.row)")
        guard let selectedCar = cars?[indexPath.row] else { return }
        let car = isFiltering == true ? filteredCars[indexPath.row] : selectedCar
        //show custom alert controller
        showInfo(car)
    }
    
    private func showInfo(_ selectedCar: Car) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoView = storyboard.instantiateViewController(withIdentifier: "infoStoryboard") as! InfoViewController
        infoView.car = selectedCar
        infoView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        infoView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(infoView, animated: true, completion: nil)
    }
    
    //MARK: - FilterView
    var filteredCars: [Car] = []
    var isFiltering = false
    
    var selectedFilter = "No filter"
    let filterComponents = ["No filter", "Hidden", "Available", "Disabled"]
    
    @IBAction func openFilter(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 250)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            self.selectedFilter = self.filterComponents[selectedRow]
            self.filter()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //MARK: - Filter
    private func filter() {
        filteredCars = []
        
        if selectedFilter == filterComponents[0] {
            isFiltering = false
            self.title = "All cars"
        } else {
            isFiltering = true
            print(selectedFilter)
            self.title = selectedFilter
            let selectedState = selectedFilter.lowercased()
            
            guard let cars = cars else { return }
            
            for car in cars {
                if car.state == selectedState {
                    filteredCars.append(car)
                }
            }
        }
        tableView.reloadData()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterComponents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterComponents[row]
    }
}
