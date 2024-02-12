//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by salih söğüt on 28.01.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //Static: sinif isminden direk ulasmani saglar, private: initi private ederek fazla olusmasi engellenir.
    static let shared = NetworkManager()
    private init(){
        
    }
    
    //Escaping: Verinin gelis suresi belirli olmadigi icin escaping kullanilir. Asenkron calisir. faydasi: uygulama donmadan verileri cekmemizi saglar.
    func loadJsonData(complation: @escaping(CharacterResponse) -> Void ){
      
      let apiURL = "https://rickandmortyapi.com/api/character"
      
      AF.request(apiURL, method: .get).response { response in
          switch response.result {
          case .success(let value):
              print("Başarılı: \(value)")
              
          case .failure(let error):
              print("Hata: \(error)")
          }
          
          if let data = response.data {
                  do {
                      let json = try JSONDecoder().decode(RickAndMorty.CharacterResponse.self, from: data)
                      complation(json)
                  } catch {
                      print("JSON decode hatası: \(error)")
              }
          }else{
              print("Data Gelmiyor")
          }
      }
  }

}
