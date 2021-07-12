//
//  ViewController.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volhin on 10/20/2020.
//  Copyright (c) 2020 Pavel Volhin. All rights reserved.
//

import UIKit
import MagentaRichEditorView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        editor = RichEditorView(frame: self.view.bounds)
        editor.html = "<h1>My Awesome Editor</h1>Now I am editing in <em>style.</em>"
        editor.delegate = self
        self.view.addSubview(editor)
        let toolbar = OutlookToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 54))
        toolbar.backgroundColor = .clear
        toolbar.additionOptionsBackgroundColor = .red
        toolbar.editorOptionNormalColor = .gray
        toolbar.editorOptionSelectedColor = .blue
        toolbar.editorOptionsBackgroundColor = .purple
        toolbar.editorOptionTextColor = .white
        toolbar.setOptions(addition: [],
                           editorSections: [OutlookEditorSection(items:
                                                                    [.text(textsPararms: [OutlookEditorOptionTextParams(text: "general",
                                                                                                                        font: UIFont.systemFont(ofSize: 14),
                                                                                                                        actionType: nil,
                                                                                                                        action: { [weak self] in
                                                                                                                            self?.editor.paragraph()
                                                                                                                        }),
                                                                                          OutlookEditorOptionTextParams(text: "h1",
                                                                                                                        font: .systemFont(ofSize: 15),
                                                                                                                        actionType: .header1,
                                                                                                                        action: { [weak self] in
                                                                                                                            self?.editor.header(1)
                                                                                                                        })])]),
                                            OutlookEditorSection(items: [.image(normalImage: UIImage(named: "bold")!,
                                                                                selectedImage: UIImage(named: "bold")!,
                                                                                actionType: .bold,
                                                                                action: { [weak self] in
                                                                                    self?.editor.bold()
                                                                                }),
                                                                         .image(normalImage: UIImage(named: "italica")!,
                                                                                selectedImage: UIImage(named: "italica")!, actionType: .italic,
                                                                                action: { [weak self] in
                                                                                    self?.editor.italic()
                                                                                }),
                                                                         .image(normalImage: UIImage(named: "underline")!,
                                                                                selectedImage: UIImage(named: "underline")!, actionType: .underline,
                                                                                action: { [weak self] in
                                                                                    self?.editor.underline()
                                                                                })])])
        editor.inputAccessoryView = toolbar
        self.toolbar = toolbar
        editor.enabledActionsHandler = { [weak self] action in
            self?.toolbar.setSelected(by: action)
        }
    }

    private var editor: RichEditorView!
    private var toolbar: OutlookToolbar!
}

extension ViewController: RichEditorDelegate {
    func richEditorDidLoad(_ editor: RichEditorView) {
        editor.setEditorBackgroundColor(.green)
        editor.contentHeight = self.view.bounds.height
        editor.setEditorFontColor(.red)
    }
}
