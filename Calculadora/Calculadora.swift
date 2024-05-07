//
//  ViewController.swift
//  Calculadora
//
//  Created by Sonia Ujaque Ortiz on 2/5/24.
//

import UIKit

class Calculadora: UIViewController {
    
    // MARK: - Variables
    private var total: Float = 0
    private var temporal: Float = 0
    private var pulsadoComa = false
    private var operador = false
    private var resultado = false
    private var decimal = false
    private var operacion: TipoOperacion = .ninguna
    
    // MARK: - Constantes
    private let separadorDecimal = Locale.current.decimalSeparator
    private let digitosMax = 9
    private let valorMax: Float = 999999999.0
    
    // MARK: - Enums
    private enum TipoOperacion {
        case ninguna
        case sumar
        case restar
        case multiplicar
        case dividir
        case porcentaje
    }
    
    private enum Constants: String {
        case firstDecimal = "0,"
        case zero = "0"
        case clean = "C"
        case colon = ","
        case point = "."
        case pointZero = ".0"
        case noPosible = "No posible"
        case cleanAC = "AC"
    }

    // MARK: - Outlets
    @IBOutlet weak var muestraResultado: UILabel!
    @IBOutlet weak var operadorAC: UIButton!
    @IBOutlet weak var numeroDecimal: UIButton!
    @IBOutlet weak var operadorMasMenos: UIButton!
    @IBOutlet weak var operadorDividir: UIButton!
    @IBOutlet weak var operadorPorcentaje: UIButton!
    @IBOutlet weak var operadorMultiplicar: UIButton!
    @IBOutlet weak var operadorRestar: UIButton!
    @IBOutlet weak var operadorSumar: UIButton!
    @IBOutlet weak var operadorIgual: UIButton!
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
    
    // MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operadorAC.layer.cornerRadius = 35
        numeroDecimal.layer.cornerRadius = 35
        operadorMasMenos.layer.cornerRadius = 35
        operadorDividir.layer.cornerRadius = 35
        operadorPorcentaje.layer.cornerRadius = 35
        operadorMultiplicar.layer.cornerRadius = 35
        operadorRestar.layer.cornerRadius = 35
        operadorSumar.layer.cornerRadius = 35
        operadorIgual.layer.cornerRadius = 35
        numero0.layer.cornerRadius = 35
        numero1.layer.cornerRadius = 35
        numero2.layer.cornerRadius = 35
        numero3.layer.cornerRadius = 35
        numero4.layer.cornerRadius = 35
        numero5.layer.cornerRadius = 35
        numero6.layer.cornerRadius = 35
        numero7.layer.cornerRadius = 35
        numero8.layer.cornerRadius = 35
        numero9.layer.cornerRadius = 35
    }
    
    // MARK: - Acciones
    @IBAction func operadorACAccion(_ sender: UIButton) {
        borrar()
    }
    
    @IBAction func operadorMasMenosAccion(_ sender: UIButton) {
        muestraResultado.text = muestraResultado.text?.replacingOccurrences(of: Constants.colon.rawValue, with: Constants.point.rawValue)
        cambioSigno()
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
        resultado = true
        resultadoFinal()
    }
    
    @IBAction func accionDecimal(_ sender: Any) {
        if pulsadoComa {
            return
        } else if resultado {
            muestraResultado.text = Constants.firstDecimal.rawValue
            resultado = false
            decimal = true
        } else {
            decimal = true
            if let decimal = separadorDecimal, let numeroDecimal = muestraResultado.text {
                muestraResultado.text = numeroDecimal + decimal
            }
        }
    }
    
    @IBAction func accionNumeros(_ sender: UIButton) {
        let numero = sender.tag
        operadorAC.titleLabel?.text = Constants.clean.rawValue
        
        if resultado && !operador {
            //Si hemos pulsado la tecla resultado y no activamos ningún operador, resetamos total para nueva operacion con el nuevo número
            muestraResultado.text = String(numero)
            temporal = Float(numero)
            total = 0
            resultado = false
           
        } else {
            if var temporalActual = muestraResultado.text {
                if temporalActual == Constants.firstDecimal.rawValue {
                    comprobarCeroComa(temporalActual: temporalActual, numero: numero)
                }
                
                temporalActual = temporalActual.replacingOccurrences(of: Constants.colon.rawValue, with: Constants.point.rawValue)
            
                if temporalActual == Constants.zero.rawValue {
                    temporalActual.removeAll()
                }
                
                if !operador && temporalActual.count >= digitosMax {
                    return
                }
                
                if operador {
                    total = total == 0 ? temporal : total
                    temporalActual = ""
                    operador = false
                }
                
                if decimal {
                    if let resultado = Float(temporalActual + String(numero)) {
                        temporal = resultado
                        muestraResultado.text = String(temporal)
                    }
                    pulsadoComa = true
                    decimal = false
                }
               
                if let resultado = Float(temporalActual + String(numero)) {
                    temporal = resultado
                    var resultadoString = String(resultado)
                    
                    if !decimal {
                        resultadoString = resultadoString.replacingOccurrences(of: Constants.pointZero.rawValue, with: "")
                    }
                    
                    resultadoString = resultadoString.replacingOccurrences(of: Constants.point.rawValue, with: Constants.colon.rawValue)
                    muestraResultado.text = resultadoString
                }
            
                resultado = false
            }
        }
    }
    
    // MARK: - Funciones
    
    private func borrar() {
        operacion = .ninguna
        resultado = false
        decimal = false
        pulsadoComa = false
        operadorAC.titleLabel?.text = Constants.cleanAC.rawValue
        
        if temporal != 0 {
            temporal = 0
            muestraResultado.text = Constants.zero.rawValue
        } else {
            total = 0
            resultadoFinal()
        }
    }
    
    private func cambioSigno() {
        if let mostradoPantalla = Float(muestraResultado.text ?? "") {
            temporal = mostradoPantalla * (-1)
            total = mostradoPantalla * (-1)
            cambiarPuntoComa()
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
            if !resultado {
                temporal = temporal / 100
                total = temporal
            } else {
                total = total / 100
            }
            operador = false
            break
        }
        
        if total >= valorMax {
            muestraResultado.text = Constants.noPosible.rawValue
        } else {
            cambiarPuntoComa()
        }
        
        pulsadoComa = false
    }
    
    func cambiarPuntoComa() {
        var totalString = String(total)
        let contienePuntoCero = totalString.hasSuffix(Constants.pointZero.rawValue)
        
        if contienePuntoCero {
            totalString = totalString.replacingOccurrences(of: Constants.pointZero.rawValue, with: "")
            muestraResultado.text = totalString
        } else {
            totalString = totalString.replacingOccurrences(of: Constants.point.rawValue, with: Constants.colon.rawValue)
            muestraResultado.text = String(totalString)
        }
    }
    
    func comprobarCeroComa(temporalActual: String, numero: Int) {
        var temporalActualMod = temporalActual
        temporalActualMod = temporalActual.replacingOccurrences(of: Constants.colon.rawValue, with: Constants.point.rawValue)
        
        if let resultado = Float(temporalActualMod + String(numero)) {
            temporal = resultado
            muestraResultado.text = String(resultado).replacingOccurrences(of: Constants.point.rawValue, with: Constants.colon.rawValue)
        }
        total = 0
    }
}
