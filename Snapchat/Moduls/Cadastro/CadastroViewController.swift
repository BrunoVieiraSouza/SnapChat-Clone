//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Bruno Vieira Souza on 21/03/22.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {
    
    private var homeView: ViewController?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmeSenha: UITextField!
    
    //MARK: - Cicle life
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ocultar navigationBar
    }
    
    
    //MARK: - IBActions
    
    @IBAction func criarConta(_ sender: UIButton) {
        
        guard let email = self.email.text else {
            return
        }
        guard let senha = self.senha.text else {
            return
        }
        guard let confirmeSenha = self.confirmeSenha.text else {
            return
        }
        
        if senha == confirmeSenha {
            
            let autenticacao = Auth.auth()
            
            autenticacao.createUser(withEmail: email, password: senha) { result, error in
                
                if error == nil {
                    if result == nil {
                        let alerta = Alertas(titulo: "Erro ao autenticar", mensagem: "Problemas ao autenticar, tente novamente" )
                        self.present(alerta.exibirAlert(), animated: true, completion: nil)
                        
                    } else {
                        self.homeView?.presentView()
                    }
                } else {
                    
                    let erroR = error! as NSError
                    
                    if let codigoErro = erroR.userInfo["FIRAuthErrorUserInfoNameKey"] {
                        let errorText = codigoErro as! String
                        var mensageErro = ""
                        
                        switch errorText {
                        case "ERROR_INVALID_EMAIL" :
                            mensageErro = "E-mail invalido, digite um e-mail valido"
                            break
                        case "ERROR_WEAK_PASSWORD" :
                            mensageErro = "Escolha uma senha no minimo de 6 caracteres"
                            break
                        case "ERROR_EMAIL_ALREADY_IN_USE" :
                            mensageErro = "E-mail já cadastrado!"
                            break
                        default:
                            mensageErro = "Dados incorretos"
                        }
                        let alerta = Alertas(titulo: "Erro ao autenticar", mensagem: mensageErro )
                        self.present(alerta.exibirAlert(), animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            let alerta = Alertas(titulo: "Dados incorretos", mensagem: "Senhas não conferem" )
            self.present(alerta.exibirAlert(), animated: true, completion: nil)
        }
    }
}
