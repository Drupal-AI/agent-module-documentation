<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flexible Weather API provides integration with external weather services.

---

Flexible Weather API integrates Drupal with external weather services — a flexible provider system for
fetching weather data (current conditions, forecasts) from configurable weather APIs and using it on the
site. It ships `weather_api_entity` and `weather_api_plugin` submodules, is configured at
`flexible_weather_api.weather_api_services`, in the Weather API package.

Use it to bring weather data into Drupal. Security note: it authenticates to the weather API with an API key
— **store the key as a secret** (not in exported config), operate over HTTPS, and be mindful of the
provider's rate limits/terms. Fetched weather data is external content. It has no access-control role.
Configure the weather-service connection.

---

- Integrate external weather services.
- Fetch current conditions/forecasts.
- Use a flexible provider system.
- Ship entity/plugin submodules.
- Configure at the weather-services form.
- Store the weather API key as a secret.
- Operate over HTTPS.
- Respect provider rate limits/terms.
- Have no access-control role.
- Configure the weather connection.
- Handle weather data.
- Fetch weather.
- Configure providers.
- Handle credentials securely.
- Fetch forecasts.
- Integrate weather.
- Configure the service.
- Handle weather APIs.
- Fetch weather data.
- Configure weather.
