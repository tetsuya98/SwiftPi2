//
//  PiViewController.swift
//  SwiftPi
//
//  Created by Josselin Abel on 04/01/2021.
//

import UIKit

class PiViewController: UIViewController {
    @IBOutlet weak var piView: PiView!
    private var modele = piModele()
    var sliderValue = 0
    var roundedValue: Float = 0.0
    let step: Float = 1000
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet var vue: PiView!
    @IBOutlet weak var piLabel: UILabel!
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        roundedValue = round(sender.value / step) * step
        sender.setValue(roundedValue, animated: true)
        sliderValue = Int(sender.value)
        modele.drawPoint(nbPoint: sliderValue, squareSide: vue.squareSide)
        sliderLabel.text = "\(sliderValue)"
        vue.pointTableau = modele.getTableau
        vue.nbPointTotal = modele.getTotal
        vue.nbPointInCircle = modele.getPointInCircle
        vue.setNeedsDisplay()
    }
    
    @IBAction func calcButtonClicked(_ sender: UIButton) {
        if vue.nbPointInCircle > 0 {
            modele.drawPoint(nbPoint: sliderValue, squareSide: vue.squareSide)
            let piRounded = modele.calcPi()
            piLabel.text = "\(piRounded)"
            vue.setNeedsDisplay()
        }
    }
    
    
    
}
