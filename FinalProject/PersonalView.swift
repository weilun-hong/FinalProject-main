import SwiftUI

struct ImagePickerController: UIViewControllerRepresentable {
    @Binding var showSelectPhoto: Bool
    @Binding var selectImage: Image
    
    func makeCoordinator() -> Coordinator {
        Coordinator(imagePickerController: self)
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        internal init(imagePickerController: ImagePickerController) {
            self.imagePickerController = imagePickerController
        }
        
        let imagePickerController: ImagePickerController
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info:
                                    [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                imagePickerController.selectImage = Image(uiImage:
                                                            uiImage)
            }
            imagePickerController.showSelectPhoto = false
            
        }
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) ->
    UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
    }
}

struct PersonalView: View {
    @State private var selectImage = Image(systemName: "photo")
    @State private var showSelectPhoto = false
    @State private var offset = CGSize.zero
    @State private var newPosition = CGSize.zero
    //@Binding var showPersonal: Bool
    
    var body: some View {
        VStack {
            Text("幫派大星選一張漂亮的照片背景吧！\n\n")
                .font(.system(size: 15))
                .fontWeight(.bold)
                
            Button(action: {
                self.showSelectPhoto = true
            }) {
                selectImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .clipped()
            }
            //.buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showSelectPhoto) {
                ImagePickerController(showSelectPhoto: self.$showSelectPhoto, selectImage: $selectImage)
            }
            Text("\n\n派大星想在你手機裡噴水\n\n")
            //Spacer()
            Image("pie")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .offset(offset)
                .gesture(DragGesture()
                            .onChanged({ (value) in
                                offset = CGSize(width: value.translation.width + newPosition.width,
                                                height: value.translation.height + newPosition.height)
                            })
                            .onEnded({ (value) in
                                newPosition = offset
                            })
                )
        }
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView()
    }
}
