import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let apiService = APIService()
        let repository = CountryRepository(networkService: apiService)
        let fetchCountriesUseCase = FetchCountriesUseCase(repository: repository)
        let viewModel = CountryListViewModel(fetchCountriesUseCase: fetchCountriesUseCase)
        let countryListVC = CountryListViewController(viewModel: viewModel)
        
        // Embed in Navigation Controller
        let navigationController = UINavigationController(rootViewController: countryListVC)
        
        // Set root view controller
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
