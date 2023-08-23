//
//  ScanViewController.swift
//  3DMeshLiDAR
//
//  Created by Mahesh on 22/08/23.
//

import UIKit
import RealityKit
import ARKit

private let logger = getLogger(category: "ScanViewController")

class ScanViewController: UIViewController {
    @IBOutlet private weak var arView: ARView!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var scanStatusLabel: UILabel!
    @IBOutlet private weak var stopAndExportButton: UIButton!
    @IBOutlet private weak var rescanButton: UIButton!
    private(set) lazy var viewModel = ScanViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.hidesBackButton = true
        initARView()
        setupUI()
    }
    
    private func initARView() {
        arView.session.delegate = self
        arView.debugOptions.insert(.showSceneUnderstanding)
        cronfigureAndStartARSession()
    }
    private func cronfigureAndStartARSession() {
        let configuration = viewModel.buildConfigure()
        arView.session.run(configuration)
        scanStatusLabel.isHidden = false
    }
    private func pauseARSession() {
        arView?.session.pause()
        arView?.scene.anchors.removeAll()
        scanStatusLabel.isHidden = true
    }
    private func restartARSession() {
        if let configuration = arView?.session.configuration {
            arView?.session.run(configuration)
            scanStatusLabel.isHidden = false
        }
    }
    private func setupUI() {
        descLabel.text = viewModel.info
        descLabel.cornerRadius = 5
        stopAndExportButton.cornerRadius = 5
        rescanButton.cornerRadius = 5
        descLabel.layer.masksToBounds = true
    }
}

extension ScanViewController {
    @IBAction private func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction private func rescanButtonAction(_ sender: UIButton) {
        restartARSession()
    }
    @IBAction private func stopAndExportButtonAction(_ sender: UIButton) {
        scanStatusLabel.isHidden = true
        guard let camera = arView.session.currentFrame?.camera else {return}
        if let meshAnchors = arView.session.currentFrame?.anchors.compactMap({ $0 as? ARMeshAnchor }),
           let asset = viewModel.convertToAsset(meshAnchors: meshAnchors, camera: camera) {
            do {
                let url = try viewModel.export(asset: asset)
                let viewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                viewController.popoverPresentationController?.sourceView = sender
                self.present(viewController, animated: true, completion: {
                    self.pauseARSession()
                })
            } catch {
                logger.log("export error")
            }
        }
    }
}

extension ScanViewController: ARSessionDelegate {
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
}
