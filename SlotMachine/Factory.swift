//
//  Factory.swift
//  SlotMachine
//
//  Created by Christian Köhler on 09.01.15.
//  Copyright (c) 2015 Christian A. Köhler. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    //mit class func erstellt man eine Funktion für eine Klasse, die auch im View Controller aufgerufen werden kann, in dem man einer Variable die Klasse zuweist und dann die Funktion aufruft, die Funktion hier erstellt einen Bereich, der wiederum mehrere Bereiche enthält
    
    class func createSlots() -> [[Slot]] {
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        var slots: [[Slot]] = []
        //eine kurze Erklärung dazu, wir haben einen slots array generiert, der einen Bereich darstellt, der weitere arrays/Bereiche enthält das ist =
        //slots = [ [slot1, slot2], [slot3, slot4, slot5], [slot6] ]
        //mySlotArray = slots[0] -> das entspricht dann [slot1, slot2]
        //slot = mySlotArray[1] -> das entspricht dann slot2
        
        
        //Erstellen aller Slots in Spalten und 3 Zellen pro Spalte  = [[slot1, slot2, slot3], [slot4, slot5, slot6], [slot7, slot8, slot9]]
        // Die erste For Schleife erstellt die Spalten und speichert sie am Ende im Slots Array
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            // Erstellen eines leeren Array, das Instanzen der Struktur "Slot" enthält
            var slotArray:[Slot] = []
          
            //Die zweite For Schleife erstellt die drei Zellen pro Spalte und speichert sie im slotArray
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                var slot = Factory.createSlot(slotArray)
                slotArray.append(slot)
            }
            slots.append(slotArray)
        }
        
        return slots
    }
    
    
//    mit func erstellt man funktionen für eine Instanz -> hier nur als Beispiel um den Unterschied zu der Klassen-Funktion zu zeigen - Gegensatz dazu ist die class func darunter
//    
//    func createSlot () {
//        println("print something instance func")
//    }
    
    // Mit dieser Funktion wird der Slot/Spalte überprüft, ob es schon erstellt ist und wenn es erstellt ist, soll es beim neuen Laden auch einen neuen Wert erhalten
    // In die Funktion wird ein Array übergeben der 3 Slots enthält z.B: [slot1, slot2, slot3]
    class func createSlot (currentCards: [Slot]) -> Slot {
        
        // currentCardValues, übernimmt mit der darunterstehenden for Schleife, die value - Werte, aus den drei Slot-Instanzen
        var currentCardValues:[Int] = []
        
        for slot in currentCards {
            currentCardValues.append(slot.value)
        }
        
        var randomNumber = Int(arc4random_uniform(UInt32(13)))
       
        // While überprüft ob die randomNumber dem aktuellen Wert einer Instanz im Slot entspricht und erneuert diese Zufallszahl solange bis eine neue Zahl darin steht, die noch nicht im Slot steht
        while contains(currentCardValues, randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        
        // Die Variable slot wird als Struktur Slot definiert
        var slot:Slot
        
        //  Switch gibt dem Slot einen neuen Wert, Bild und rot/nicht rot versehen wird.
        switch randomNumber {
        case 0: slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 1: slot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        case 2: slot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        case 3: slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 4: slot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
        case 5: slot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
        case 6: slot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
        case 7: slot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
        case 8: slot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
        case 9: slot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
        case 10: slot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
        case 11: slot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
        case 12: slot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
        default: slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
            
        }
        return slot
        
    }
    
    
    
    
    
}