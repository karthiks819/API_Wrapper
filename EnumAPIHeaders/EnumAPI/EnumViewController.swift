//
//  EnumViewController.swift
//  EnumAPIHeaders
//
//  Created by Karthik on 06/06/21.
//

import UIKit

class EnumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        APIClient.login(email: "sumitkapoor.shineweb@gmail.com", password: "0987654321", deviceId: "sdfsfdsfsfsdfdsfdsfdsfdsfdsf") { result in
//            Constants.loader.removeLoader(controller: self)
//            switch result {
//            case .success(let msg):
//                // TODO: fixed this
//
//           print(msg)
//            case .failure(let error):
//
//                self.showMessage(title: "Login Error", message: error.underlyingError!.localizedDescription, completion: nil)
//            }
//
//        }
        Constants.loader.showLoaderInPopUp(view: self.view)
        
        APIClient.getRSS(pageNo: 20) { result in
            Constants.loader.removeLoader(controller: self)
            switch result{
            
            case .success(let msg):
                print(msg)
                break
            case .failure(let err):
                print(err)
                
                break
            
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    //1615|Rl6XMTVinDMZ4XOdy0Etgp2Iz8rasnsWEiWgqoMhmlMu7HGjj223BzZxwiQSnokQzbBG2XO0eEhfI1Uq
}
