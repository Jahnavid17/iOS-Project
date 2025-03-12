import XCTest
@testable import Test

class MockCountryRepository: CountryRepositoryProtocol {
    
    var shouldReturnError = false
    var mockCountries: [Country] = [
        Country(name: "Japan", region: "Asia", code: "JP", capital: "Tokyo"),
        Country(name: "Brazil", region: "South America", code: "BR", capital: "Brasilia"),
        Country(name: "Germany", region: "Europe", code: "DE", capital: "Berlin"),
        Country(name: "Australia", region: "Oceania", code: "AU", capital: "Canberra"),
        Country(name: "South Africa", region: "Africa", code: "ZA", capital: "Pretoria"),
        Country(name: "Mexico", region: "North America", code: "MX", capital: "Mexico City"),
        Country(name: "India", region: "Asia", code: "IN", capital: "New Delhi"),
        Country(name: "United Kingdom", region: "Europe", code: "GB", capital: "London"),
        Country(name: "Egypt", region: "Africa", code: "EG", capital: "Cairo"),
        Country(name: "Argentina", region: "South America", code: "AR", capital: "Buenos Aires")
    ]
    
    func getCountries() async throws -> [Country] {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        return mockCountries
    }
}

final class FetchCountriesUseCaseTests: XCTestCase {
    
    var mockRepository: MockCountryRepository!
    var useCase: FetchCountriesUseCase!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        useCase = FetchCountriesUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testFetchCountriesSuccess() async {
        do {
            let countries = try await useCase.execute()
            XCTAssertEqual(countries.count, 3)
            XCTAssertEqual(countries.first?.name, "United States")
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    func testFetchCountriesFailure() async {
        mockRepository.shouldReturnError = true
        
        do {
            _ = try await useCase.execute()
            XCTFail("Expected an error, but no error was thrown.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
