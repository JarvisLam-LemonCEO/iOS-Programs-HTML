import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = SampleDataModel()
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(dataModel.fetchedImages){
                        image in
                        
                        // Playground supports multipage Apps
                        
                        NavigationLink { 
                            Text(image.author).navigationTitle("Detail")
                        } label: { 
                            GeometryReader{proxy in
                                let size = proxy.size
                                
                                AsyncImage(url: URL(string: image.download_url)){image in 
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: size.width, height: size.height)
                                        .cornerRadius(15)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: size.width, height: size.height)
                            }
                            .frame(height: 150)
                        }
                        
                        
                    }
                    
                }.padding(.all)
            }
            .navigationTitle("Playground App")
        }
        .task {
            do{
                dataModel.fetchedImages = try await dataModel.fetchImages()
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}

class SampleDataModel: ObservableObject{
    @Published var fetchedImages: [ImageModel] = []
    
    func fetchImages() async throws -> [ImageModel]{
        
        guard let url = URL(string: "https://picsum.photos/v2/list?limit=10") else {
            // Throwing error
            throw ImageError.failed
        }
        // Playground supports Async/Await
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let json = try JSONDecoder().decode([ImageModel].self, from: data)
        
        return json
        
    }
}

enum ImageError: Error{
    case failed
}

struct ImageModel: Identifiable,Codable{
    var id: String
    var download_url: String
    var author: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case author
        case download_url
    }
}



