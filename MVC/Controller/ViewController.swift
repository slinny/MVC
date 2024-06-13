import UIKit

class APICallViewController: UIViewController {
    
    var records: [Result] = []
    @IBOutlet weak var recordTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        fetchData()
    }
}

extension APICallViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recordTable.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell else { return AlbumTableViewCell()}
        
        cell.updateRecord(records[indexPath.row])
        
        return cell
    }
}

// for AlbumTableViewCell
extension APICallViewController {
    fileprivate func setupTable() {
        recordTable.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumTableViewCell")
        recordTable.dataSource = self
    }
    
    fileprivate func fetchData() {
        APIManager.shared.getDataFromServer(url: Constants.URL) { data in
            guard let serverData = data else {
                return
            }
            
            if let apiResponse = try? JSONDecoder().decode(RecordModel.self, from: serverData) {
                DispatchQueue.main.async {
                    self.records = apiResponse.results
                    self.recordTable.reloadData()
                }
            }
        }
    }
}

// for RecordTableViewCell
//extension APICallViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        records.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = recordTable.dequeueReusableCell(withIdentifier: "RecordTableViewCell") as? RecordTableViewCell else { return RecordTableViewCell()}
//        
//        cell.updateRecord(records[indexPath.row])
//        
//        return cell
//    }
//}

//extension APICallViewController {
//    fileprivate func setupTable() {
//        recordTable.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
//        recordTable.dataSource = self
//    }
//    
//    fileprivate func fetchData() {
//        APIManager.shared.getDataFromServer(url: Constants.URL) { data in
//            guard let serverData = data else {
//                return
//            }
//            
//            if let apiResponse = try? JSONDecoder().decode(RecordModel.self, from: serverData) {
//                DispatchQueue.main.async {
//                    self.records = apiResponse.results
//                    self.recordTable.reloadData()
//                }
//            }
//        }
//    }
//}




