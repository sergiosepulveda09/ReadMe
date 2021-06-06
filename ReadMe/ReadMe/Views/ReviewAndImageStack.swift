import class PhotosUI.PHPickerViewController
import SwiftUI

struct ReviewAndImageStack: View {
    @State var showingImagePicker = false
    @State var deleteImage = false
    @ObservedObject var book: Book
    @Binding var image: UIImage?
    var body: some View {
        VStack {
            Divider()
                .padding(.vertical)
            TextField("Review", text: $book.microReview)
            Divider()
                .padding(.vertical)
            Book.Image(uiImage: image,title: book.title, cornerRadius: 16)
                .scaledToFit()
            HStack {
                if image != nil {
                    Button("Delete Image") {
                        deleteImage = true
                    }
                    .padding()
                }
                Button("Update Image…") {
                    showingImagePicker = true
                }
                .padding()
            }
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker) {
            PHPickerViewController.View(image: $image)
        }
        .alert(isPresented: $deleteImage) {
            .init(title: .init("Delete image for \(book.title)?"), primaryButton: .destructive(.init("Delete")) { image = nil }, secondaryButton: .cancel())
        }
    }
}


struct ReviewAndImageStack_Previews: PreviewProvider {
    static var previews: some View {
        ReviewAndImageStack(book: .init(), image: .constant(nil))
            .padding(.horizontal)
            .previewedInAllColorSchemes
    }
}
