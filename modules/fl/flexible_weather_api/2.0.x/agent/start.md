<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flexible Weather API — agent index

Integrates Drupal with **external weather services** via a flexible provider system (current conditions/
forecasts; `weather_api_entity`/`weather_api_plugin` submodules). Config at
`flexible_weather_api.weather_api_services`. Version **2.0.1**. Core `>=8`.

**Security:** store the weather API key as a **secret**; HTTPS; respect provider rate limits/terms. No access
role.
