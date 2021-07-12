//
//  RichEditorDefaultOption.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import UIKit

/// RichEditorOptions is an enum of standard editor actions
public enum RichEditorDefaultOption: RichEditorOption {
    static var CustomBundle: Bundle?

    case clear
    case undo
    case redo
    case bold
    case italic
    case `subscript`
    case superscript
    case strike
    case underline
    case textColor
    case textBackgroundColor
    case header(Int)
    case indent
    case outdent
    case orderedList
    case unorderedList
    case alignLeft
    case alignCenter
    case alignRight
    case image
    case link
    
    public static let all: [RichEditorDefaultOption] = [
        .clear,
        .undo, .redo, .bold, .italic,
        .subscript, .superscript, .strike, .underline,
        .textColor, .textBackgroundColor,
        .header(1), .header(2), .header(3), .header(4), .header(5), .header(6),
        .indent, outdent, orderedList, unorderedList,
        .alignLeft, .alignCenter, .alignRight, .image, .link
    ]

    // MARK: RichEditorOption
    public var image: UIImage? {
        var name = ""
        switch self {
        case .clear: name = "clear"
        case .undo: name = "undo"
        case .redo: name = "redo"
        case .bold: name = "bold"
        case .italic: name = "italic"
        case .subscript: name = "subscript"
        case .superscript: name = "superscript"
        case .strike: name = "strikethrough"
        case .underline: name = "underline"
        case .textColor: name = "text_color"
        case .textBackgroundColor: name = "bg_color"
        case .header(let h): name = "h\(h)"
        case .indent: name = "indent"
        case .outdent: name = "outdent"
        case .orderedList: name = "ordered_list"
        case .unorderedList: name = "unordered_list"
        case .alignLeft: name = "justify_left"
        case .alignCenter: name = "justify_center"
        case .alignRight: name = "justify_right"
        case .image: name = "insert_image"
        case .link: name = "insert_link"
        }
        
        let bundle = Self.CustomBundle ?? Bundle.richEditor
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    
    public var title: String {
        switch self {
        case .clear: return "Clear".localized
        case .undo: return "Undo".localized
        case .redo: return "Redo".localized
        case .bold: return "Bold".localized
        case .italic: return "Italic".localized
        case .subscript: return "Sub".localized
        case .superscript: return "Super".localized
        case .strike: return "Strike".localized
        case .underline: return "Underline".localized
        case .textColor: return "Color".localized
        case .textBackgroundColor: return "BG Color".localized
        case .header(let h): return "H\(h)".localized
        case .indent: return "Indent".localized
        case .outdent: return "Outdent".localized
        case .orderedList: return "Ordered List".localized
        case .unorderedList: return "Unordered List".localized
        case .alignLeft: return "Left".localized
        case .alignCenter: return "Center".localized
        case .alignRight: return "Right".localized
        case .image: return "Image".localized
        case .link: return "Link".localized
        }
    }
    
    public func action(_ toolbar: RichEditorToolbar) {
        switch self {
        case .clear: toolbar.editor?.removeFormat()
        case .undo: toolbar.editor?.undo()
        case .redo: toolbar.editor?.redo()
        case .bold: toolbar.editor?.bold()
        case .italic: toolbar.editor?.italic()
        case .subscript: toolbar.editor?.subscriptText()
        case .superscript: toolbar.editor?.superscript()
        case .strike: toolbar.editor?.strikethrough()
        case .underline: toolbar.editor?.underline()
        case .textColor: toolbar.delegate?.richEditorToolbarChangeTextColor?(toolbar)
        case .textBackgroundColor: toolbar.delegate?.richEditorToolbarChangeBackgroundColor?(toolbar)
        case .header(let h): toolbar.editor?.header(h)
        case .indent: toolbar.editor?.indent()
        case .outdent: toolbar.editor?.outdent()
        case .orderedList: toolbar.editor?.orderedList()
        case .unorderedList: toolbar.editor?.unorderedList()
        case .alignLeft: toolbar.editor?.alignLeft()
        case .alignCenter: toolbar.editor?.alignCenter()
        case .alignRight: toolbar.editor?.alignRight()
        case .image: toolbar.delegate?.richEditorToolbarInsertImage?(toolbar)
        case .link: toolbar.delegate?.richEditorToolbarInsertLink?(toolbar)
        }
    }
}
