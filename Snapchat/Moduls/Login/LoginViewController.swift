//
//  LoginViewController.swift
//  Snapchat
//
//  Created by Bruno Vieira Souza on 21/03/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - Propriedades da Classe
    
    private var homeView: ViewController?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    //MARK: - Life Cicles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       self.navigationController?.setNavigationBarHidden(false, animated: false) // ocultar navigationBar
        
    }
    
    //MARK: - IBActions
    
    @IBAction func entrar(_ sender: UIButton) {
        guard let email = self.email.text else {
            return
        }
        guard let senha = self.senha.text else {
            return
        }
        let autenticacao = Auth.auth()
        autenticacao.signIn(withEmail: email, password: senha) { result, error in
            if error == nil {
                if result == nil {
                    let alerta = Alertas(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar a autenticação")
                    self.present(alerta.exibirAlert(), animated: true, completion: nil)
                } else {
                    self.homeView?.presentView()
                }
                
            } else {
                let alerta = Alertas(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente")
                self.present(alerta.exibirAlert(), animated: true, completion: nil)
            }
        }
    }
}
