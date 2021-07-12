//
//  OutlookEditorOptionTextView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import UIKit

final class OutlookEditorOptionTextView: UIView {
    override init(frame: CGRect) {
        self.label = UILabel()
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        self.label = UILabel()
        super.init(coder: coder)
        self.setup()
    }

    var textsPararms: [OutlookEditorOptionTextParams] = [] {
        didSet {
            self.update()
        }
    }

    var normalColor: UIColor = .white {
        didSet {
            self.backgroundColor = self.normalColor
        }
    }

    var textColor: UIColor = .white {
        didSet {
            self.label.textColor = self.textColor
        }
    }

    private let label: UILabel
    private var currentIndex: Int = 0
}

extension OutlookEditorOptionTextView: OutlookEditorOptionSelectableProtocol {
    func setSelected(by action: ToolbarActionType) {
        if let paramsIndex = self.textsPararms.firstIndex(where: { params in
            guard let actionType = params.actionType else {
                return false
            }
            return action.contains(actionType)
        }) {
            let params = self.textsPararms[paramsIndex]
            self.label.text = params.text
            self.label.font = params.font
            self.currentIndex = paramsIndex
        } else if let generalTextIndex = self.textsPararms.firstIndex(where: { $0.actionType == nil }) {
            let params = self.textsPararms[generalTextIndex]
            self.label.text = params.text
            self.label.font = params.font
            self.currentIndex = generalTextIndex
        }
    }
}

extension OutlookEditorOptionTextView {
    private func setup() {
        self.backgroundColor = self.normalColor
        
        self.label.adjustsFontForContentSizeCategory = false
        self.label.font = UIFont.systemFont(ofSize: 14)
        self.label.text = nil
        self.label.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.label)
        NSLayoutConstraint.activate([self.label.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
                                     self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13)])
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OutlookEditorOptionTextView.tapped)))
    }

    private func update() {
        if self.textsPararms.isEmpty {
            self.label.text = nil
            self.label.font = UIFont.systemFont(ofSize: 14)
            self.currentIndex = 0
            return
        }
        if let params = self.textsPararms.first {
            self.label.text = params.text
            self.label.font = params.font
            self.currentIndex = 0
        }
    }

    private func nextText() {
        if self.textsPararms.isEmpty {
            return
        }
        let nextIndex = self.currentIndex + 1
        if nextIndex == self.textsPararms.count {
            let params = self.textsPararms[0]
            self.label.text = params.text
            self.label.font = params.font
            self.currentIndex = 0
            params.action?()
        } else {
            let params = self.textsPararms[nextIndex]
            self.label.text = params.text
            self.label.font = params.font
            self.currentIndex = nextIndex
            params.action?()
        }
    }

    @objc private func tapped() {
        self.nextText()
    }
}
