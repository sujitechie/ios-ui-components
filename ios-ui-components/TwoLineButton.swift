//
//  TwoLineButton.swift
//  ios-ui-components
//
//  Created by sujith on 01/11/22.
//

import UIKit

public struct TwoLineButtonData {
    
    public let primaryLabel: String
    public let secondaryLabel: String
    
    public init(primaryLabel: String, secondaryLabel: String) {
        self.primaryLabel = primaryLabel
        self.secondaryLabel = secondaryLabel
    }
}

final public class TwoLineButton: UIButton {

    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        backgroundColor = .darkGray
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(data: TwoLineButtonData) {
        primaryLabel.text = data.primaryLabel
        secondaryLabel.text = data.secondaryLabel
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        primaryLabel.frame = CGRect(x: 5, y: 0, width: frame.width - 10, height: frame.height / 2)
        secondaryLabel.frame = CGRect(x: 5, y: frame.height / 2, width: frame.width - 10, height: frame.height / 2)
    }
}
