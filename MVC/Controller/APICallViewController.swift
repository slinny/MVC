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

extension APICallViewController {
    fileprivate func setupTable() {
        recordTable.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumTableViewCell")
        recordTable.dataSource = self
    }
    
    fileprivate func fetchData() {
        APIManager.shared.getDataFromServer(Constants.URL.rawValue) { (apiResponse: RecordModel?) in
            if let result = apiResponse {
                DispatchQueue.main.async {
                    self.records = result.results
                    self.recordTable.reloadData()
                }
            } else {
                print("Failed to fetch or decode data")
            }
        }
    }
}




