//
//  ViewController.swift
//  TechnicalTestTemplate
//
//  Created by Wais on 23/12/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, MusicDelegate {

    //MARK: Components & Variables
    @IBOutlet weak var txtWelcome: UILabel!
    @IBOutlet weak var txtMusicStatus: UILabel!
    @IBOutlet weak var btnNews: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    let strPlay: String = "Music is Playing, Enjoy!"
    let strPause: String = "Oops.. Music stops playing."
    var isPlay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        initPlayer()
    }

}

// MARK: Functions & Actions
extension ViewController {
    
    func setupView(){
        self.txtWelcome.text = "Welcome!! You Can choose your favorite news while listening to music"
        self.txtMusicStatus.text = strPause
        
        btnNews.addTarget(self, action: #selector(getNews), for: UIControl.Event.touchUpInside)
        btnPlay.addTarget(self, action: #selector(setPlay), for: UIControl.Event.touchUpInside)
        btnPause.addTarget(self, action: #selector(setPause), for: UIControl.Event.touchUpInside)
    }
    
    func initPlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
            audioPlayer.prepareToPlay()
        } catch {
            print("Error :\(error)")
        }
    }
    
    @objc func getNews(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goToNews", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNews"{
            let vc = segue.destination as! NewsViewController
            vc.delegate = self
            vc.isPlay = self.isPlay
        }else {
            
        }
    }
    
    @objc func setPlay(){
        audioPlayer.play()
        self.isPlay = true
        DispatchQueue.main.async {
            self.txtMusicStatus.text = self.strPlay
            self.btnPlay.tintColor = UIColor.gray
            self.btnPause.tintColor = UIColor.blue
        }
    }
    
    @objc func setPause(){
        audioPlayer.pause()
        self.isPlay = false
        DispatchQueue.main.async {
            self.txtMusicStatus.text = self.strPause
            self.btnPause.tintColor = UIColor.gray
            self.btnPlay.tintColor = UIColor.blue
        }
    }
    
}
