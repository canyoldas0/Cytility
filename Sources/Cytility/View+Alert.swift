//
//  View+Alert.swift
//  Linkmark
//
//  Created by Can Yoldas on 04/01/2024.
//

import SwiftUI


public extension View {
    /// Presents an error alert, based on the value of an `Error` binding.
    /// The dismiss button on the alert resets the value of the binding to `nil`.
    func alert(
        title: Text = Text("Something went wrong"),
        error: Binding<Error?>,
        dismissAction: @escaping () -> Void = { }
    ) -> some View {
        self.alert(
            title: title,
            error: error,
            content: { error in
                Alert(
                    title: title,
                    message: Text(error.localizedDescription),
                    dismissButton: .cancel(Text("Ok"), action: dismissAction)
                )
            }
        )
    }
    
    func alert(
        title: Text = Text("Something went wrong"),
        error: Binding<Error?>,
        content: @escaping (Error) -> Alert
    ) -> some View {
        self.alert(
            isPresented: Binding {
                error.wrappedValue != nil
            } set: { isPresented in
                if !isPresented {
                    error.wrappedValue = nil
                }
            },
            content: { content(error.wrappedValue!) }
        )
    }
}
