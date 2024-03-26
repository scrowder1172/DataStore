//
//  WebServiceClass.swift
//  APICallTutorial
//
//  Created by SCOTT CROWDER on 3/18/24.
//

import Foundation
import SwiftData

final class WebService {
    @MainActor
    func updateDataInDatabase(modelContext: ModelContext) async {
        do {
            let itemData: [PhotoDTO] = try await fetchData(from: "https://jsonplaceholder.typicode.com/albums/1/photos")
            itemData.forEach { item in
                let itemToStore: PhotoObject = PhotoObject(item: item)
                modelContext.insert(itemToStore)
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    private func fetchData<T: Codable>(from url: String) async throws -> [T] {
        do {
            guard let downloadedData: [T] = try await WebService().downloadData(fromURL: url) else { return [] }
            
            return downloadedData
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    func downloadData<T: Codable>(fromURL: String) async throws -> T? {
        
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
            
        } catch NetworkError.badURL {
            throw NetworkError.badURL
        } catch NetworkError.badResponse {
            throw NetworkError.badResponse
        } catch NetworkError.badStatus {
            throw NetworkError.badStatus
        } catch NetworkError.failedToDecodeResponse {
            throw NetworkError.failedToDecodeResponse
        } catch {
            print("Unknown decode error: \(error.localizedDescription)")
            throw NetworkError.unknownError
        }
    }
    
    func simulateNetworkSleep() async {
        let delay: Int = Int.random(in: 1...3)
        do {
            try await Task.sleep(nanoseconds: UInt64(delay) * 1_000_000_000)
        } catch {
            print("Error simulating network sleep: \(error.localizedDescription)")
        }
    }
}
