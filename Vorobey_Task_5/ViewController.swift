//
//  ViewController.swift
//  Vorobey_Task_5
//
//  Created by Roman Priiskalov on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var presentButton: UIButton = {
        let view = UIButton()
        view.configuration = UIButton.Configuration.plain()
        view.configuration?.title = "Present"
        view.addTarget(self, action: #selector(showPopover), for: [.touchUpInside, .touchUpOutside])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var popover: UIViewController {
        let controller = PopoverVC()
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.permittedArrowDirections = .up
        controller.popoverPresentationController?.sourceView = presentButton
        controller.popoverPresentationController?.delegate = self
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(presentButton)

        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func showPopover() {
        present(popover, animated: true)
    }
    
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
