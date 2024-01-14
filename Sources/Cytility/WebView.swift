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
    @State var error: Error? = nil
    let browserActionClicked: (URL?) async throws -> Void
    let errorDismissAction: () -> Void
    
    public init(
        url: URL?,
        browserActionClicked: @escaping (URL?) async throws -> Void,
        errorDismissAction: @escaping () -> Void = { }
    ) {
        self.url = url
        self.browserActionClicked = browserActionClicked
        self.errorDismissAction = errorDismissAction
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
                                Task {
                                    do {
                                        try await browserActionClicked(url)
                                    } catch {
                                        self.error = error
                                    }
                                }
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
                .alert(error: $error, dismissAction: errorDismissAction)
        }
    }
}
