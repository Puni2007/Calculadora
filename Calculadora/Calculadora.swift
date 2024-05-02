//
//  ViewController.swift
//  Calculadora
//
//  Created by Sonia Ujaque Ortiz on 2/5/24.
//

import UIKit

class Calculadora: UIViewController {
    
    //Variables
    private var total: Double = 0
    private var temporal: Double = 0
    private var operador = false
    private var decimal = false
    private var operacion: tipoOperacion = .ninguna
    
    private let separadorDecimal = Locale.current.decimalSeparator
    private let valorMax: Double = 999999999
    
    private enum tipoOperacion {
        case ninguna
        case sumar
        case restar
        case multiplicar
        case dividir
        case porcentaje
    }

    //Label resultado
    @IBOutlet weak var muestraResultado: UILabel!
    
    //Numeros
    @IBOutlet weak var numero0: UIButton!
    @IBOutlet weak var numero1: UIButton!
    @IBOutlet weak var numero2: UIButton!
    @IBOutlet weak var numero3: UIButton!
    @IBOutlet weak var numero4: UIButton!
    @IBOutlet weak var numero5: UIButton!
    @IBOutlet weak var numero6: UIButton!
    @IBOutlet weak var numero7: UIButton!
    @IBOutlet weak var numero8: UIButton!
    @IBOutlet weak var numero9: UIButton!
    
    //Operadores
    @IBOutlet weak var operadorAC: UIButton!
    @IBOutlet weak var operadorMasMenos: UIButton!
    @IBOutlet weak var operadorPorcentaje: UIButton!
    @IBOutlet weak var operadorDividir: UIButton!
    @IBOutlet weak var operadorMultiplicar: UIButton!
    @IBOutlet weak var operadorRestar: UIButton!
    @IBOutlet weak var operadorSumar: UIButton!
    @IBOutlet weak var operadorResultado: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //Acciones
    @IBAction func operadorACAccion(_ sender: UIButton) {
        
    }
    @IBAction func operadorMasMenosAccion(_ sender: UIButton) {
       
    }
    @IBAction func operadorPorcentajeAccion(_ sender: UIButton) {
       
        
    }
    @IBAction func operadorDividirAccion(_ sender: UIButton) {
       
        
    }
    
    @IBAction func operadorMultiplicarAccion(_ sender: UIButton) {
        
        
    }
    
    @IBAction func operadorRestarAccion(_ sender: UIButton) {
        
        
    }
    
    @IBAction func operadorSumarAccion(_ sender: UIButton) {
        
        
    }
    
    @IBAction func operadorResultadoAccion(_ sender: UIButton) {
        
    }
    
    @IBAction func accionNumeros(_ sender: UIButton) {
        
        
    }
    
    @IBAction func accionDecimal(_ sender: Any) {
       
        
        
    }
    
    //Funciones
    
    private func borrar() {
        operacion = .ninguna
        operadorAC.setTitle("AC", for: .normal)
        if temporal != 0 {
            temporal = 0
            muestraResultado.text = "0"
        } else {
            total = 0
            resultadoFinal()
        }
    }
    
    private func resultadoFinal() {
        switch operacion {
        case .ninguna:
            //no hacemos nada
            break
        case .sumar:
            total = total + temporal
            break
        case .restar:
            total = total - temporal
            break
        case .multiplicar:
            total = total * temporal
            break
        case .dividir:
            total = total / temporal
            break
        case .porcentaje:
            temporal = temporal / 100
            total = temporal
            break
        }
        
        muestraResultado.text = String(total)
    }

}

