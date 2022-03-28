//
//  MainScreenViewController.swift
//  Snapchat
//
//  Created by Bruno Vieira Souza on 23/03/22.
//

import UIKit
import FirebaseAuth

class MainScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func deslogarUser() {
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            let alerta = Alertas(titulo: "Erro", mensagem: "Não foi possivel deslogar, tente novamente")
        }
    }
    
    @IBAction func sair(_ sender: UIBarButtonItem) {
        deslogarUser()
    }
}
