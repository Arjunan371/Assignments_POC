import SwiftUI
import AVKit
import PDFKit

// AsyncImage for iOS 15+
@available(iOS 15.0, *)
struct AsyncImageView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
    }
}

// ImageLoaderView for versions below iOS 15
struct ImageLoaderView: View {
    @State var image: UIImage?

    let url: URL

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .clipped()
        } else {
            ProgressView()
                .onAppear {
                    loadImage(from: url)
                }
        }
    }

    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
    }
}

struct VideoThumbnailView: View {
    let videoURL: URL
    @State var thumbnailImage: UIImage? // Store the thumbnail image
    var body: some View {
        Group {
            if let thumbnailImage = thumbnailImage {
                Image(uiImage: thumbnailImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                // Placeholder or default image while loading
                Image("videoManual") // You can use any system image here
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onAppear {
            generateThumbnail()
        }
    }

    func generateThumbnail() {
        DispatchQueue.global(qos: .background).async {
            let asset = AVAsset(url: videoURL)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true

            let time = CMTimeMake(value: 2, timescale: 1) // Get thumbnail at 2 seconds

            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                DispatchQueue.main.async {
                    thumbnailImage = thumbnail
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    thumbnailImage = nil // Set a default image if thumbnail generation fails
                }
            }
        }
    }
}




