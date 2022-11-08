//
//  IconButton.swift
//  ios-ui-components
//
//  Created by sujith on 04/11/22.
//

import UIKit
import UIKit

public struct IconButtonData {
    public let label: String
    public let icon: UIImage?
    
    public init(label: String, icon: UIImage?) {
        self.label = label
        self.icon = icon
    }
}

final public class IconButton: UIButton {
    
    private let label: UILabel = {
        let  label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.tintColor = .white
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let container: UIView = {
        let view = UIView()
//        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(container)
        container.addSubview(label)
        container.addSubview(icon)
        icon.startAnimating()
        backgroundColor = .darkGray
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(data: IconButtonData) {
        label.text = data.label
        icon.image = data.icon
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
//        icon.frame = CGRect(x: 5, y: 5, width: 25, height: 25)
//        label.frame = CGRect(x: 5, y: 0, width: frame.width - 10, height: frame.height / 2)
    }
    
    private func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
           
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
