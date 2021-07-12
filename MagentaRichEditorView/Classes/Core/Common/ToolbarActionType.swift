//
// Created by Pavel Volkhin on 28.10.2020.
//

import Foundation

public struct ToolbarActionType: OptionSet {
    public let rawValue: Int

    public static let clear = ToolbarActionType(rawValue: 1 << 0)
    public static let undo = ToolbarActionType(rawValue: 1 << 1)
    public static let redo = ToolbarActionType(rawValue: 1 << 2)
    public static let bold = ToolbarActionType(rawValue: 1 << 3)
    public static let italic = ToolbarActionType(rawValue: 1 << 4)
    public static let `subscript` = ToolbarActionType(rawValue: 1 << 5)
    public static let superscript = ToolbarActionType(rawValue: 1 << 6)
    public static let strike = ToolbarActionType(rawValue: 1 << 7)
    public static let underline = ToolbarActionType(rawValue: 1 << 8)
    public static let textColor = ToolbarActionType(rawValue: 1 << 9)
    public static let textBackgroundColor = ToolbarActionType(rawValue: 1 << 10)
    public static let header1 = ToolbarActionType(rawValue: 1 << 11)
    public static let header2 = ToolbarActionType(rawValue: 1 << 12)
    public static let header3 = ToolbarActionType(rawValue: 1 << 13)
    public static let header4 = ToolbarActionType(rawValue: 1 << 14)
    public static let header5 = ToolbarActionType(rawValue: 1 << 15)
    public static let header6 = ToolbarActionType(rawValue: 1 << 16)
    public static let indent = ToolbarActionType(rawValue: 1 << 17)
    public static let outdent = ToolbarActionType(rawValue: 1 << 18)
    public static let orderedList = ToolbarActionType(rawValue: 1 << 19)
    public static let unorderedList = ToolbarActionType(rawValue: 1 << 20)
    public static let alignLeft = ToolbarActionType(rawValue: 1 << 21)
    public static let alignCenter = ToolbarActionType(rawValue: 1 << 22)
    public static let alignRight = ToolbarActionType(rawValue: 1 << 23)
    public static let image = ToolbarActionType(rawValue: 1 << 24)
    public static let link = ToolbarActionType(rawValue: 1 << 25)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static func action(by string: String) -> ToolbarActionType? {
        self.dict[string]
    }

    private static let dict: [String: ToolbarActionType] = ["bold": .bold,
                                                            "italic": .italic,
                                                            "subscript": .`subscript`,
                                                            "superscript": .superscript,
                                                            "strike": .strike,
                                                            "underline": .underline,
                                                            "textColor": .textColor,
                                                            "textBackgroundColor": .textBackgroundColor,
                                                            "h1": .header1,
                                                            "h2": .header2,
                                                            "h3": .header3,
                                                            "h4": .header4,
                                                            "h5": .header5,
                                                            "h6": .header6,
                                                            "indent": .indent,
                                                            "outdent": .outdent,
                                                            "orderedList": .orderedList,
                                                            "unorderedList": .unorderedList,
                                                            "alignLeft": .alignLeft,
                                                            "alignCenter": .alignCenter,
                                                            "alignRight": .alignRight,
                                                            "image": .image,
                                                            "link": .link]
}
