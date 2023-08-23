//
//  ViewController.swift
//  3DMeshLiDAR
//
//  Created by Mahesh on 22/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    private(set) lazy var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.title
    }
    @IBAction private func scanButtonAction(_ sender: Any) {
        guard let controller = self.instantiateVC(storyboard: "Main", withIdentifier: Constants.ViewControllerId.scanViewController) as? ScanViewController else { return }
        self.pushVC(controller)
    }
}
