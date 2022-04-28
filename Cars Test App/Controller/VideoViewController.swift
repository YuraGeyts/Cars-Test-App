//
//  MainViewController.swift
//  Cars Test App
//
//  Created by Юра Гейц on 01.04.2022.
//

import UIKit
import AVKit
import Firebase

enum VideoStrings: String {
    case firstVideo = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4"
    case secondVideo = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4"
}

class VideoViewController: UIViewController {
    
    @IBOutlet weak var firstPlayerViewContainer: UIView!
    @IBOutlet weak var secondPlayerViewContainer: UIView!
    
    var topPlayer: AVPlayer?
    var bottomPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView(notification:)), name: Notification.Name("ReloadView"), object: nil)

        
        getAndShowUserLogin()
        
        //Add gestureRecogniser
        setupGestureRecogniser()

        topPlayer = showVideoInView(uiView: firstPlayerViewContainer, videoURL: VideoStrings.firstVideo.rawValue)
        bottomPlayer = showVideoInView(uiView: secondPlayerViewContainer, videoURL: VideoStrings.secondVideo.rawValue)
    }
    
    /***********************OBJ-C func********************************/
    //-----------------Restart viewDidLoad----------------------------------------------------
    @objc func reloadView(notification: NSNotification) {
        self.viewDidLoad()
    }
    
    //--------------------------Gesture recogniser--------------------------------------------------
    func setupGestureRecogniser() {
        let firstPlayerTap = UITapGestureRecognizer(target: self, action: #selector(self.firstViewTap))
        firstPlayerViewContainer.addGestureRecognizer(firstPlayerTap)

        let firstPlayerDoubleTap = UITapGestureRecognizer(target: self, action: #selector(firstViewDoubleTapped))
        firstPlayerDoubleTap.numberOfTapsRequired = 2
        firstPlayerViewContainer.addGestureRecognizer(firstPlayerDoubleTap)

        firstPlayerViewContainer.isUserInteractionEnabled = true
        firstPlayerTap.require(toFail: firstPlayerDoubleTap)

        let secondPlayerTap = UITapGestureRecognizer(target: self, action: #selector(self.secondViewTap))
        secondPlayerViewContainer.addGestureRecognizer(secondPlayerTap)

        let secondPlayerDoubleTap = UITapGestureRecognizer(target: self, action: #selector(secondViewDoubleTapped))
        secondPlayerDoubleTap.numberOfTapsRequired = 2
        secondPlayerViewContainer.addGestureRecognizer(secondPlayerDoubleTap)

        secondPlayerViewContainer.isUserInteractionEnabled = true
        secondPlayerTap.require(toFail: secondPlayerDoubleTap)
    }
    
    @objc func firstViewTap() {
        playOrPause(player: topPlayer)
    }
    @objc func firstViewDoubleTapped() {
        muteUnmute(player: topPlayer)
    }
    
    @objc func secondViewTap() {
        playOrPause(player: bottomPlayer)
    }
    @objc func secondViewDoubleTapped() {
        muteUnmute(player: bottomPlayer)
    }
    /*************************************************************************/
    
    //----------------Player control----------------
    private func showVideoInView(uiView: UIView, videoURL: String) -> AVPlayer {
        let url = NSURL(string: videoURL)
        
        let player = AVPlayer(url: url! as URL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = uiView.bounds
        uiView.layer.addSublayer(playerLayer)
        player.play()
        player.isMuted = true
        return player
    }
    
    private func playOrPause(player: AVPlayer?) {
        guard let player = player else { return }
        switch player.timeControlStatus {
        case .playing:
            player.pause()
        case .paused:
            player.play()
        case .waitingToPlayAtSpecifiedRate: break
        @unknown default: break
        }
    }
    
    private func muteUnmute(player: AVPlayer?) {
        guard let player = player else {
            return
        }
        if player.isMuted {
            player.isMuted = false
        } else {
            player.isMuted = true
        }

    }
    //----------------------------------------------
    
    
    @IBAction func logOutAction(_ sender: Any) {
        topPlayer?.seek(to: .zero)
        topPlayer?.pause()
        bottomPlayer?.seek(to: .zero)
        bottomPlayer?.pause()
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    //---------------------Getting user login async-------------------------------------------
    //show login from firebase
    private func getAndShowUserLogin() {
        DispatchQueue.main.async {
            let user = Auth.auth().currentUser
            if let user = user {
                let email = user.email
                self.title = email
            }
        }
    }
    
}
