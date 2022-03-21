//
//  ContentView.swift
//  QRCodeGeneratorApp
//
//  Created by Jarvis Lam on 3/6/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCode {
    let context = CIContext()
    let qrGen = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> Image {
        qrGen.message = Data(string.utf8)
        
        if let outputImage = qrGen.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent ) {
                return Image(uiImage: UIImage(cgImage: cgImage))
            }
        }
        
        return Image(systemName: "questionmark.circle")
    }
}

struct ContentView: View {
    private var qrGen = QRCode()
    @State private var text = ""
    
    var body: some View {
        VStack{
            ZStack{
                Color.yellow
                qrGen.generateQRCode(from: "\(text)")
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(20)
            }
            .cornerRadius(20)
            .frame(width: 320, height: 320, alignment: .center)
            
            TextField("Enter some text", text: $text)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
