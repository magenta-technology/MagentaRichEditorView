//
//  OutlookEditorSectionView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import UIKit

final class OutlookEditorSectionView: UIView {
    override init(frame: CGRect) {
        self.stackView = UIStackView()
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        self.stackView = UIStackView()
        super.init(coder: coder)
        self.setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }

    var options: [OutlookEditorSectionOption] = [] {
        didSet {
            self.update()
        }
    }

    var textColor: UIColor = .white {
        didSet {
            self.stackView.arrangedSubviews.forEach { view in
                if let textView = view as? OutlookEditorOptionTextView {
                    textView.textColor = self.textColor
                }
            }
        }
    }

    var normalColor: UIColor = .white {
        didSet {
            self.stackView.arrangedSubviews.forEach { view in
                if let textView = view as? OutlookEditorOptionTextView {
                    textView.normalColor = self.normalColor
                } else if let iconView = view as? OutlookEditorOptionIconView {
                    iconView.normalColor = self.normalColor
                }
            }
        }
    }

    var selectedColor: UIColor = .gray {
        didSet {
            self.stackView.arrangedSubviews.forEach { view in
                if let iconView = view as? OutlookEditorOptionIconView {
                    iconView.selectedColor = self.selectedColor
                }
            }
        }
    }

    private let stackView: UIStackView
}

extension OutlookEditorSectionView: OutlookEditorOptionSelectableProtocol {
    func setSelected(by action: ToolbarActionType) {
        self.stackView.arrangedSubviews.forEach { view in
            if let selectable = view as? OutlookEditorOptionSelectableProtocol {
                selectable.setSelected(by: action)
            }
        }
    }
}

extension OutlookEditorSectionView {
    private func setup() {
        self.backgroundColor = .clear
        self.clipsToBounds = true

        self.stackView.backgroundColor = .clear
        self.stackView.alignment = .fill
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 2
        self.stackView.axis = .horizontal
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        NSLayoutConstraint.activate([self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
                                     self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }

    private func update() {
        self.stackView.arrangedSubviews.forEach { self.stackView.removeArrangedSubview($0); $0.removeFromSuperview() }
        self.options.forEach { option in
            switch option {
            case let .text(textsPararms):
                let textView = OutlookEditorOptionTextView()
                textView.textColor = self.textColor
                textView.normalColor = self.normalColor
                textView.textsPararms = textsPararms
                textView.translatesAutoresizingMaskIntoConstraints = false
                self.stackView.addArrangedSubview(textView)
                NSLayoutConstraint.activate([textView.heightAnchor.constraint(equalTo: self.stackView.heightAnchor)])
            case let .image(normalImage, selectedImage, actionType, action):
                let iconView = OutlookEditorOptionIconView()
                iconView.normalColor = self.normalColor
                iconView.selectedColor = self.selectedColor
                iconView.normalImage = normalImage
                iconView.selectedImage = selectedImage
                iconView.action = action
                iconView.actionType = actionType
                iconView.translatesAutoresizingMaskIntoConstraints = false
                self.stackView.addArrangedSubview(iconView)
                NSLayoutConstraint.activate([iconView.widthAnchor.constraint(equalToConstant: 40),
                                             iconView.heightAnchor.constraint(equalTo: self.stackView.heightAnchor)])
            }
        }
    }
}
