//
//  OutlookEditorOptionIconView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import UIKit

final class OutlookEditorOptionIconView: UIView {
    override init(frame: CGRect) {
        self.button = CustomToolbarButton()
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        self.button = CustomToolbarButton()
        super.init(coder: coder)
        self.setup()
    }

    var normalColor: UIColor = .white {
        didSet {
            if !self.isSelected {
                self.backgroundColor = self.normalColor
            }
        }
    }

    var selectedColor: UIColor = .gray {
        didSet {
            if self.isSelected {
                self.backgroundColor = self.selectedColor
            }
        }
    }

    var normalImage: UIImage? {
        didSet {
            self.button.setImage(self.normalImage, for: .normal)
        }
    }

    var selectedImage: UIImage? {
        didSet {
            self.button.setImage(self.selectedImage, for: .selected)
        }
    }

    var action: (() -> Void)?
    var actionType: ToolbarActionType?

    private var isSelected = false {
        didSet {
            self.button.isSelected = self.isSelected
            self.backgroundColor = self.isSelected ? self.selectedColor : self.normalColor
        }
    }

    private let button: CustomToolbarButton
}

extension OutlookEditorOptionIconView: OutlookEditorOptionSelectableProtocol {
    func setSelected(by action: ToolbarActionType) {
        guard let actionType = self.actionType else {
            return
        }
        self.isSelected = action.contains(actionType)
    }
}

extension OutlookEditorOptionIconView {
    private func setup() {
        self.backgroundColor = self.normalColor

        self.button.tapHandler = { [weak self] in
            self?.isSelected = !(self?.isSelected ?? false)
            self?.action?()
        }
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.button)
        NSLayoutConstraint.activate([self.button.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }
}
