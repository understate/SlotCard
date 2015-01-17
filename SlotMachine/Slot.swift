//
//  Slot.swift
//  SlotMachine
//
//  Created by Christian Köhler on 09.01.15.
//  Copyright (c) 2015 Christian A. Köhler. All rights reserved.
//

import Foundation
import UIKit

// Struktur für jeden einzelnen Slot, gibt einen Wert und Bild pro Slot vor sowie, ob die Karte rot ist oder nicht. Kann jeder Karte zugeordnet werden
struct Slot {
    var value = 0
    var image = UIImage(named: "Ace")
    var isRed = true
}