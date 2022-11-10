//
//  ViewController.swift
//  example
//
//  Created by sujith on 01/11/22.
//

import UIKit
import ios_ui_components

class ViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let loadingButton: LoadingButton = {
        let loadingButton = LoadingButton()
        loadingButton.config(data: LoadingButtonData(label: "Sign up!!"))
        loadingButton.translatesAutoresizingMaskIntoConstraints = false
        return loadingButton
    }()
    
    let twoLineButton: TwoLineButton = {
        let twoLineButton = TwoLineButton()
        twoLineButton.config(data: TwoLineButtonData(primaryLabel: "Buy Now", secondaryLabel: "20$ Extra Later"))
        twoLineButton.translatesAutoresizingMaskIntoConstraints = false
        return twoLineButton
    }()
    
    let iconButton: IconButton = {
        let iconButton = IconButton()
        iconButton.config(data: IconButtonData(label: "Save Profile", icon: UIImage(systemName: "square.and.arrow.down")))
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        return iconButton
    }()
    
    let showAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Alert", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let showConfirmAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Confirm Alert", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let showInputAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Input Alert", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let checkBox: CheckBox = {
        let checkBox = CheckBox()
        checkBox.config(data: CheckBoxData(isChecked: true, labelRequired: true, labelTitle: "Checkbox"), completion: {
            state in
            print(state)
        })
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()

    private let alert = Alert()
    
    private let confirmAlert = ConfirmAlert()
    
    private let inputAlert = InputAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        //add components to scroll view
        scrollView.addSubview(loadingButton)
        scrollView.addSubview(twoLineButton)
        scrollView.addSubview(iconButton)
        scrollView.addSubview(showAlertButton)
        scrollView.addSubview(showConfirmAlertButton)
        scrollView.addSubview(showInputAlertButton)
        scrollView.addSubview(checkBox)
        
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .lightGray
        
        showAlertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        showConfirmAlertButton.addTarget(self, action: #selector(confirmAlertButtonTapped), for: .touchUpInside)
        showInputAlertButton.addTarget(self, action: #selector(inputAlertButtonTapped), for: .touchUpInside)
    
        
        loadingButton.center = view.center
        loadingButton.showLoading()

        view.addSubview(loadingButton)
        
        // stop loading animation after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.loadingButton.stopLoading()
        })
        
        setupConstraints()
    }
    
    @objc private func alertButtonTapped() {
        alert.showAlert(title: "Alert Message", message: "custom message from view controller. custom message from view controller. custom ", on: self) { closed in
            if closed {
                print("alert closed")
            }
        }
    }
    
    @objc private func confirmAlertButtonTapped() {
        confirmAlert.showAlert(title: "Delete User", message: "Are you sure you want to delete this user from the system?", on: self) { confirmed in
            if confirmed {
                print("action confirmed")
            } else {
                print("action closed")
            }
        }
    }
    
    @objc private func inputAlertButtonTapped() {
        inputAlert.showAlert(title: "Add User", message: "Add new user to the system.", on: self) { data in
            if let data = data {
                print(data)
            } else {
                print("no data")
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            loadingButton.heightAnchor.constraint(equalToConstant: 50),
            loadingButton.widthAnchor.constraint(equalToConstant: 300),
            loadingButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
           
            
            twoLineButton.topAnchor.constraint(equalTo: loadingButton.bottomAnchor, constant: 16),
            twoLineButton.heightAnchor.constraint(equalToConstant: 60),
            twoLineButton.widthAnchor.constraint(equalToConstant: 300),
            twoLineButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            iconButton.topAnchor.constraint(equalTo: twoLineButton.bottomAnchor, constant: 16),
            iconButton.heightAnchor.constraint(equalToConstant: 50),
            iconButton.widthAnchor.constraint(equalToConstant: 300),
            iconButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            showAlertButton.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 16),
            showAlertButton.heightAnchor.constraint(equalToConstant: 50),
            showAlertButton.widthAnchor.constraint(equalToConstant: 300),
            showAlertButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            showConfirmAlertButton.topAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: 16),
            showConfirmAlertButton.heightAnchor.constraint(equalToConstant: 50),
            showConfirmAlertButton.widthAnchor.constraint(equalToConstant: 300),
            showConfirmAlertButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            showInputAlertButton.topAnchor.constraint(equalTo: showConfirmAlertButton.bottomAnchor, constant: 16),
            showInputAlertButton.heightAnchor.constraint(equalToConstant: 50),
            showInputAlertButton.widthAnchor.constraint(equalToConstant: 300),
            showInputAlertButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            checkBox.topAnchor.constraint(equalTo: showInputAlertButton.bottomAnchor, constant: 16),
            checkBox.heightAnchor.constraint(equalToConstant: 40),
            checkBox.widthAnchor.constraint(equalToConstant: 300),
            checkBox.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
        ])
        
        
    }

}

