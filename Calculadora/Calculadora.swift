//
//  ViewController.swift
//  Calculadora
//
//  Created by Sonia Ujaque Ortiz on 2/5/24.
//

import UIKit

class Calculadora: UIViewController {
    
    //Variables
    private var total: Float = 0
    private var temporal: Float = 0
    private var contadorComas = false
    private var operador = false
    private var resultado = false
    private var decimal = false
    private var operacion: TipoOperacion = .ninguna
    
    private let separadorDecimal = Locale.current.decimalSeparator
    private let digitosMax = 9
    private let valorMax: Float = 999999999.0
    
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
    
    //Operadores
    @IBOutlet weak var operadorAC: UIButton!
    @IBOutlet weak var numeroDecimal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    //Acciones
    @IBAction func operadorACAccion(_ sender: UIButton) {
        borrar()
    }
    @IBAction func operadorMasMenosAccion(_ sender: UIButton) {
        muestraResultado.text = muestraResultado.text?.replacingOccurrences(of: ",", with: ".")
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
        
        if contadorComas || resultado {
            return
        } else {
            decimal = true
            if let decimal = separadorDecimal, let numeroDecimal = muestraResultado.text {
               
                muestraResultado.text = numeroDecimal + decimal
            }
        }
        
        
    }
    
    @IBAction func accionNumeros(_ sender: UIButton) {
        
        let numero = sender.tag
       
        operadorAC.titleLabel?.text = "C"
        
        if resultado && !operador{
            //Si hemos pulsado la tecla resultado y no activamos ningún operador, resetamos total para nueva operacion con el nuevo número
            muestraResultado.text = String(numero)
            temporal = Float(numero)
            total = 0
            resultado = false
        } else {
            if var temporalActual = muestraResultado.text {
                
                temporalActual = temporalActual.replacingOccurrences(of: ",", with: ".")
            
                if temporalActual == "0" {
                    temporalActual.removeAll()
                }
                
                if !operador && temporalActual.count >= digitosMax {
                    return
                }
                
                if operador {
                    total = total == 0 ? temporal : total
                    //muestraResultado.text = ""
                    temporalActual = ""
                    operador = false
                    print(total)
                }
                
                if decimal {
                    //temporalActual = temporalActual.replacingOccurrences(of: ",", with: ".")
                    
                    if let resultado = Float(temporalActual + String(numero)) {
                        temporal = resultado
                        muestraResultado.text = String(temporal)
                    }
                    
                    contadorComas = true
                    decimal = false
                }
               
                if let resultado = Float(temporalActual + String(numero)) {
                    temporal = resultado
                    var resultadoString = String(resultado)
                    if !decimal{
                        //let contieneDecimal = resultadoString.hasSuffix(".0")
                        resultadoString = resultadoString.replacingOccurrences(of: ".0", with: "")
                        
                    }
                    resultadoString = resultadoString.replacingOccurrences(of: ".", with: ",")
                    
                    muestraResultado.text = resultadoString
                }
                
                resultado = false
                
                print("TemporalActual: \(temporalActual)")
            }
        }
    }
    
    
    
    //Funciones
    
    private func borrar() {
        operacion = .ninguna
        resultado = false
        decimal = false
        contadorComas = false
        operadorAC.titleLabel?.text = "AC"
        if temporal != 0 {
            temporal = 0
            muestraResultado.text = "0"
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
            
            break
        }
        
        if total >= valorMax {
            muestraResultado.text = "No posible"
            
        } else {
            cambiarPuntoComa()
        }
        
        contadorComas = false
        
        print("Total: \(total) Temporal: \(temporal)")
    }
    
    func cambiarPuntoComa() {
        var totalString = String(total)
        let contienePuntoCero = totalString.hasSuffix(".0")
        
        if contienePuntoCero {
            totalString = totalString.replacingOccurrences(of: ".0", with: "")
            muestraResultado.text = totalString
            
        } else {
            
            totalString = totalString.replacingOccurrences(of: ".", with: ",")
            muestraResultado.text = String(totalString)
        }
    }

}
