//
//  AlertForCellName.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit

extension UIViewController {
    func alertForCellName(label: UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> ()) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text  else { return  }
            if text.count > 0 {
                label.text = text
                completionHandler(text)
            }
        }
        
        alert.addTextField { tfAlert in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
