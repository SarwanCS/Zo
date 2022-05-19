//
//  ImagePicker.swift
//  Zo
//
//  Created by Brian Heralall on 4/21/22.
//

// Image Picker class to allow for the user to select an image when clicking the "Upload Photo" button

import SwiftUI

public struct ImagePickerView: UIViewControllerRepresentable {

    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode

    
    /** Constants that describe the source to use when picking an image or when determining available media types. **/
    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
    }
    
    /** Creates the view controller object and configures its initial state. **/
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }

    /** Updates the state of the specified view controller with new information from SwiftUI. **/
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    
    /** Creates the custom instance that you use to communicate changes from your view controller to other parts of your SwiftUI interface. **/
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }

    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }

        /** Tells the delegate that the user picked a still image **/
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }

        /** Tells the delegate that the user cancelled the pick operation. **/
        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }

    }

}
