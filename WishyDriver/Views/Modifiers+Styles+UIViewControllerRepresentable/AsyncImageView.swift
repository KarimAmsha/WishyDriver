import SwiftUI

struct AsyncImageView: View {
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var imageURL: URL?
    var systemPlaceholder: String?
    var customPlaceholder: String?

    var body: some View {
        Group {
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        placeholderView()
                    case .success(let image):
                        loadedImage(image)
                    case .failure:
                        failureView()
                    @unknown default:
                        placeholderView()
                    }
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
            } else {
                placeholderView()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            }
        }
    }

    private func placeholderView() -> some View {
        let placeholder: AnyView
        
        if let customPlaceholder = customPlaceholder {
            placeholder = AnyView(
                Image(customPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            )
        } else if let systemPlaceholder = systemPlaceholder {
            placeholder = AnyView(
                Image(systemName: systemPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            )
        } else {
            placeholder = AnyView(
                ProgressView()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            )
        }
        
        return placeholder
    }

    private func loadedImage(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
    }

    private func failureView() -> some View {
        placeholderView()
    }
}
