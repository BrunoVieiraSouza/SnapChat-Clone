//
//  ViewController.swift
//  Snapchat
//
//  Created by Bruno Vieira Souza on 21/03/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    //MARK: - Life Cicles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // deslogarUser()
        autentincBool()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false) // ocultar navigationBar
    }
    
    //MARK: - Metodos
    
    func presentView() {
        guard let vc = UIStoryboard(name: "MainScreen", bundle: nil).instantiateViewController(withIdentifier: "MainScreen") as? MainScreenViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func autentincBool() {
        let autenticacao = Auth.auth()
        autenticacao.addStateDidChangeListener { auth, user in
            self.presentView()
        }
    }
}

