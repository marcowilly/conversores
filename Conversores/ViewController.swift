//
//  ViewController.swift
//  Conversores
//
//  Created by marco willy on 27/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var btUnit1: UIButton!
    @IBOutlet weak var btUnit2: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbResultUnit: UILabel!
    @IBOutlet weak var lbUnit: UILabel!
    
    enum types {
        enum temperature: String {
            case value = "Temperatura", celsius = "Celsius", farenheint = "Farenheint"
        }
        enum distance: String {
            case value = "Distância", meter = "Metro", kilometer = "Kilômetro"
        }
        enum wheight: String {
            case value = "Peso", kilogram = "Kilograma", libra = "Libra"
        }
        enum currency: String {
            case value = "Moeda", real = "Real", dolar = "Dolar"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        switch lbUnit.text! {
            case types.temperature.value.rawValue:
                lbUnit.text = types.wheight.value.rawValue
                btUnit1.setTitle(types.wheight.kilogram.rawValue, for: .normal)
                btUnit2.setTitle(types.wheight.libra.rawValue, for: .normal)
            case types.wheight.value.rawValue:
                lbUnit.text = types.currency.value.rawValue
                btUnit1.setTitle(types.currency.real.rawValue, for: .normal)
                btUnit2.setTitle(types.currency.dolar.rawValue, for: .normal)
        case types.currency.value.rawValue:
                lbUnit.text = types.distance.value.rawValue
                btUnit1.setTitle(types.distance.meter.rawValue, for: .normal)
                btUnit2.setTitle(types.distance.kilometer.rawValue, for: .normal)
            default:
                lbUnit.text = types.temperature.value.rawValue
                btUnit1.setTitle(types.temperature.celsius.rawValue, for: .normal)
                btUnit2.setTitle(types.temperature.farenheint.rawValue, for: .normal)
        }
        convert(nil)
    }
    
    @IBAction func convert(_ sender: UIButton?) {
        if let sender = sender {
            if sender == btUnit1 {
                btUnit2.alpha = 0.5
            }else{
                btUnit1.alpha = 0.5
            }
            sender.alpha = 1.0
        }
        
        switch lbUnit.text! {
        case types.temperature.value.rawValue:
                calcTemperature()
            case types.wheight.value.rawValue:
                calcWeight()
            case types.currency.value.rawValue:
                calcCurrency()
            default:
                calcDistance()
        }
        //Esconde teclado
        view.endEditing(true)
        let result = Double(lbResult.text!)!
        lbResult.text = String(format: "%.2f", result)
    }
    
    /**
        Calcula temperatura
        Farenheit - Celsius
     */
    func calcTemperature(){
        guard let temperature = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = types.temperature.farenheint.rawValue
            lbResult.text = String(temperature * 1.8 + 32.0)
        } else {
            lbResultUnit.text = types.temperature.celsius.rawValue
            lbResult.text = String((temperature - 32.0) / 1.8)
        }
    }
    
    /**
        Calcula peso
        Libra - Kilograma
     */
    func calcWeight(){
        guard let weight = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = types.wheight.libra.rawValue
            lbResult.text = String(weight / 2.2046)
        } else {
            lbResultUnit.text = types.wheight.kilogram.rawValue
            lbResult.text = String(weight * 2.2046)
        }
    }
    
    /**
        Calcula valor moeda
        Dolar - Real
     */
    func calcCurrency(){
        guard let currency = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = types.currency.dolar.rawValue
            lbResult.text = String(currency / 5.5)
        } else {
            lbResultUnit.text = types.currency.real.rawValue
            lbResult.text = String(currency * 3.5)
        }
    }
    
    /**
        Calcula distancia
        Kilômetro - Metro
     */
    func calcDistance(){
        guard let distance = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = types.distance.kilometer.rawValue
            lbResult.text = String(distance / 1000.0)
        } else {
            lbResultUnit.text = types.distance.meter.rawValue
            lbResult.text = String(distance * 1000.0)
        }
    }
}
