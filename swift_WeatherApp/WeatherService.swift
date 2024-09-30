//
//  WeatherService.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import Foundation
import CoreLocation

class WeatherService: ObservableObject {
    private let baseURL = "https://api.open-meteo.com/v1/forecast"
    
    @Published var currentWeather: WeatherDay?
    @Published var weeklyForecast: [WeatherDay] = []
    @Published var error: String?
    
    func fetchWeather(for city: String) {
        self.error = nil
        getCoordinates(for: city) { result in
            switch result {
            case .success(let coordinates):
                self.fetchWeatherData(latitude: coordinates.latitude, longitude: coordinates.longitude)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    private func fetchWeatherData(latitude: Double, longitude: Double) {
        let urlString = "\(baseURL)?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max&current_weather=true&timezone=auto"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.error = error?.localizedDescription ?? "Unknown error occurred"
                }
                return
            }
            
            // Print the raw JSON response for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                //print("Raw JSON Response: \(jsonString)")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
                DispatchQueue.main.async {
                    self.updateWeatherData(with: decodedResponse)
                }
                //print("DECODED RESPONSE : \(decodedResponse)")
                
            } catch {
                DispatchQueue.main.async {
                    self.error = "Failed to decode weather data: \(error.localizedDescription)"
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    private func updateWeatherData(with response: OpenMeteoResponse) {
        let current = response.current_weather
        let isNight = current.is_day == 0 // 0 means night, 1 means day
        
        self.currentWeather = WeatherDay(
            dayOfWeek: "Today",
            imageName: getWeatherIconName(weatherCode: current.weathercode, isNight: isNight),
            temperature: Int(current.temperature),
            highTemp: Int(response.daily.temperature_2m_max[0]),
            lowTemp: Int(response.daily.temperature_2m_min[0]),
            precipitation: response.daily.precipitation_probability_max[0],
            humidity: nil,
            windSpeed: Int(current.windspeed),
            isNight: isNight
        )
        
        
        print("current weather: \(self.currentWeather )")
        var forecast = createWeeklyForecast(from: response)
        // forecast.insert(self.currentWeather!, at: 0)
        self.weeklyForecast = forecast

        print("weekly Forecast : \(self.weeklyForecast)")
        
    }
    
    private func createWeeklyForecast(from response: OpenMeteoResponse) -> [WeatherDay] {
        var forecast: [WeatherDay] = []
        let dailyData = response.daily
        print("daily data : \(dailyData)")
        let days = min(dailyData.time.count, 7) // Ensure we don't exceed array bounds
        
        
        // Use the current weather code for the daily forecast
        let currentWeatherCode = response.current_weather.weathercode
        
        for i in 0..<days {
            let dayWeather = WeatherDay(
                dayOfWeek: formatDate(dailyData.time[i]),
                imageName: getWeatherIconName(weatherCode: currentWeatherCode, isNight: false),
                temperature: Int((dailyData.temperature_2m_max[i] + dailyData.temperature_2m_min[i]) / 2),
                highTemp: Int(dailyData.temperature_2m_max[i]),
                lowTemp: Int(dailyData.temperature_2m_min[i]),
                precipitation: dailyData.precipitation_probability_max[i],
                humidity: nil,
                windSpeed: nil,
                isNight: false
            )
            forecast.append(dayWeather)
            
            // Add night weather
            let nightWeather = WeatherDay(
                dayOfWeek: formatDate(dailyData.time[i]) + " Night",
                imageName: getWeatherIconName(weatherCode: currentWeatherCode, isNight: true),
                temperature: Int(dailyData.temperature_2m_min[i]),
                highTemp: Int(dailyData.temperature_2m_max[i]),
                lowTemp: Int(dailyData.temperature_2m_min[i]),
                precipitation: dailyData.precipitation_probability_max[i],
                humidity: nil,
                windSpeed: nil,
                isNight: true
            )
            forecast.append(nightWeather)
        }
        
        return forecast
    }
    
    private func getWeatherIconName(weatherCode: Int, isNight: Bool) -> String {
        let baseIcon: String
        switch weatherCode {
        case 0, 1: baseIcon = "sun.max" // Clear sky
        case 2: baseIcon = "cloud.sun" // Few clouds
        case 3: baseIcon = "cloud" // Scattered clouds
        case 45, 48: baseIcon = "cloud.fog" // Fog
        case 51, 53, 55: baseIcon = "cloud.drizzle" // Drizzle
        case 61, 63, 65: baseIcon = "cloud.rain" // Rain
        case 66, 67: baseIcon = "cloud.sleet" // Sleet
        case 71, 73, 75: baseIcon = "cloud.snow" // Snow
        case 77: baseIcon = "snow" // Snow showers
        case 80, 81, 82: baseIcon = "cloud.heavyrain" // Heavy rain showers
        case 85, 86: baseIcon = "cloud.snow" // Heavy snow showers
        case 95, 96, 99: baseIcon = "cloud.bolt" // Thunderstorms
        default: baseIcon = "cloud" // Default to cloud
        }
        
        // Adjust the icon for night conditions
        if isNight {
            switch weatherCode {
            case 0, 1: return "moon.stars" // Clear night
            case 2: return "cloud.moon" // Few clouds at night
            case 3: return "cloud" // Scattered clouds (same for day and night)
            case 45, 48: return "cloud.fog" // Fog (same for day and night)
            case 51, 53, 55: return "cloud.drizzle" // Drizzle (same for day and night)
            case 61, 63, 65: return "cloud.rain" // Rain (same for day and night)
            case 66, 67: return "cloud.sleet" // Sleet (same for day and night)
            case 71, 73, 75: return "cloud.snow" // Snow (same for day and night)
            case 77: return "snow" // Snow showers (same for day and night)
            case 80, 81, 82: return "cloud.heavyrain" // Heavy rain showers (same for day and night)
            case 85, 86: return "cloud.snow" // Heavy snow showers (same for day and night)
            case 95, 96, 99: return "cloud.bolt" // Thunderstorms (same for day and night)
            default: return "cloud" // Default to cloud
            }
        }
        
        return baseIcon + ".fill" // Return the filled icon for daytime
    }
    
    private func isNightTime(hour: Int) -> Bool {
        return hour < 6 || hour >= 19
    }
    
    private func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return dateString
    }
    
    private func getCoordinates(for city: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let location = placemarks?.first?.location?.coordinate else {
                completion(.failure(NSError(domain: "WeatherService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location not found"])))
                return
            }
            
            completion(.success(location))
        }
    }
}

struct OpenMeteoResponse: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Double
    let current_weather: CurrentWeather
    let daily: DailyForecast
}

struct CurrentWeather: Codable {
    let time: String
    let interval: Int
    let temperature: Double
    let windspeed: Double
    let winddirection: Double
    let is_day: Int
    let weathercode: Int
}

struct DailyForecast: Codable {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let precipitation_probability_max: [Int]
}

struct ISO8601Date: Codable {
    let date: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: dateString) {
            self.date = date
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
        }
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: date)
    }
}
