import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    var record: Result?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension RecordTableViewCell {
    func updateData() {
        if let record = record {
            artistLabel.text = "artist: \(record.artistName)"
            countryLabel.text = "country: \(record.country.rawValue)"
            priceLabel.text = "price: $\(record.collectionPrice.description)"
            genreLabel.text = "genre: \(record.primaryGenreName)"
        }
    }
    
    func updateRecord(_ record: Result) {
        self.record = record
        updateData()
    }
}
