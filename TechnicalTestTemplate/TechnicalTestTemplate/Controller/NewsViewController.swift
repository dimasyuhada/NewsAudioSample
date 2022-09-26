//
//  NewsViewController.swift
//  TechnicalTestTemplate
//
//  Created by Dimas Syuhada on 28/05/22.
//

import Foundation
import UIKit

protocol MusicDelegate: AnyObject {
    func setPlay()
    func setPause()
}

class NewsViewController: UIViewController {

    // MARK: Components & Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    
    
    let baseUrl: String = "https://saurav.tech/NewsAPI/top-headlines/category/technology/us.json"
    var newsList = [NewsData]()
    weak var delegate: MusicDelegate? = nil
    var isPlay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchData()
    }

}

// MARK: Functions
extension NewsViewController {
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        btnPlay.addTarget(self, action: #selector(setPlay), for: UIControl.Event.touchUpInside)
        btnPause.addTarget(self, action: #selector(setPause), for: UIControl.Event.touchUpInside)
        
        checkMusic(isPlay)
    }
    
    func fetchData() {
        getJSON{
            self.tableView.reloadData()
        };
    }
    
    func getJSON(completed: @escaping() -> ()){
        let url = URL (string: baseUrl)
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error == nil {
                do{
                    let dataNews = try JSONDecoder().decode(News.self, from: data!)
                    self.newsList = dataNews.articles
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    @objc func setPlay(){
        checkMusic(true)
        delegate?.setPlay()
    }
    
    @objc func setPause(){
        checkMusic(false)
        delegate?.setPause()
    }
    
    func checkMusic(_ setMusic: Bool) {
        if setMusic {
            self.btnPlay.tintColor = UIColor.gray
            self.btnPause.tintColor = UIColor.blue
        } else{
            self.btnPause.tintColor = UIColor.gray
            self.btnPlay.tintColor = UIColor.blue
        }
    }
    
}

// MARK: TableView Delegates
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configure(with: newsList[indexPath.row])
        return cell
    }
}
