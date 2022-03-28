//
//  Alertas.swift
//  Snapchat
//
//  Created by Bruno Vieira Souza on 28/03/22.
//

import Foundation
import UIKit

class Alertas {
    
    var titulo: String
    var mensagem: String
    
    init(titulo: String, mensagem: String) {
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func exibirAlert() -> UIAlertController {
        
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(acaoCancelar)
        
        return alert
    }
}
