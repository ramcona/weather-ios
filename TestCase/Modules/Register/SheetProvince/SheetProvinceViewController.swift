//
//  SheetProvinceViewController.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import UIKit

class SheetProvinceViewController: BaseViewController {
    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableViewData: UITableView!
    
    //variables
    private var viewModel = ProvinceViewModel()
    public var completionHandler: ((_ data:Province) -> Void)?
    private var cellName = "dataCell"
    private var listData:[Province] = [Province]()
    private var listDataFiltered:[Province] = [Province]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupData()
        observeState()
        action()
    }
    
    private func setupData() {
        listDataFiltered = listData
        
        tableViewData.reloadData()
        
        viewModel.fetch()
    }
    
    private func action() {
        
        tableViewData.addRefreshControl {
            self.viewModel.fetch()
            self.tableViewData.endRefreshing()
        }
        
        textFieldSearch.onChanged { value in
            
            if let value = value, value.isNotEmpty {
                self.listDataFiltered.removeAll()
                self.listData.forEach({ data in
                    if data.name.lowercased().contains(value.lowercased()) {
                        self.listDataFiltered.append(data)
                    }
                })
                self.tableViewData.reloadData()
                
            }else {
                self.listDataFiltered.removeAll()
                self.listDataFiltered.append(contentsOf: self.listData)
                self.tableViewData.reloadData()
            }
        }
    }
    
    private func setupView() {
        tableViewData.dataSource = self
        tableViewData.delegate = self
        tableViewData.register(UITableViewCell.self, forCellReuseIdentifier: cellName)
        
        //        tableViewData.separatorStyle = .none
        tableViewData.reloadData()
    }
    
    private func observeState() {
        // Observe state changes
        viewModel.stateDidChange = {[self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    //handling loading view
                    self.showLoadingView()
                    break
                    
                case .success(let datas): //.success(let data)
                    //handling success data
                    self.removeLoadingView()
                    self.listData = datas ?? [Province]()
                    self.listDataFiltered = self.listData
                    self.tableViewData.reloadData()
                    
                case .failure(let error):
                    //handle when failure
                    self.removeLoadingView()
                    self.showErrorAlert(message: error)
                    
                    break
                    
                case .none:
                    //when have nothing
                    break
                }
            }
        }
    }
}

extension SheetProvinceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listDataFiltered.isEmpty {
            tableView.setEmptyView(image: UIImage(named: "icEmpty")!, title: "Tidak ada data tersedia")
        }else {
            tableView.restore()
        }
        return listDataFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        //Default Content Configuration
        var content = cell.defaultContentConfiguration()
        content.text = listDataFiltered[indexPath.item].name
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = listDataFiltered[indexPath.row]
        
        self.completionHandler?(data)
        self.dismiss(animated: true)
    }
    
    
}
