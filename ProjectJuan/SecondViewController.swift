//
//  SecondViewController.swift
//  ProjectJuan
//
//  Created by juan.roncancio on 3/05/24.
//

import UIKit
import AVKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var urlSearcher: UITextField!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var defaultImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        urlSearcher.placeholder = "Search videos by URL"
        urlSearcher.delegate = self
        urlSearcher.keyboardType = .URL
        addDefaultImageVideo()
        
        defaultImageView?.isHidden = false
    }
        
    func addDefaultImageVideo(){
        defaultImageView = UIImageView(frame: videoView.bounds)
        defaultImageView?.image = UIImage(named: "placeholderVideo")
        defaultImageView?.contentMode = .scaleAspectFit
        videoView.addSubview(defaultImageView!)
    }
    
    func addTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
       
    @IBAction func searchButton(_ sender: Any){
        if let urlString = urlSearcher.text, !urlString.isEmpty{
            let url = URL(string: urlString)
            player = AVPlayer(url: url!)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = videoView.bounds
            if let playerLayer = playerLayer {
                videoView.layer.addSublayer(playerLayer)
            }
            player!.play()
            defaultImageView?.isHidden = true
        }
        print("Campo vacío")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
   
}

