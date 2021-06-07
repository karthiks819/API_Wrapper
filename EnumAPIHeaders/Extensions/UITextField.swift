//
//  UITextField.swift
//  ProjectLightning
//
//  Created by Ram on 2021-02-08.
//

import Foundation
import UIKit

extension UITextField {
    func fullTextWith(range: NSRange, replacementString: String) -> String? {
        if let fullSearchString = self.text, let swtRange = Range(range, in: fullSearchString) {
            return fullSearchString.replacingCharacters(in: swtRange, with: replacementString)
        }
        return nil
    }
}
