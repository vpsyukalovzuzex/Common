//
// ViewController+Common.swift
//

#if os(iOS)

import UIKit

#else

import Cocoa

#endif

public extension ViewController {
    
    // MARK: - Public static func
    
    static func instantiate() -> Self {
        let name = String(String(describing: self).split(separator: ".").last!)
        #if os(iOS)
        return UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() as! Self
        #else
        return NSStoryboard(name: name, bundle: nil).instantiateInitialController() as! Self
        #endif
    }
    
    // MARK: - Public func
    
    func present(_ viewController: ViewController) {
        #if os(iOS)
        present(viewController, animated: true, completion: nil)
        #else
        presentAsModalWindow(viewController)
        #endif
    }
    
    func showAlert(_ title: String? = nil, _ message: String? = nil) {
        let actionTitle = "OK"
        #if os(iOS)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        #else
        let alert = NSAlert()
        alert.messageText = title ?? ""
        alert.informativeText = message ?? ""
        alert.addButton(withTitle: actionTitle)
        alert.alertStyle = .warning
        alert.runModal()
        #endif
    }
    
    #if os(iOS)
    
    func wrap(in navigationController: UINavigationController) {
        navigationController.viewController = [self]
    }
    
    func showActivity(with string: String, sourceView: UIView, sourceRect: CGRect) {
        let types: [UIActivity.ActivityType] = [
            .airDrop,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo
        ]
        let activityViewController = UIActivityViewController(
            activityItems: [string],
            applicationActivities: nil
        )
        activityViewController.excludedActivityTypes = types
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.sourceView = sourceView
            popoverPresentationController.sourceRect = sourceRect
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    func addKeyboardObserver() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        let center = NotificationCenter.default
        center.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addRotateObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func removeRotateObserver() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - Private func
    
    private func info(from notification: Notification) -> (CGRect, CGRect, CGFloat) {
        let beginFrame = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat ?? 0.0
        return (beginFrame, endFrame, duration)
    }
    
    // MARK: - @objc private func
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        let tuple = info(from: notification)
        (self as? Keyboardable)?.keyboardDidShow(true, beginFrame: tuple.0, endFrame: tuple.1, duration: tuple.2)
    }
    
    @objc private func keyboardDidHide(_ notification: Notification) {
        let tuple = info(from: notification)
        (self as? Keyboardable)?.keyboardDidShow(false, beginFrame: tuple.0, endFrame: tuple.1, duration: tuple.2)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let tuple = info(from: notification)
        var viewController = self as? Keyboardable
        viewController?.isKeyboardShow = true
        viewController?.keyboardWillShow(true, beginFrame: tuple.0, endFrame: tuple.1, duration: tuple.2)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let tuple = info(from: notification)
        var viewController = self as? Keyboardable
        viewController?.isKeyboardShow = false
        viewController?.keyboardWillShow(false, beginFrame: tuple.0, endFrame: tuple.1, duration: tuple.2)
    }
    
    @objc private func deviceOrientationDidChange(_ notification: Notification) {
        (self as? Rotatable)?.deviceOrientationDidChange(UIDevice.current.orientation)
    }
    
    #endif
}
