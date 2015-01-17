//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Christian Köhler on 12.01.15.
//  Copyright (c) 2015 Christian A. Köhler. All rights reserved.
//

import Foundation
import UIKit

//Diese Klasse wird genutzt, wenn man auf den Spin Button drückt.
class SlotBrain {
    
    //Mit der Funktion werden die 3er-Spalten in 3erReihen aufgeteilt und wieder ausgegeben, damit analysiert werden kann, ob es Gewinne gab und welche.
    class func unpackSlotIntoSlotRows (slots:[[Slot]]) -> [[Slot]] {
        
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
                else {
                    println("Error")
                }
            }
        }
        
        var slotsInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]
        
        return slotsInRows
    }
   
    //Diese Funktion analysiert welche Arten der Gewinne erzielt wurden und gibt die Anzahl der Gewinne zurück. Dazu werden die slots als Array übergeben und dann die weiteren Klassenfunktionen weiter unten aufgerufen.
    class func computeWinnings (slots: [[Slot]]) -> Int {
        
    //Mit dieser Variable wir der SlotArray entpackt in die einzelnen Reihen und anhand der Funktionen wird in dem For Loop Reihe für Reihe überprüft, welche Gewinne in der jeweiligen Reihe stehen.
    var slotsInRows = unpackSlotIntoSlotRows(slots)
    var winnings = 0
        
        
    var flushWinCount = 0
    var threeOfAKindWinCount = 0
    var straightWinCount = 0
    
    for slotRow in slotsInRows {
        
        if checkFlush(slotRow) == true {
            println("flush")
            winnings += 1
            flushWinCount += 1
        }
        
        if checkThreeInARow(slotRow) == true {
            println("Three in a row")
            winnings += 1
            straightWinCount += 1
        }
        
        
        if checkThreeOfAKind(slotRow) == true {
            println("Three of a kind")
            winnings += 3
            threeOfAKindWinCount += 1
        }
        
        
        
        }
    
        if flushWinCount == 3 {
            println("Royal Flush")
            winnings += 15
            
        }
        
        if straightWinCount == 3 {
            println("Epic Straight")
            winnings += 1000
        }
        
        if threeOfAKindWinCount == 3 {
            println("Threes all around")
            winnings += 500
        }
    
        
    return winnings
        
        
    }
    
    //Diese Funktion ermittelt ob und wieviele FLushs erzielt wurden, dazu wird eine Slot/Reihe übergeben und jedes einzelne Feld als Konstante deklariert
    class func checkFlush (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
        }
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
        }
        
        else {
            return false
        }
    }
    
    //Diese Funktion ermittelt, ob und wieviele Straßen erzielt wurden, dazu wird eine Slot/Reihe übergeben und jedes einzelne Feld als Konstante deklariert

    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value - 1 && slot2.value == slot3.value - 2 {
            return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
            return true
        }
        else {
            return false
        }
        
        
    }
    
    //Diese Funktion ermittelt, ob und wieviele Drillinge erzielt wurden, dazu wird eine Slot/Reihe übergeben und jedes einzelne Feld als Konstante deklariert

    class func checkThreeOfAKind (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else {
            return false
        }
        
        
    }
    
}
