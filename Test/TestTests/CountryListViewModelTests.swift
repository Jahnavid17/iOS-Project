import XCTest
import Combine
@testable import Test

@MainActor
final class CountryListViewModelTests: XCTestCase {
    
    var mockUseCase: FetchCountriesUseCase!
    var mockRepository: MockCountryRepository!
    var viewModel: CountryListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        mockUseCase = FetchCountriesUseCase(repository: mockRepository)
        viewModel = CountryListViewModel(fetchCountriesUseCase: mockUseCase)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        mockRepository = nil
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchCountriesSuccess() async {
        await viewModel.fetchCountries()
        
        XCTAssertEqual(viewModel.countries.count, 10)
        XCTAssertEqual(viewModel.filteredCountries.count, 10)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchCountriesFailure() async {
        mockRepository.shouldReturnError = true
        
        await viewModel.fetchCountries()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.countries.count, 0)
    }
    
    func testFilterCountriesByName() async {
        await viewModel.fetchCountries()
        
        viewModel.filterCountries(query: "India")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.name, "India")
    }
    
    func testFilterCountriesByCapital() async {
        await viewModel.fetchCountries()
        
        viewModel.filterCountries(query: "Japan")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.capital, "Tokyo")
    }
    
    func testFilterCountriesWithNoMatch() async {
        await viewModel.fetchCountries()
        
        viewModel.filterCountries(query: "ABC")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 0)
    }
}
