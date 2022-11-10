//
//  CheckBox.swift
//  ios-ui-components
//
//  Created by sujith on 08/11/22.
//

import UIKit

public struct CheckBoxData {
    public let isChecked: Bool
    public let labelRequired: Bool
    public let labelTitle : String
    
    public init(isChecked: Bool, labelRequired: Bool = false, labelTitle: String = "") {
        self.isChecked = isChecked
        self.labelRequired = labelRequired
        self.labelTitle = labelTitle
    }
}

final public class CheckBox: UIView {
    
    // Modify this to change checkbox width
    private let checkBoxWidth: CGFloat = 40.0
    
    private var isChecked: Bool = false
    
    private var completion: ((Bool)->Void)?
    
    private let square: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "square")
        image.tintColor = .darkGray
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let checkMark: UIImageView = {
        let checkMark = UIImageView()
        checkMark.image = UIImage(systemName: "checkmark")
        checkMark.contentMode = .scaleAspectFit
        checkMark.tintColor = .white
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        return checkMark
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(square)
        addSubview(checkMark)
        addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        
    }
    
    public func config(data: CheckBoxData, completion: ((Bool)->Void)? ) {
        self.isChecked = data.isChecked
        self.completion = completion
        if !data.labelRequired {
            label.removeFromSuperview()
        }
        label.text = data.labelTitle
        updateCheckMark()
        
        // Setup constraints
        setupConstraints(data: data)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
       isChecked = !isChecked
        if let completion = self.completion {
            completion(isChecked)
        }
       updateCheckMark()
    }
    
    private func updateCheckMark() {
        if isChecked {
            checkMark.isHidden = false
        } else {
            checkMark.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupConstraints(data: CheckBoxData){
        
        NSLayoutConstraint.activate([
            square.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            square.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            square.widthAnchor.constraint(equalToConstant: checkBoxWidth),
            
            checkMark.topAnchor.constraint(equalTo: square.topAnchor, constant: 4),
            checkMark.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -4),
            checkMark.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 4),
            checkMark.trailingAnchor.constraint(equalTo: square.trailingAnchor, constant: -4)
        ])
        
        let centerSquareConstraint = square.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: square.trailingAnchor, constant: 16),
        ]
        
        if(data.labelRequired) {
            NSLayoutConstraint.activate(labelConstraints)
        } else {
            NSLayoutConstraint.activate([centerSquareConstraint])
        }
    }
    
}
