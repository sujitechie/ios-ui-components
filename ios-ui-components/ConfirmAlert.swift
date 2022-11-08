//
//  ConfirmAlert.swift
//  ios-ui-components
//
//  Created by sujith on 07/11/22.
//

import Foundation
import UIKit

final public class ConfirmAlert {
    
    private let alertViewHeight: CGFloat = 200.0
    
    private var confirmAlertCompletion: ((Bool)->Void)?
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0)
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 10
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    private let confirmButton: UIButton = {
        let confirmButton = UIButton()
        confirmButton.backgroundColor = .link
        confirmButton.layer.cornerRadius = 10
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmButton
    }()
    
    private let dismissButton: UIButton = {
        let dismissButton = UIButton()
        dismissButton.backgroundColor = .darkGray
        dismissButton.layer.cornerRadius = 10
        dismissButton.setTitle("Close", for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        return dismissButton
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var alertViewCenterYConstraint: NSLayoutConstraint!
    
    public init() {
        confirmAlertCompletion = nil
        
        let closeButtonAction = UIAction { action in
            self.dismissAlert()
            if let completion = self.confirmAlertCompletion {
                completion(false)
            }
        }
        dismissButton.addAction(closeButtonAction, for: .touchUpInside)
        
        let confirmButtonAction = UIAction { action in
            self.dismissAlert()
            if let completion = self.confirmAlertCompletion {
                completion(true)
            }
        }
        confirmButton.addAction(confirmButtonAction, for: .touchUpInside)
    
    }
    
    public func showAlert(title: String, message: String, on viewController: UIViewController, completion: @escaping (Bool)->Void) {
        
        confirmAlertCompletion =  completion
                
        guard let targetView = viewController.view else {
            return
        }
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        // Add content to background view
        backgroundView.addSubview(alertView)
        
        // Add title label
        titleLabel.text = title
        alertView.addSubview(titleLabel)
        
        // Add messagae label
        messageLabel.text = message
        alertView.addSubview(messageLabel)
        
        // Add confirm button to stack view
        stackView.addArrangedSubview(confirmButton)
        
        // Add dismiss button to stack view
        stackView.addArrangedSubview(dismissButton)
        
        // Add stackview
        alertView.addSubview(stackView)

        setupConstraints()
        
        // Animate the background view from top to centre
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        } completion: { completed in
            if(completed) {
                self.alertViewCenterYConstraint.constant = 0
                UIView.animate(withDuration: 0.25) {
                    self.backgroundView.layoutIfNeeded()
                }
            }
        }
    }
    
    private func setupConstraints() {
        
        // Initially alert view will be on top, invisible to screen
        alertViewCenterYConstraint = alertView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: -backgroundView.bounds.height)
        
        NSLayoutConstraint.activate([
            alertView.heightAnchor.constraint(equalToConstant: alertViewHeight),
            alertView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            alertView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            alertViewCenterYConstraint,
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            
            stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            
//            confirmButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -8),
//            confirmButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
//            confirmButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
//
//            dismissButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -8),
//            dismissButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
//            dismissButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
        ])
    }
    
    private func dismissAlert() {
        self.alertViewCenterYConstraint.constant = backgroundView.bounds.height
        UIView.animate(withDuration: 0.25) {
           self.backgroundView.layoutIfNeeded()
            
        } completion: { completed in
            if(completed) {
                UIView.animate(withDuration: 0.25) {
                    self.backgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0)
                } completion: { completed in
                    if(completed) {
                        self.titleLabel.removeFromSuperview()
                        self.messageLabel.removeFromSuperview()
                        self.dismissButton.removeFromSuperview()
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                }
            }
        }
    }
       
}


