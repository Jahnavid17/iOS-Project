import Foundation

protocol FetchCountriesUseCaseProtocol {
    func execute() async throws -> [Country]
}

class FetchCountriesUseCase: FetchCountriesUseCaseProtocol {
    
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Country] {
        return try await repository.getCountries()
    }
}
