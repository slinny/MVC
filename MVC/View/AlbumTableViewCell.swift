import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumPic: UIImageView!
    @IBOutlet weak var albumDes: UILabel!
    @IBOutlet weak var albumPrice: UILabel!
    
    var record: Result?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customizePriceLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AlbumTableViewCell {
    func updateRecord(_ record: Result) {
        self.record = record
        updateData()
    }
    
    func updateData() {
        if let record = record {
            loadImageFromUrl(urlString: record.artworkUrl60) { image in
                DispatchQueue.main.async {
                    if let image = image {
                        self.albumPic.image = image
                    } else {
                        // Handle the case where image loading fails
                    }
                }
            }
            
            let attributedText = NSMutableAttributedString()
            customizeAlbumDescription(record, attributedText)
            albumDes.attributedText = attributedText
            
            albumPrice.text = "   $\(record.collectionPrice)"
        }
    }
    
    func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    fileprivate func customizePriceLabel() {
        albumPrice.layer.borderWidth = 1.0
        albumPrice.layer.borderColor = UIColor.systemBlue.cgColor
        albumPrice.layer.cornerRadius = 5.0
        albumPrice.clipsToBounds = true
    }
    
    fileprivate func customizeAlbumDescription(_ record: Result, _ attributedText: NSMutableAttributedString) {
        let genre = "\(record.primaryGenreName)"
        let otherInfo = "\n\(record.artistName) - \(record.primaryGenreName) - \(record.wrapperType)"
        
        var firstLineAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15)
        ]
        
        let firstLineParagraphStyle = NSMutableParagraphStyle()
        firstLineParagraphStyle.lineBreakMode = .byWordWrapping
        firstLineParagraphStyle.maximumLineHeight = 2
        firstLineAttributes[.paragraphStyle] = firstLineParagraphStyle
        
        var otherLinesAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        let otherLinesParagraphStyle = NSMutableParagraphStyle()
        otherLinesParagraphStyle.lineBreakMode = .byTruncatingTail
        otherLinesAttributes[.paragraphStyle] = otherLinesParagraphStyle
        
        let firstLineAttributedString = NSAttributedString(string: genre, attributes: firstLineAttributes)
        let otherLinesAttributedString = NSAttributedString(string: otherInfo, attributes: otherLinesAttributes)
        
        attributedText.append(firstLineAttributedString)
        attributedText.append(otherLinesAttributedString)
    }
}


