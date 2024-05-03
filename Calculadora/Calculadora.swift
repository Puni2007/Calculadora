//
//  ViewController.swift
//  Calculadora
//
//  Created by Sonia Ujaque Ortiz on 2/5/24.
//

import UIKit

class Calculadora: UIViewController {
    
    //Variables
    private var total = 0
    private var temporal = 0
    private var operador = false
    private var decimal = false
    private var operacion: TipoOperacion = .ninguna
    
    private let separadorDecimal = Locale.current.decimalSeparator
    private let valoresMax = 9
    
    private enum TipoOperacion {
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
        borrar()
    }
    @IBAction func operadorMasMenosAccion(_ sender: UIButton) {
        temporal = temporal * (-1)
        muestraResultado.text = String(temporal)
    }
    @IBAction func operadorPorcentajeAccion(_ sender: UIButton) {
        operador = true
        operacion = .porcentaje
        resultadoFinal()
        
    }
    @IBAction func operadorDividirAccion(_ sender: UIButton) {
        
        operador = true
        operacion = .dividir
       
        
    }
    
    @IBAction func operadorMultiplicarAccion(_ sender: UIButton) {
        
        operador = true
        operacion = .multiplicar
        
    }
    
    @IBAction func operadorRestarAccion(_ sender: UIButton) {
        
        operador = true
        operacion = .restar
        
    }
    
    @IBAction func operadorSumarAccion(_ sender: UIButton) {
        
        operador = true
        operacion = .sumar
        
    }
    
    @IBAction func operadorResultadoAccion(_ sender: UIButton) {
        resultadoFinal()
    }
    
    @IBAction func accionNumeros(_ sender: UIButton) {
        let numero = sender.tag
       
        operadorAC.setTitle("C", for: .normal)
        var temporalActual = muestraResultado.text ?? ""
        
        if temporalActual == "0" {
            temporalActual.removeAll()
        }
        
        if !operador && temporalActual.count >= valoresMax {
            return
        }
        
        if operador {
            total = total == 0 ? temporal : total
            muestraResultado.text = ""
            temporalActual = ""
            operador = false
        }
        
        if let resultado = Int(temporalActual + String(numero)) {
            temporal = resultado
            muestraResultado.text = String(resultado)
        }
        
        
        
        print("TemporalActual: \(temporalActual)")
        
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
        
        print("Total: \(total) Temporal: \(temporal)")
    }

}
