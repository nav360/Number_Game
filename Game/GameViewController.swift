//
//  ViewController.swift
//  Game
//
//  Created by Pranav Simha on 1/28/20.
//  Copyright © 2020 Pranav Simha. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController
{

    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    @IBOutlet weak var highscoreLabel:UILabel?
    
    var AudioPlayer = AVAudioPlayer()
    var AudioPlayer2 = AVAudioPlayer()
    var score = 0
    var timer:Timer?
    var seconds = 60
    var highscore = 0
    var count = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "audio-game", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
        
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
        // Do any additional setup after loading the view.
    }
    
    func updateNumberLabel()
    {
        numberLabel?.text = String.randomNumber(length: 4)
    }
    
    func updateScoreLabel()
    {
        scoreLabel?.text = String(score)
    }
    
    func updateHighScoreLabel()
    {
        highscoreLabel?.text = String(highscore)
    }
    
    @IBAction func inputFieldDidChange()
    {
        guard let numberText = numberLabel?.text, let inputText = inputField?.text else
        {
            return
        }
        
        guard inputText.count == 4 else
        {
            return
        }
        
        var isCorrect = true
        
        for n in 0..<4
        {
            var input = inputText.integer(at: n)
            let number = numberText.integer(at: n)
            
            if input == 0
            {
                input = 10
            }
            
            if input != number + 1
            {
                isCorrect = false
                break
            }
        }
        if isCorrect
        {
            score += 1
            count += 1
            if self.count > 4
            {
                score += 1
            }
        }
        else{
            let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "simp-sound", ofType: "m4a")!)
            AudioPlayer2 = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
            AudioPlayer2.prepareToPlay()
            AudioPlayer2.numberOfLoops = 0
            AudioPlayer2.play()
            
            score -= 1
            count = 0
        }
        
        updateNumberLabel()
        updateScoreLabel()
        inputField?.text = ""
        
        if timer == nil
        {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
            {
                timer in
                if self.seconds == 0
                {
                    if self.score > self.highscore
                    {
                        self.highscore = self.score
                    }
                    self.finishGame()
                }
                else if self.seconds <= 60
                {
                    self.seconds -= 1
                    self.updateTimeLabel()
                }
            }
        }
    }
    
    func updateTimeLabel()
    {
        let min = (seconds / 60) % 60
        let sec = seconds % 60
        
        timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    func finishGame()
    {
        timer?.invalidate()
        timer = nil
        
        
        let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(score) points.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        score = 0
        seconds = 60
        
        updateTimeLabel()
        updateNumberLabel()
        updateScoreLabel()
        updateHighScoreLabel()
    }
}




