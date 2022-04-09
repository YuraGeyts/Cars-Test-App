//
//  VideoPlayerViewController.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 06.04.2022.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var fullScreenButton: UIButton!
    
    let microphoneImage = UIImage(systemName: "mic.fill")
    let slashMicrophoneImage = UIImage(systemName: "mic.slash.fill")
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isPlaying = true
    var isMuted: Bool?
    
    var playerName: String?
    var videoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerTap = UITapGestureRecognizer(target: self, action: #selector(playerTap))
        playerView.addGestureRecognizer(playerTap)
        playerView.isUserInteractionEnabled = true
        
        soundButton.setTitle("", for: .normal)
        fullScreenButton.setTitle("", for: .normal)
        
        showVideoInView(uiView: playerView, videoURL: videoURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if LoginManager.isLogged {
            guard let playerName = playerName else { return }
            playerLabel.text = playerName
            
            player?.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
        player?.seek(to: .zero)
    }
    
    @objc func playerTap() {
        guard let player = player else {
            return
        }
        switch player.timeControlStatus {
        case .playing:
            player.pause()
        case .paused:
            player.play()
        case .waitingToPlayAtSpecifiedRate: break
        default: break
        }
    }
    
    @IBAction func microTap() {
        guard let player = player else { return }
        
        if player.isMuted {
            player.isMuted = false
            soundButton.setImage(microphoneImage, for: .normal)
        } else {
            player.isMuted = true
            soundButton.setImage(slashMicrophoneImage, for: .normal)
        }
        
    }
    
    func showVideoInView(uiView: UIView, videoURL: String) {
        let url = NSURL(string: videoURL)
        player = AVPlayer(url: url! as URL)
        
        playerLayer = AVPlayerLayer(player: player)
        guard let playerLayer = playerLayer else { return }
        playerLayer.frame = uiView.bounds
        uiView.layer.addSublayer(playerLayer)
        
        if isPlaying { player?.play() } else { player?.pause() }
        
        guard let isMuted = isMuted else { return }
        player?.isMuted = isMuted
        if (isMuted) { soundButton.setImage(slashMicrophoneImage, for: .normal) }
        else { soundButton.setImage(microphoneImage, for: .normal) }
    }
    
}
