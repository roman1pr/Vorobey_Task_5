//
//  PopoverVC.swift
//  Vorobey_Task_5
//
//  Created by Roman Priiskalov on 15.09.2023.
//

import UIKit

class PopoverVC: UIViewController {
    
    enum PopoverType: CGFloat, CaseIterable {
        case big = 280
        case small = 150
        
        var title: String {
            return "\(Int(self.rawValue))pt"
        }
        
        var segmentIndex: Int {
            switch self {
            case .big:
                return 0
            case .small:
                return 1
            }
        }
    }
    
    private var type: PopoverType = .big
    
    private lazy var segmentView = {
        let actions = PopoverType.allCases.map { type in
            UIAction(title: type.title, handler: { _ in self.updateView(for: type) })
        }
        
        return UISegmentedControl(frame: .zero, actions: actions)
    }()
    
    private lazy var closeButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        view.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(segmentView)
        view.addSubview(closeButton)
        
        self.view.backgroundColor = .white
        
        updateView(for: .big)
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            segmentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: segmentView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func updateView(for type: PopoverType) {
        UIView.animate(withDuration: 0.2) {
            self.preferredContentSize = .init(width: self.view.frame.width, height: type.rawValue)
        }
        
        segmentView.selectedSegmentIndex = type.segmentIndex
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
}
