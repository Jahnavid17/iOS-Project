import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}
