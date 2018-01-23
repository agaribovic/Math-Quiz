//
//  ViewTwo.swift
//  math quizz
//
//  Created by Alen  on 30/04/16.
//  Copyright © 2016 Alen . All rights reserved.
//

import UIKit

class startingView : UIViewController {
    

    @IBOutlet var additionButton: UIButton!
    @IBOutlet var substractionButton: UIButton!
    
    override func viewDidLoad() {
        
        additionButton.center.x = self.view.frame.width + 30
        substractionButton.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 4.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            
            self.additionButton.center.x = self.view.frame.width / 2
            
            
            
        }),
                                   completion:  nil)
        
        UIView.animate(withDuration: 4.0, delay: 1, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.curveEaseIn, animations:
            ({
                
                self.substractionButton.center.x = self.view.frame.width / 2
        
        }),
                                    completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     _ = segue.destination
        
    }
    
    
    
    
}
