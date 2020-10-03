//
//  ContentView.swift
//  Exercise1
//
//  Created by Fábio Salata on 12/08/20.
//

import SwiftUI

struct LoadingError: Error {}

struct Photo: Codable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let download_url: URL
}

final class Remote<T>: ObservableObject {
    @Published var result: Result<T, Error>? = nil
    var value: T? { try? result?.get() }
    
    let url: URL
    let transform: (Data) -> T?
    
    init(url: URL, transform: @escaping (Data) -> T?) {
        self.url = url
        self.transform = transform
    }
    
    func load() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let v = self.transform(data) {
                    self.result = .success(v)
                }
                else {
                    self.result = .failure(LoadingError())
                }
            }
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var items = Remote(url: URL(string: "https://picsum.photos/v2/list")!,
                                       transform: { try? JSONDecoder().decode([Photo].self, from: $0) })
    
    var body: some View {
        NavigationView {
            if items.value == nil {
                Text("Loading...")
                    .onAppear { self.items.load() }
            } else {
                List {
                    ForEach(items.value!) { photo in
                        NavigationLink(destination: PhotoView(photo.download_url), label: { Text(photo.author) })
                    }
                }
            }
        }
    }
}

struct PhotoView: View {
    @ObservedObject var image: Remote<UIImage>

    init(_ url: URL) {
        image = Remote(url: url, transform: { UIImage(data: $0) })
    }
    
    var body: some View {
        return Group {
            if image.value == nil {
                Text("Loading...").onAppear { self.image.load() }
            } else {
                Image(uiImage: image.value!)
                    .resizable()
                    .aspectRatio(image.value!.size, contentMode: .fit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
