//
//  ViewController.swift
//  SlotMachine
//
//  Created by Christian Köhler on 04.01.15.
//  Copyright (c) 2015 Christian A. Köhler. All rights reserved.
//


//Adding Commits here to Test commits on GitHub

import UIKit

class ViewController: UIViewController {
    
    // setup properties for container -  each time the application is started they will be loaded
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    var titleLabel : UILabel!
    
    
    // Adding information Labels
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLable: UILabel!
    var winnerPaidTitleLable: UILabel!
    
    
    // Adding Buttons in the fourth container
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    var slots:[[Slot]]  = []
    
    // Stats - Definiert die Statistiken
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    // Creating constants that could be used all over the view controller file and cannot be changed anywhere - the "k" at the beginning lets us recognize that this is a constant it is common to use it so in SWIFT generally
    let kMarginForView:CGFloat = 10.0
    let kSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0
    let kMarginForSlot:CGFloat = 2.0
    
    let kHalf:CGFloat = 1.0/2.0
    let kEight:CGFloat = 1.0/8.0
    
    
    // to create the UIImages for the secondContainer we use the next two constants

    // this constant creates the columns
    let kNumberOfContainers = 3
    
    // this constant creates the rows
    let kNumberOfSlots = 3
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainerView(self.firstContainer)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
        // Diese Funktion setzt die Spielstände auf Anfang und erstellt den secondContainerView neu, daher muss dieser nicht. wie vorher die anderen Container extra aufgerufen werden, denn er ist im hardReset enthalten
        hardReset()
        
//        Beispiel und Unterschied wie man eine Klassen-Funktion und eine Instanzen-Funktion aufruft
//        
//        Factory.createSlots()
//
//        var factoryInstance = Factory()
//        factoryInstance.createSlot()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions
    func resetButtonPressed (button: UIButton) {
        // Setzt die Spielstände auf Anfang zurück und erstellt den secondContainerView neu
        hardReset()
        
        println("resetButtonPressed")
        
    }

    
    func betOneButtonPressed (button: UIButton) {
        
        if credits <= 0 {
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        }
        
        else {
            if currentBet < 5 {
                currentBet += 1
                credits -= 1
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
        
        println("betOneButtonPressed")
    
    }
    
    
    func betMaxButtonPressed (button: UIButton) {
        if credits <= 5 {
            showAlertWithText(header: "Not enough Credits", message: "Bet less")
        }
        else {
            if currentBet < 5 {
                var creditsToBetMax = 5 - currentBet
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
        
        
        
        println("betMaxButtonPressed")
    }
    
    
    func spinButtonPressed (button: UIButton) {
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
        
        var winningsMultiplier = SlotBrain.computeWinnings(slots)
        winnings = winningsMultiplier * currentBet
        credits += winnings
        currentBet = 0
        updateMainView()
        
        println("spinButtonPressed")
        
        
    }

    
    
    // create a helper function
    // this helper function will create the view dynamically when we call it in viewDidLoad above
    
    func setupContainerViews() {
        // this will create the container at a certain position with x and y and a certain width and height depending on the superView which in this case is the backgroundView
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        // this will give the first container the backgroundColor red
        self.firstContainer.backgroundColor = UIColor.redColor()
        // this will add the subview to the superView which is the backgroundView in this case
        self.view.addSubview(self.firstContainer)
       
        // adding the additional containers
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView , y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.greenColor()
        self.view.addSubview(thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(fourthContainer)
        
    }
    
    
    func setupFirstContainerView(containerView: UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "Verdana", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
    
    func setupSecondContainer(containerView: UIView) {
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slot:Slot
                var slotImageView = UIImageView()
                // testen, ob ein slot verfügbar ist,wenn er verfügbar ist, soll ein neues image genutzt werden und wenn nicht, dann soll er erzeugt werden mit einem Ass
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }
                else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
                
            }
        }
        
    }
    
    
    func setupThirdContainer(containerView: UIView) {
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLable = UILabel()
        self.betTitleLable.text = "Bet"
        self.betTitleLable.textColor = UIColor.blackColor()
        self.betTitleLable.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLable.sizeToFit()
        self.betTitleLable.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLable)
        
        self.winnerPaidTitleLable = UILabel()
        self.winnerPaidTitleLable.text = "WinnerPaid"
        self.winnerPaidTitleLable.textColor = UIColor.blackColor()
        self.winnerPaidTitleLable.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLable.sizeToFit()
        self.winnerPaidTitleLable.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.winnerPaidTitleLable)
        
        
        
    }
    
    
    func setupFourthContainer (containerView: UIView) {
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(resetButton)
        
        
        self.betOneButton = UIButton ()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEight, y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        self.betMaxButton = UIButton ()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.greenColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEight, y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
        
        
        self.spinButton = UIButton ()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEight, y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(spinButton)
        
        
    }
    
    // Funktion um die alten ImageVIews zu löschen bevorneue Bilder geladen werden, sodass der Memory nicht irgendwann überlädt
    func removeSlotImageViews () {
        // überprüfen, ob der secondcontainer existiert
        if self.secondContainer != nil {
            // erneute Überprüfung, ob der Container exisitiert um zu zeigen, dass es auf verschiedenen Wegen geht, das if, hätte auch gereicht
            let container: UIView? = self.secondContainer
            let subViews:Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    //Funktion um das Soiel komplett zurückzusetzen
    func hardReset () {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        
        updateMainView()
    }
    
    // Funktion die dafür verantwortlich ist updates in den Lables zu übernehmen
    func updateMainView () {
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }

    // Alerts werden angezeigt, wenn ein Fehler passiert
    func showAlertWithText (header : String = "Warning", message : String) {
        
        // Create Warnmeldung, mit der Möglichkeit einen Titel und eine Nachricht einzugeben
        var alert = UIAlertController (title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        // Möglichkeit hinzufügen dass der Benutzer die Meldung auch wieder schließen kann
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        // Anzeigen Warnmeldung
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}

