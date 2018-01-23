//
//  substractionView.swift
//  math quizz
//
//  Created by Alen  on 30/04/16.
//  Copyright © 2016 Alen . All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class substractionView: UIViewController {
    
    //AUDIO CORRECT ANSWER
    var soundURL1 = URL(fileURLWithPath: Bundle.main.path(forResource: "correctAnswer", ofType: "mp3")!)
    var audioPLayer1 = AVAudioPlayer()
    
    //AUDIO WRONG ANSWER
    var soundURL2 = URL(fileURLWithPath: Bundle.main.path(forResource: "wrongAnswer", ofType: "mp3")!)
    var audioPlayer2 = AVAudioPlayer()
    
    //VICTORY SOUND
    var soundURL3 = URL(fileURLWithPath: Bundle.main.path(forResource: "victory", ofType: "mp3")!)
    var audioPlayer3 = AVAudioPlayer()
    
    //DEFEAT SOUND
    var soundURL4 = URL(fileURLWithPath: Bundle.main.path(forResource: "defeat", ofType: "mp3")!)
    var audioPLayer4 = AVAudioPlayer()
    
    //TRY AGAIN SOUND
    var soundURL5 = URL(fileURLWithPath: Bundle.main.path(forResource: "tryAgain", ofType: "mp3")!)
    var audioPlayer5 = AVAudioPlayer()
    
    //QUESTION NUMBER
    @IBOutlet var questionNumber: UILabel!
    
    var questionNum = 0
    
    func qNumber() {
        
        questionNum += 1
        questionNumber.text = "\(questionNum)/10"
        
    }
    
    func restartQNum() {
        
        questionNum = 0
        questionNumber.text = "\(questionNum)/10"
        
    }
    
    //TEXT FIELD
    @IBOutlet var textFieldName: UITextField!
    
    //BUTTON
    @IBOutlet var buttonName: UIButton!
    
    //RESULT LABEL
    
    @IBOutlet var labelName: UILabel!
    
    var a = arc4random() % 10
    var b = arc4random() % 10
    
    //RANDOM NUMBERS FUNC
    
    func randomNumbers() {
       
        a = arc4random() % 10
        b = arc4random() % 10
        
        if a < b {
            
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        
    }
    
    //TIMER LABEL
    
    @IBOutlet var timerLabel: UILabel!
    
    var seconds = 10
    var timer = Timer()
    var timerIsOn = false
    
    //RESULT LABEL
    
    @IBOutlet var resultLabel: UILabel!
    
    //CORRECT/WRONG ANSWER LABELS
    
    @IBOutlet var correctAnswer: UILabel!
    @IBOutlet var wrongAnswer: UILabel!
    
    //SHOW RESULTS
    
    var correctA = 0
    var notCorrectA = 0
    
    //RESTART POINTS FUNC
    
    func restartPoints() {
        
        correctA = 0
        notCorrectA = 0
        correctAnswer.text = "\(correctA)"
        correctAnswer.textColor = UIColor.black
        wrongAnswer.text = "\(notCorrectA)"
        wrongAnswer.textColor = UIColor.black
        resultLabel.text = "Result"
        resultLabel.textColor = UIColor.black
        
    }
    
    
    // QUIZZ OVER
    
    func stopQuizz() {
        
        let points = correctA + notCorrectA
        
        if points == 10 {
            timerIsOn = false
            timer.invalidate()
            textFieldName.isUserInteractionEnabled = false
            textFieldName.text = ""
            
            
            if correctA > notCorrectA {
                resultLabel.text = "Congratulations!"
                resultLabel.textColor = UIColor.brown
                audioPlayer3.play()
            }
            else if correctA == notCorrectA{
                resultLabel.text = "Points equated!"
                resultLabel.textColor = UIColor.brown
            }
            else {
                resultLabel.text = "You need more practice!"
                resultLabel.textColor = UIColor.brown
                audioPLayer4.play()
            }
            
            labelName.text = "Quizz is Over"
            timerLabel.text = "0"
            buttonName.setTitle("Start Again?", for: UIControlState())
            
        }
        
        
    }
    
    //CORRECT ANSWER
    
    func rightAnswer() {
        
        correctA += 1
        correctAnswer.text = "\(correctA)"
        correctAnswer.textColor = UIColor.green
        textFieldName.text = ""
        qNumber()
        audioPLayer1.play()
        
    }
    
    //WRONG ANSWER
    
    func badAnswer() {
        
        notCorrectA += 1
        wrongAnswer.text = "\(notCorrectA)"
        wrongAnswer.textColor = UIColor.red
        resultLabel.text = "Wrong!"
        resultLabel.textColor = UIColor.red
        textFieldName.text = ""
        qNumber()
        audioPlayer2.play()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labelName.text = "Substraction Quizz"
        textFieldName.isUserInteractionEnabled = false
        textFieldName.keyboardType = UIKeyboardType.numbersAndPunctuation
        audioPLayer1 = try! AVAudioPlayer(contentsOf: soundURL1, fileTypeHint: nil)
        audioPlayer2 = try! AVAudioPlayer(contentsOf: soundURL2, fileTypeHint: nil)
        audioPlayer3 = try! AVAudioPlayer(contentsOf: soundURL3, fileTypeHint: nil)
        audioPLayer4 = try! AVAudioPlayer(contentsOf: soundURL4, fileTypeHint: nil)
        audioPlayer5 = try! AVAudioPlayer(contentsOf: soundURL5, fileTypeHint: nil)
        
    }
    
    // WRITE RESULT IN THE TEXTFIELD
    
    @IBAction func writeResult(_ sender: UITextField) {

        let myString = sender.text
        let myInt = UInt32(myString!)
        
        let quotient = a-b
        
        if myInt == quotient {
            
            resultLabel.textColor = UIColor.green
            resultLabel.text = "Correct!"
            rightAnswer()
        }
            
        else {
            
            resultLabel.text = "Wrong!"
            resultLabel.textColor = UIColor.red
            badAnswer()
        }
        
        if resultLabel.text == "Correct!" || resultLabel.text == "Wrong!" {
            
            restartTimer()
        }
        
        stopQuizz()
        
    }
    
    
    //RESTART TIMER FUNCTION
    
    func restartTimer() {
        
        seconds = 10
        randomNumbers()
        updateTimer()
        labelName.text = "\(a) - \(b) = ?"
        
    }
    
    //UPDATE TIMER FUNCTION
    
    func updateTimer() {
        
        seconds -= 1
        timerLabel.text = "\(seconds)"
        if seconds == 0 {
            badAnswer()
            seconds = 10
            randomNumbers()
            labelName.text = "\(a) - \(b) = ?"
        }
        stopQuizz()
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        if timerIsOn == false {
            restartPoints()
            restartQNum()
            timerIsOn = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(additionView.updateTimer), userInfo: nil, repeats: true)
            randomNumbers()
            labelName.text = "\(a) - \(b) = ?"
            buttonName.setTitle("Start!", for: UIControlState())
            textFieldName.isUserInteractionEnabled = true
            
        }
        
        
        switch (questionNum, timerIsOn) {
            
        case (1...11, timerIsOn == true):
            
            let alertController2 = UIAlertController(title: "Warning", message: "Do you really want to start from the beginning?", preferredStyle: UIAlertControllerStyle.alert)
            
            
            self.timerIsOn = false
            self.timer.invalidate()
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                
                self.restartTimer()
                self.restartPoints()
                self.restartQNum()
                self.startTimerAgain()
            }
            alertController2.addAction(yesAction)
            
            let noAction = UIAlertAction(title: "No", style: .default) { (action) in
                
                self.startTimerAgain()
                
            }
            alertController2.addAction(noAction)
            
            self.present(alertController2, animated: true){}
            
        default:
            print("Error!")
        }
        
        
    }
    
    
    //UNPAUSE TIMER
    
    func startTimerAgain() {
        
        if timerIsOn == false {
            timerIsOn = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(additionView.updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    //GO BACK TO MENU
    
    @IBAction func goBack(_ sender: UIButton) {
        
        if timerIsOn == true
        {
            
            let alertController = UIAlertController(title: "Warning", message: "Addition Quizz will be terminated", preferredStyle: UIAlertControllerStyle.alert)
            
            self.timerIsOn = false
            self.timer.invalidate()
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
                self.startTimerAgain()
                
            }
            
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {}
            
        }
        
    }
    
}
