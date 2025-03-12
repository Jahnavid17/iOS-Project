import Foundation

protocol CountryRepositoryProtocol {
    func getCountries() async throws -> [Country]
}

import Foundation

class CountryRepository: CountryRepositoryProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getCountries() async throws -> [Country] {
        let countryDTOs: [CountryDTO] = try await networkService.fetchData(from: Constants.url)
        return countryDTOs.map { $0.toDomain() }
    }
}
