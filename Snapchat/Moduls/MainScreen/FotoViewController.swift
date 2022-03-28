//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Bruno Vieira Souza on 24/03/22.
//

import UIKit
import FirebaseStorage

class FotosViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    //MARK: - Propriedades
    
    var idImagem = NSUUID().uuidString // gerar um identificador unico para cada imagem
    var imagePicker = UIImagePickerController()
    
    //MARK: - Cicle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = .gray
        
    }
    
    //MARK: - Metodos
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[ UIImagePickerController.InfoKey.originalImage ] as! UIImage
        imagem.image = imagemRecuperada
        
        //Habilitar botão proximo.
        botaoProximo.isEnabled = true
        botaoProximo.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func selecionarFoto(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func proximoPasso(_ sender: UIButton) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference() // esse reference aponta para a raiz do armazenamento
        let imagens = armazenamento.child("imagens") // criar pastas para os arquivos
        
        //Recuperar a imagem
        if let imagemSelecionada = imagem.image {
            if let imagemDados = imagemSelecionada.jpegData(compressionQuality: 0.1) {
                imagens.child("\(self.idImagem).jpg").putData(imagemDados, metadata: nil) { metaDados, erro in
                    if erro == nil {
                        print("deu certo")
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    } else {
                        print("erro ao fazer o upload")
                        let alerta = Alertas(titulo: "Upload falhou", mensagem: "Erro ao salvar o arquivo, tente novamente")
                        self.present(alerta.exibirAlert(), animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

    //MARK: - Extenções

extension FotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
