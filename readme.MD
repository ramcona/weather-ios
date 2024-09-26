# TestCase

A brief description of your project. This project is designed to demonstrate API usage and functionality related to weather data and regional information in Indonesia.

## Features

- Fetch current weather data from OpenWeatherMap API.
- Retrieve regional data from EMSIFA API.
- Example implementation of API calls in a Swift application.

## Requirements

- iOS 15.0 or later.
- Xcode 14 or later.
- Internet connection to access APIs.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ramcona/TestCase.git
   ```


## Configuration

To use the app, you need to set your `weatherAPIKey` in the `APIConstants` class.

1. Open `APIConstants.swift`.
2. Locate the following line:
   ```swift
   static let weatherAPIKey = ""
   ```
3. Replace the empty string with your actual OpenWeatherMap API key:
   ```swift
   static let weatherAPIKey = "YOUR_API_KEY_HERE"
   ```

## Usage

### Running the App

- Build and run the app in the Xcode simulator or on a physical device.
- Ensure you have entered your API key to successfully fetch data.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- OpenWeatherMap API for weather data.
- EMSIFA API for regional data in Indonesia.

