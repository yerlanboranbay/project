import Foundation

struct APICaller{
    let url = "https://rickandmortyapi.com/api/character"
    
    func fetchRequestCharacters(completion: @escaping (CharacterModel) -> Void){
        let urlString = "\(url)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let liveData = try? JSONDecoder().decode(CharacterModel.self, from: data) {
                completion(liveData)
                print(liveData.results[0].name)
                print(liveData.results.count)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
}
