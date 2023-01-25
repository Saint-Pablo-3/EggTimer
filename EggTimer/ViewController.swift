//
//  ViewController.swift
//  EggTimer
//
//  Created by Pavel Reshetov on 25.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var totalTime = 0
    var secondPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?

    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
    }
    
    func playSound(forResource: String) {
        let url = Bundle.main.url(forResource: forResource, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf:  url!)
        player?.play()
       
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
            print(progressBar.progress)
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound(forResource: "alarm_sound")
        }
    }


}


