//
//  OutlookToolbar.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import UIKit

final public class OutlookToolbar: UIView {
    public override init(frame: CGRect) {
        self.editorOptionsView = OutlookEditorOptionsView()
        self.additionOptionsView = OutlookAdditionOptionsView()
        super.init(frame: frame)
        self.setup()
    }

    public required init?(coder: NSCoder) {
        self.editorOptionsView = OutlookEditorOptionsView()
        self.additionOptionsView = OutlookAdditionOptionsView()
        super.init(coder: coder)
        self.setup()
    }

    public func setOptions(addition additionOptions: [OutlookAdditionOption] = [],
                           editorSections: [OutlookEditorSection] = []) {
        self.additionOptions = additionOptions
        self.editorSections = editorSections
        self.updateToolBar()
    }

    public var additionOptionsBackgroundColor: UIColor = .clear {
        didSet {
            self.additionOptionsView.backgroundColor = self.additionOptionsBackgroundColor
        }
    }

    public var editorOptionsBackgroundColor: UIColor = .clear {
        didSet {
            self.editorOptionsView.backgroundColor = self.editorOptionsBackgroundColor
            self.editorOptionsView.shadowColor = self.editorOptionsBackgroundColor
        }
    }

    public var editorOptionNormalColor: UIColor = .white {
        didSet {
            self.editorOptionsView.normalColor = self.editorOptionNormalColor
        }
    }

    public var editorOptionSelectedColor: UIColor = .gray {
        didSet {
            self.editorOptionsView.selectedColor = self.editorOptionSelectedColor
        }
    }

    public var editorOptionTextColor: UIColor = .white {
        didSet {
            self.editorOptionsView.textColor = self.editorOptionTextColor
        }
    }

    public var customCloseImage: UIImage? {
        didSet {
            self.editorOptionsView.customCloseImage = self.customCloseImage
        }
    }

    public var customEditorImage: UIImage? {
        didSet {
            self.additionOptionsView.customEditorImage = self.customEditorImage
        }
    }

    public func setSelected(by action: ToolbarActionType) {
        self.editorOptionsView.setSelected(by: action)
    }

    private var additionOptions = [OutlookAdditionOption]()
    private var editorSections = [OutlookEditorSection]()
    private let editorOptionsView: OutlookEditorOptionsView
    private let additionOptionsView: OutlookAdditionOptionsView
}


extension OutlookToolbar {
    private func setup() {
        self.backgroundColor = .clear
        self.autoresizingMask = .flexibleWidth
        self.editorOptionsView.isHidden = true
        self.editorOptionsView.translatesAutoresizingMaskIntoConstraints = false
        self.additionOptionsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.additionOptionsView)
        self.addSubview(self.editorOptionsView)
        NSLayoutConstraint.activate([self.editorOptionsView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.editorOptionsView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.editorOptionsView.leftAnchor.constraint(equalTo: self.leftAnchor),
                                     self.editorOptionsView.rightAnchor.constraint(equalTo: self.rightAnchor),
                                     self.additionOptionsView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.additionOptionsView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.additionOptionsView.leftAnchor.constraint(equalTo: self.leftAnchor),
                                     self.additionOptionsView.rightAnchor.constraint(equalTo: self.rightAnchor)])
        
        self.additionOptionsView.changeStateHandler = { [weak self] in
            self?.editorOptionsView.isHidden = false
            self?.additionOptionsView.isHidden = true
        }
        self.editorOptionsView.changeStateHandler = { [weak self] in
            self?.additionOptionsView.isHidden = false
            self?.editorOptionsView.isHidden = true
        }
    }

    private func updateToolBar() {
        self.additionOptionsView.options = self.additionOptions
        self.editorOptionsView.sections = self.editorSections
    }
}
