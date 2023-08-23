//
//  Controller.swift
//  3DMeshLiDAR
//
//  Created by Mahesh on 22/08/23.
//

import UIKit

extension UIViewController {
    func instantiateVC(storyboard name: String, withIdentifier id: String) -> UIViewController {
        let newStoryboard = UIStoryboard(name: name, bundle: nil)
        return newStoryboard.instantiateViewController(withIdentifier: id)
    }
    
    func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}
