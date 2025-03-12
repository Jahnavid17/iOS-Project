import Foundation

struct CountryDTO: Codable {
    let name: String
    let region: String
    let code: String
    let capital: String
    
    func toDomain() -> Country {
        return Country(name: name, region: region, code: code, capital: capital)
    }
}
