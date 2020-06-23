//
//  InfoView.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/23.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    @State private var moveDistance: CGFloat = 0
    @State private var fontSize: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                Button(action: {
                    self.showImagePicker.toggle()
                    self.moveDistance = 0
                    self.fontSize = 0
                    self.moveDistance-=100
                    self.fontSize += 100
                }) {
                    Text("圖片")
                }
                .offset(x: 0, y: -100)

                image?
                .resizable()
                    .frame(width:400,height: 300)
                    .clipped()
                
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    self.image = Image(uiImage: image)
                }
            }
            
            VStack {
                Text("No")
                .font(.system(size: fontSize))
                .bold()
                .offset(x: 0, y: 100+moveDistance)
                    .animation(.easeIn(duration:1.5))

                Text("No meme,no mean. By Yoyo")
                .offset(x: 0, y: 100)
            }

        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    private var presentationMode

    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void

    final class Coordinator: NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {

        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void

        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            onImagePicked(uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
