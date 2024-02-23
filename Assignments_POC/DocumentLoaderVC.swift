//
//  PreviewController.swift
//  Assignments_POC
//
//  Created by Arjunan on 09/11/23.
//

import SwiftUI
import QuickLook
struct PreviewController: UIViewControllerRepresentable {
    let url: URL?

    func makeUIViewController(context: Context) -> UINavigationController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator

        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    class Coordinator: NSObject, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
        let parent: PreviewController
        init(parent: PreviewController) {
            self.parent = parent
        }
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
    }
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.url! as URL as QLPreviewItem
        }
    }
}

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
    }
}


//import UIKit
//import WebKit
//
//class PreviewUrlController: UIViewController {
//
//    @IBOutlet weak var webview: WKWebView!
//    @IBOutlet weak var titleLbl: UILabel!
//    private var activityIndicator = ActivityIndicator()
//    var RemoteUrl = ""//"https://www.youtube.com/embed/\(videoID)"
//  
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        webview.navigationDelegate = self
//        loadRemoteUrl(url: RemoteUrl)
//    }
//    
//
//    func loadRemoteUrl(url:String) {
//        //var fileURL: URL? = nil
//        var urlStr = url
//        if !url.starts(with: "http://") && !url.starts(with: "https://") {
//            urlStr = "https://\(url)"
//        }
//        
//        //addingPercentEncoding
//        guard let urlObj = URL(string: urlStr)  else { return }
//        let titleStr = urlObj.lastPathComponent.components(separatedBy: ".").first ?? ""
//        titleLbl.text = titleStr
//      
//        webview.load( URLRequest(url: urlObj) )
//    }
//   
//    
//    @IBAction func didClickBack(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//
//}
//
////MARK: WKNavigationDelegate
//extension PreviewUrlController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        self.activityIndicator.showActivityIndicator(uiView: self.view)
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        self.activityIndicator.hideActivityIndicator()
//    }
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        self.activityIndicator.hideActivityIndicator()
//    }
//}
