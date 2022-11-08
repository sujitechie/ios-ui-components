//
//  InputAlert.swift
//  ios-ui-components
//
//  Created by sujith on 08/11/22.
//

import Foundation
import UIKit

final public class InputAlert {
    
    private let alertViewHeight: CGFloat = 200.0
    
    private var inputAlertCompletion: ((String?)->Void)?
    
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
    
    private let inputText: UITextField = {
        let inputView = UITextField()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.backgroundColor = .systemGray5
        inputView.layer.cornerRadius = 10
        inputView.setPadding(left: 16, right: 16)
        return inputView
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
        inputAlertCompletion = nil
        let closeButtonAction = UIAction { action in
            self.dismissAlert()
            if let completion = self.inputAlertCompletion {
                completion(nil)
            }
        }
        dismissButton.addAction(closeButtonAction, for: .touchUpInside)
        
        let confirmButtonAction = UIAction { action in
            self.dismissAlert()
            if let completion = self.inputAlertCompletion {
                completion(self.inputText.text)
            }
        }
        confirmButton.addAction(confirmButtonAction, for: .touchUpInside)
    
    }
    
    public func showAlert(title: String, message: String, on viewController: UIViewController, completion: @escaping (String?)->Void) {
        
        inputAlertCompletion =  completion
                
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
        
        // Add message label
        messageLabel.text = message
        alertView.addSubview(messageLabel)
        
        // Add text field
        inputText.text = ""
        alertView.addSubview(inputText)
        
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
            
            inputText.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            inputText.heightAnchor.constraint(equalToConstant: 50),
            inputText.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            inputText.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            
            stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
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

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat? = nil) {
        setLeftPadding(left)
        if let rightPadding = right {
            setRightPadding(rightPadding)
        }
    }

    private func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    private func setRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

