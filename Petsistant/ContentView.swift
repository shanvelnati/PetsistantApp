import SwiftUI
import AudioToolbox


struct ContentView: View {
    @State private var currentQuote = "Tap the lion to get a motivational quote! 🚀"
    @State private var isJumping = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("🦁")
                    .font(.system(size: 100))
                    .offset(y: isJumping ? -20 : 0)
                    .onTapGesture {
                        withAnimation { self.isJumping = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            withAnimation {
                                self.isJumping = false
                                self.fetchQuote()
                            }
                            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                        }
                    }
                                    
                Text(currentQuote)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }

    func fetchQuote() {
        guard let url = URL(string: "https://chat-cb5srbnobq-uc.a.run.app") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.currentQuote = decodedResponse.reply
                    }
                }
            }
        }.resume()
    }

    struct Response: Codable {
        var reply: String
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
