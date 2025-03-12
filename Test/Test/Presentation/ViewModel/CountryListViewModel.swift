import Foundation
import Combine

@MainActor
class CountryListViewModel: ObservableObject {
    
    private let fetchCountriesUseCase: FetchCountriesUseCaseProtocol
    @Published var countries: [Country] = []
    @Published var filteredCountries: [Country] = []
    @Published var errorMessage: String?
    
    init(fetchCountriesUseCase: FetchCountriesUseCaseProtocol) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
    }
    
    func fetchCountries() async {
        do {
            let fetchedCountries = try await fetchCountriesUseCase.execute()
            self.countries = fetchedCountries
            self.filteredCountries = fetchedCountries
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func filterCountries(query: String) {
        if query.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                $0.name.lowercased().contains(query.lowercased()) ||
                $0.capital.lowercased().contains(query.lowercased())
            }
        }
    }
}
