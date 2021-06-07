//
//  UIViewController.swift
//  ProjectLightning
//
//  Created by oles on 16.10.2020.
//

import UIKit

extension UIViewController {
    
    func loadController(withIdentifier identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
    
    func loadController(withIdentifier identifier: String) -> UIViewController {
        let controller = UIViewController(nibName: identifier, bundle: nil)
        return controller
    }
        
    // Embed view controller
    func embed(_ viewController:UIViewController, inView view:UIView) {
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true);
    }
    
    func addObserverForNotification(_ notificationName: Notification.Name, actionBlock: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main, using: actionBlock)
    }
    
    func removeObserver(_ observer: AnyObject, notificationName: Notification.Name) {
        NotificationCenter.default.removeObserver(observer, name: notificationName, object: nil)
    }
    
    typealias KeyboardHeightClosure = (CGFloat) -> Void
    
    func removeKeyboardObserver() {
        removeObserver(self, notificationName: UIResponder.keyboardWillChangeFrameNotification)
    }
    
    func showMessage(title: String, message: String, buttonText: String = "OK", completion: (()->Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { action in
            completion?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showStringPicker(title: String?, message: String?, strings: [String], anchorView: UIView?, style: UIAlertController.Style = .actionSheet, completion: ((UIAlertAction) -> Void)?) {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for text in strings {
            let action: UIAlertAction = UIAlertAction(title: text, style: .default, handler: completion)
            actionSheetController.addAction(action)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        actionSheetController.popoverPresentationController?.sourceView = (anchorView != nil) ? anchorView : self.view
        present(actionSheetController, animated: true) {
        }
    }

    func showTextInputPrompt(withMessage message: String,
                             completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let text = weakPrompt?.textFields?.first?.text else { return }
            completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }

    func showTextInputPrompt2(withMessage message: String,
                              field1Hint: String,
                              field2Hint: String,
                             completionBlock: @escaping ((Bool, String?, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionBlock(false, nil, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let text1 = weakPrompt?.textFields?.first?.text else { return }
            guard let text2 = weakPrompt?.textFields?.last?.text else { return }
            completionBlock(true, text1, text2)
        }
        prompt.addTextField { textField in
            textField.placeholder = field1Hint
        }
        prompt.addTextField { textField in
            textField.placeholder = field2Hint
        }
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }

    
    func showConfirmation(withTitle: String, message: String, confirmCompletion: @escaping (() -> Void), cancelCompletion: (() -> Void)? = nil) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            confirmCompletion()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            cancelCompletion?()
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
}
extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
