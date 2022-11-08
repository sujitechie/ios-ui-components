//
//  LoadingButton.swift
//  ios-ui-components
//
//  Created by sujith on 03/11/22.
//

import UIKit

public struct LoadingButtonData {
    public let label: String
    
    public init(label: String) {
        self.label = label
    }
}

final public class LoadingButton: UIButton {
    
    private let label: UILabel = {
        let  label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.color = .white
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(container)
        container.addSubview(label)
        container.addSubview(loadingView)
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        loadingView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(data: LoadingButtonData) {
        label.text = data.label
    }
    
    public func showLoading() {
        loadingView.startAnimating()
    }
    
    public func stopLoading() {
        loadingView.stopAnimating()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            loadingView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            loadingView.heightAnchor.constraint(equalToConstant: 24),
            loadingView.widthAnchor.constraint(equalToConstant: 24),
            loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
        ])
    }
    
}
