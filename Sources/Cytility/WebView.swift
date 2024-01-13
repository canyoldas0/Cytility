//
//  WebView.swift
//  Linkmark
//
//  Created by Can Yoldas on 02/01/2024.
//

import SwiftUI
import WebKit

struct _WebView: UIViewRepresentable {
    
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

public struct WebView: View {
    
    let url: URL?
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        NavigationView {
            _WebView(url: url)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { 
                    ToolbarItem(placement: .topBarLeading) {
                        if let url {
                            Button {
                                // open in safari
                                openURL(url)
                                dismiss() // Should this dismiss?
                            } label: {
                                Image(systemName: "safari")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Dismiss")
                        })
                    }
                }
        }
    }
}
