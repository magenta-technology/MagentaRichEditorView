//
//  CustomToolbarButton.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 24.10.2020.
//

import UIKit

final class CustomToolbarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    convenience init(type: ToolbarActionType? = nil,
                     action: (() -> Void)?) {
        self.init()
        self.tapHandler = action
    }
    
    var tapHandler: (() -> Void)?
    var type: ToolbarActionType?
}

extension CustomToolbarButton {
    private func setup() {
        self.addTarget(self, action: #selector(CustomToolbarButton.tapped), for: .touchUpInside)
    }

    @objc private func tapped() {
        self.tapHandler?()
    }
}
