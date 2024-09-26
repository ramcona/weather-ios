//
//  DashboardViewController.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import UIKit

class DashboardViewController: BaseViewController {
    
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var imageViewUpdateProfileData: UIImageView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCurrentTemp: UILabel!
    @IBOutlet weak var imageViewCurrentWeather: UIImageView!
    @IBOutlet weak var tableViewForecaseWeather: TableViewAdjustedHeight!
    
    //Variables
    private var currentWeatherViewModel = CurrentWeatherViewModel()
    private var forecaseWeatherViewModel = ForecaseWeatherViewModel()
    private var cityName = ""
    
    private var forecaseCellName = ItemTableViewCell.className
    private var listForecases:[WeatherResponse] = [WeatherResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionView()
        setupView()
        setupUserData()
        observeState()
        fetchData()
    }
    
    private func setupView() {
        tableViewForecaseWeather.dataSource = self
        tableViewForecaseWeather.delegate = self
        tableViewForecaseWeather.separatorStyle = .none
        tableViewForecaseWeather.register(UINib(nibName: forecaseCellName, bundle: nil), forCellReuseIdentifier: forecaseCellName)
        tableViewForecaseWeather.reloadData()
    }
    
    private func actionView() {
        mainScrollView.addRefreshControl {
            self.fetchData()
            self.setupUserData()
            self.mainScrollView.endRefreshing()
        }
    }
    
    private func fetchData() {
        currentWeatherViewModel.fetch(cityName: cityName)
        forecaseWeatherViewModel.fetch(cityName: cityName)
    }
    
    private func setupUserData() {
        if let user = userDefaultManager.getUser() {
            labelName.text = "Selamat \(getTimeOfDay()), \(user.name)"
            labelLocation.text = "\(user.province?.name ?? "-"), \(user.city?.name ?? "-")"
            cityName = replaceKotaAndKabupaten(in: user.city?.name ?? "")
            
        }else {
            labelName.text = "-"
            labelLocation.text = "-"
        }
    }
    
    func replaceKotaAndKabupaten(in text: String) -> String {
        var modifiedText = text
        modifiedText = modifiedText.replacingOccurrences(of: "KOTA ", with: "")
        modifiedText = modifiedText.replacingOccurrences(of: "KABUPATEN ", with: "")
        
        return modifiedText
    }
    
    private func setCurrentWeatherData(data: WeatherResponse) {
        if let main = data.main {
            labelCurrentTemp.text = main.temp.kelvinToCelsiusString()
        }else {
            labelCurrentTemp.text = "0"
        }
        
        if !data.weather.isEmpty {
            if let weather = data.weather.first {
                labelWeather.text = weather.main
                let imageUrl = "https://openweathermap.org/img/wn/\(weather.icon)@2x.png"
                imageViewCurrentWeather.loadImage(fromURLString: imageUrl)
            }
        }
        
    }
    
    func getTimeOfDay() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        switch currentHour {
        case 6..<11:
            return "Pagi"
        case 11..<13:
            return "Siang"
        case 13..<19:
            return "Sore"
        default:
            return "Malam"
        }
    }
    
    private func observeState() {
        // Observe state changes
        currentWeatherViewModel.stateDidChange = {[self] state in
            DispatchQueue.main.async {
                switch state {
                    
                case .loading :
                    self.showLoadingView()
                    break
                    
                case .success(let datas):
                    self.removeLoadingView()
                    if let data = datas {
                        self.setCurrentWeatherData(data: data)
                    }

                    
                case .failure(let error):
                    self.removeLoadingView()
                    self.showErrorAlert(message: error)
                    
                    break
                    
                case .none:
                    //when have nothing
                    break
                }
            }
        }
        
        // Observe state changes
        forecaseWeatherViewModel.stateDidChange = {[self] state in
            DispatchQueue.main.async {
                switch state {
                    
                case .loading :
                    break
                    
                case .success(let datas):
                    self.listForecases = datas?.list ?? [WeatherResponse]()
                    self.tableViewForecaseWeather.reloadData()
                    break

                    
                case .failure(_ ):
                    break
                    
                case .none:
                    break
                }
            }
        }
    }
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listForecases.isEmpty {
            tableView.setEmptyView(image: UIImage(named: "icEmpty")!, title: "Tidak ada data tersedia")
        }else {
            tableView.restore()
        }
        return listForecases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecaseCellName, for: indexPath) as! ItemTableViewCell
        let data = listForecases[indexPath.row]
        
        cell.setData(data: data)
        
      
        return cell
    }
    
    
}
