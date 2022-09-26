//
//  NewsTableViewCell.swift
//  TechnicalTestTemplate
//
//  Created by Dimas Syuhada on 27/05/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtAuthor: UILabel!
    
    static let identifier = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    func configure(with model: NewsData){
        self.txtTitle.text = model.title
        self.txtAuthor.text = "Author: \(model.author ?? "-")"
        self.imageNews.downloadedFrom(link: model.urlToImage)
    }
    
}
