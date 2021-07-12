//
//  OutlookAdditionOptionsView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import UIKit

final class OutlookAdditionOptionsView: UIView {
    override init(frame: CGRect) {
        self.scrollView = UIScrollView()
        self.stackView = UIStackView()
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        self.scrollView = UIScrollView()
        self.stackView = UIStackView()
        super.init(coder: coder)
        self.setup()
    }

    var options: [OutlookAdditionOption] = [] {
        didSet {
            self.update()
        }
    }
    
    var changeStateHandler: (() -> Void)?

    var customEditorImage: UIImage? {
        didSet {
            self.editorButton?.setImage(self.editorImage, for: .normal)
        }
    }

    private let scrollView: UIScrollView
    private let stackView: UIStackView
    private var editorButton: UIButton?
}

extension OutlookAdditionOptionsView {
    private func setup() {
        self.backgroundColor = .clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.scrollView.backgroundColor = .clear
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false

        self.stackView.backgroundColor = .clear
        self.stackView.alignment = .fill
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 10
        self.stackView.axis = .horizontal
        self.stackView.translatesAutoresizingMaskIntoConstraints = false

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.scrollView.addSubview(self.stackView)
        self.addSubview(self.scrollView)
        NSLayoutConstraint.activate([self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 7),
                                     self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -7),
                                     self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                     self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                                     ])
        
        
    }

    private func update() {
        self.stackView.arrangedSubviews.forEach { self.stackView.removeArrangedSubview($0); $0.removeFromSuperview() }
        self.editorButton = nil
        self.options.forEach { option in
            let button = CustomToolbarButton {
                option.action?()
            }
            button.setImage(option.image, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.addArrangedSubview(button)
            NSLayoutConstraint.activate([button.heightAnchor.constraint(equalToConstant: 40),
                                         button.widthAnchor.constraint(equalToConstant: 40)])
        }
        self.addEditorOptionsButton()
    }

    private func addEditorOptionsButton() {
        let button = CustomToolbarButton { [weak self] in
            self?.changeStateHandler?()
        }
        button.setImage(self.editorImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(button)
        NSLayoutConstraint.activate([button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
        self.editorButton = button
    }

    private var editorImage: UIImage? {
        self.customEditorImage ?? UIImage(named: "editor", in: Bundle.customToolbars, compatibleWith: nil)
    }
}
