//
//  WeatherForecastService.swift
//  CloudCast
//
//  Created by Youngjun Yoo on 3/12/24.
//

import Foundation

class WeatherForecastService {
  static func fetchForecast(latitude: Double,
                            longitude: Double,
                            completion: ((CurrentWeatherForecast) -> Void)? = nil) {
      let parameters = "latitude=\(latitude)&longitude=\(longitude)&current_weather=true&temperature_unit=fahrenheit&timezone=auto&windspeed_unit=mph"
      let url = URL(string: "https://api.open-meteo.com/v1/forecast?\(parameters)")!
      // create a data task and pass in the URL
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // this closure is fired when the response is received
        guard error == nil else {
          assertionFailure("Error: \(error!.localizedDescription)")
          return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
          assertionFailure("Invalid response")
          return
        }
        guard let data = data, httpResponse.statusCode == 200 else {
          assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
          return
        }
        // at this point, `data` contains the data received from the response
          let decoder = JSONDecoder()
          let response = try! decoder.decode(WeatherAPIResponse.self, from: data)
          DispatchQueue.main.async {
            completion?(response.currentWeather)
          }
      }
      task.resume() // resume the task and fire the request
  }
}
