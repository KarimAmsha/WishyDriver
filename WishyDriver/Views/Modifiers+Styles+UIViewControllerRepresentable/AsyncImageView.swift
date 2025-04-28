import SwiftUI

struct AsyncImageView: View {
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var imageURL: URL?
    var placeholder: Image?
    var contentMode: ContentMode = .fit

    var body: some View {
        if let imageURL = imageURL {
            AsyncImage(url: imageURL, scale: 1.0, content: { phase in
                switch phase {
                case .empty:
                    placeholder?
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .foregroundColor(.grayCCCCCC())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure(let error):
                    placeholder?
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .foregroundColor(.grayCCCCCC())
                @unknown default:
                    ProgressView()
                }
            })
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
        } else {
            placeholder?
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
        }
    }
}

