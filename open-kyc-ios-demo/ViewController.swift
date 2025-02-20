//
//  ViewController.swift
//  open-kyc-ios-demo
//
//  Created by Ran on 2025/2/20.
//

import UIKit
import OpenKYC

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func jumpToOpenKYC(_ sender: UIButton) {
        guard let urlString = textView.text else { return }
        guard let url = URL(string: urlString) else {
            return
        }
        let controller = OpenKYCController(url: url, delegate: self)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
}

extension ViewController: OpenKYCWebViewControllerDelegate {
    
    func openKYCWebViewController(
        _ controller: OpenKYCWebViewController,
        didReceiveMessage message: String
    ) {
        
    }
    
    func openKYCWebViewController(
        _ controller: OpenKYCWebViewController,
        didReceiveDeepLink deepLink: URL
    ) {
        
    }
    
    func openKYCWebViewController(
        _ controller: OpenKYCWebViewController,
        didReceiveMessage name: String,
        payload: [String: Any]?
    ) {
        
    }
}
