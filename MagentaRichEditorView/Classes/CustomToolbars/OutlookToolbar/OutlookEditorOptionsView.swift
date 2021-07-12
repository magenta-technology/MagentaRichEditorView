//
//  OutlookEditorOptionsView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import UIKit

final class OutlookEditorOptionsView: UIView {
    override init(frame: CGRect) {
        self.scrollView = UIScrollView()
        self.stackView = UIStackView()
        self.closeView = UIView()
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        self.scrollView = UIScrollView()
        self.stackView = UIStackView()
        self.closeView = UIView()
        super.init(coder: coder)
        self.setup()
    }

    var sections: [OutlookEditorSection] = [] {
        didSet{
            self.update()
        }
    }

    var changeStateHandler: (() -> Void)?
    
    var textColor: UIColor = .white {
        didSet {
            self.stackView.arrangedSubviews.forEach { view in
                if let sectionView = view as? OutlookEditorSectionView {
                    sectionView.textColor = self.textColor
                }
            }
        }
    }

    var normalColor: UIColor = .white {
        didSet {
            self.closeView.backgroundColor = self.normalColor
            self.stackView.arrangedSubviews.forEach { view in
                if let sectionView = view as? OutlookEditorSectionView {
                    sectionView.normalColor = self.normalColor
                }
            }
        }
    }

    var selectedColor: UIColor = .gray {
        didSet {
            self.stackView.arrangedSubviews.forEach { view in
                if let sectionView = view as? OutlookEditorSectionView {
                    sectionView.selectedColor = self.selectedColor
                }
            }
        }
    }
    
    var customCloseImage: UIImage? {
        didSet {
            self.closeButton?.setImage(self.closeImage, for: .normal)
        }
    }
    
    var shadowColor: UIColor = .clear {
        didSet {
            self.closeView.layer.shadowColor = self.shadowColor.cgColor
        }
    }

    func setSelected(by action: ToolbarActionType) {
        self.stackView.arrangedSubviews.forEach { view in
            if let section = view as? OutlookEditorSectionView {
                section.setSelected(by: action)
            }
        }
    }

    private let scrollView: UIScrollView
    private let stackView: UIStackView
    private let closeView: UIView
    private var closeButton : UIButton?
}

extension OutlookEditorOptionsView {
    private func setup() {
        self.backgroundColor = .clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.scrollView.backgroundColor = .clear
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.scrollView.delegate = self

        self.stackView.backgroundColor = .clear
        self.stackView.alignment = .fill
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 10
        self.stackView.axis = .horizontal
        self.stackView.translatesAutoresizingMaskIntoConstraints = false

        self.closeView.layer.cornerRadius = 18
        self.closeView.backgroundColor = .gray
        self.closeView.translatesAutoresizingMaskIntoConstraints = false
        self.closeView.layer.shadowColor = self.shadowColor.cgColor
        self.closeView.layer.shadowOpacity = 0
        self.closeView.layer.shadowOffset = .zero
        self.closeView.layer.shadowRadius = 3
        self.closeView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 30, y: -4, width: 15, height: 44)).cgPath

        self.scrollView.addSubview(self.stackView)
        self.addSubview(self.scrollView)
        self.addSubview(self.closeView)
        NSLayoutConstraint.activate([self.scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.scrollView.heightAnchor.constraint(equalToConstant: 36),
                                     self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 46),
                                     self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
                                     self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                     self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                                     self.closeView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.closeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                                     self.closeView.widthAnchor.constraint(equalToConstant: 36),
                                     self.closeView.heightAnchor.constraint(equalToConstant: 36)
                                     ])
        self.setupCloseButton()
    }

    private func update() {
        self.stackView.arrangedSubviews.forEach { self.stackView.removeArrangedSubview($0); $0.removeFromSuperview() }
        self.sections.forEach { section in
            let sectionView = OutlookEditorSectionView()
            sectionView.options = section.items
            sectionView.textColor = self.textColor
            sectionView.normalColor = self.normalColor
            sectionView.selectedColor = self.selectedColor
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.addArrangedSubview(sectionView)
            NSLayoutConstraint.activate([sectionView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)])
        }
    }

    private func setupCloseButton() {
        let button = CustomToolbarButton { [weak self] in
            self?.changeStateHandler?()
        }
        button.setImage(self.closeImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.closeView.addSubview(button)
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: self.closeView.topAnchor),
                                     button.bottomAnchor.constraint(equalTo: self.closeView.bottomAnchor),
                                     button.leadingAnchor.constraint(equalTo: self.closeView.leadingAnchor),
                                     button.trailingAnchor.constraint(equalTo: self.closeView.trailingAnchor)])
        self.closeButton = button
    }
    
    private var closeImage: UIImage? {
        self.customCloseImage ?? UIImage(named: "cross", in: Bundle.customToolbars, compatibleWith: nil)
    }
}

extension OutlookEditorOptionsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        if offsetX > 10 {
            self.closeView.layer.shadowOpacity = 1
        } else if offsetX < 0 {
            self.closeView.layer.shadowOpacity = 0
        } else {
            self.closeView.layer.shadowOpacity = Float(offsetX * 0.1)
        }
    }
}
