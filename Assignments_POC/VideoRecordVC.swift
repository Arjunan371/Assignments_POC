import SwiftUI
import MobileCoreServices

struct VideoPicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedURL: URL?
    var videoRecord: ((URL) -> Void)?

    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.videoQuality = .typeHigh
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<VideoPicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                parent.selectedURL = videoURL
                parent.videoRecord?(videoURL)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var Selectedimage: URL?
    var imageUrl: ((URL) -> Void)? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                if let imageURL = saveImageToDocumentsDirectory(uiImage: uiImage.upOrientationImage() ?? UIImage()) {
                    parent.Selectedimage = imageURL
                    parent.imageUrl?(imageURL)
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func saveImageToDocumentsDirectory(uiImage: UIImage) -> URL? {
            if let data = uiImage.pngData(),
               let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("libraryImage.jpeg")
                print("fileURL===>",fileURL)
                do {
                    try data.write(to: fileURL)
                    return fileURL
                } catch {
                    print("Error saving image: \(error)")
                }
            }
            return nil
        }
    }
}

struct DocumentPicker : UIViewControllerRepresentable{
       @Binding var url : URL?
    var documentUrl: ((URL) -> Void)?

func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.text, .pdf, .folder, .gif, .exe, .data], asCopy: true)
            documentPicker.delegate = context.coordinator
            return documentPicker
}

func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
}
func makeCoordinator() -> Coordinator {
        Coordinator(self)
   }

final class Coordinator:NSObject, UIDocumentPickerDelegate{
   let parent: DocumentPicker
   init(_ documentPicker: DocumentPicker){
       self.parent = documentPicker
   }

   func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
       guard let url = urls.first else{return}
       parent.url = url
       parent.documentUrl?(url)
   }
}
}

struct ImageFromCameraPicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var SelectedimageUrl: URL?
    var ImageFromCameraUrl: ((URL) -> Void)? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageFromCameraPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImageFromCameraPicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImageFromCameraPicker
        init(_ parent: ImageFromCameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                if let imageURL = saveImageToDocumentsDirectory(uiImage: uiImage.upOrientationImage() ?? UIImage()) {
                    parent.SelectedimageUrl = imageURL
                    parent.ImageFromCameraUrl?(imageURL)
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func saveImageToDocumentsDirectory(uiImage: UIImage) -> URL? {
            if let data = uiImage.pngData(),
               let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("cameraCaptureImage.jpeg")
                print("fileURL===>",fileURL)
                do {
                    try data.write(to: fileURL)
                    return fileURL
                } catch {
                    print("Error saving image: \(error)")
                }
            }
            return nil
        }
    }
}



