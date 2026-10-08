<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Aero Weather fetches real-time weather from WeatherAPI.com and renders it as responsive horizontal or vertical Drupal blocks with current conditions, a multi-day forecast, air quality and alerts.

---

Aero Weather ships two block plugins — Aero Weather (Horizontal) and Aero Weather (Vertical) — that call the WeatherAPI.com `forecast.json` endpoint through the `aero_weather.api` service and theme the response with the module's Twig templates. Each block is configured with a location string (city, postal code or `lat,lon` coordinates), a color palette (30 built-ins, alterable), a date format, forecast-day count, optional background image, and toggles for the forecast, air-quality index and weather-alert sections. A single settings form (`/admin/config/system/aero-weather`, permission "administer site configuration") holds the WeatherAPI key, a per-day response cache with a configurable duration, and the icon style used for each metric (built-in SVG, uploaded image, external HTTPS URL, or a font-icon snippet). It depends only on core Block; the horizontal block optionally loads Swiper 11 from a CDN for its metric/forecast carousels.

---

- Show current weather conditions for a fixed city in a site block.
- Display a 3/5/7/10/14-day forecast alongside current conditions.
- Place a horizontal weather widget in a header or hero region.
- Place a vertical weather widget in a sidebar with hourly and daily forecast.
- Show weather by postal code (e.g. "SW1A 1AA") without geocoding it yourself.
- Show weather for explicit coordinates such as "48.8567,2.3508".
- Surface active WeatherAPI weather alerts (event + headline) in a banner.
- Display the US-EPA air-quality index with a Good…Hazardous label.
- Let visitors toggle between Celsius and Fahrenheit client-side.
- Brand the widget with one of 30 color palettes (Blue Ocean, Sunset, Forest, …).
- Add a custom palette from another module via `hook_aero_weather_color_palettes_alter()`.
- Give the card rounded corners and an uploaded background image.
- Replace each metric icon (humidity, wind, pressure, UV, …) with a custom uploaded image.
- Point metric icons at external HTTPS image URLs instead of uploading.
- Use Font Awesome or Weather Icons font markup for metric icons.
- Cache WeatherAPI responses for N minutes/hours to stay within a free-tier quota.
- Clear all cached weather data on demand from the settings form.
- Show weather on a travel portal, news site or event page.
- Run multiple weather blocks, each pinned to a different location.
- Pick which detailed metrics appear (wind, precipitation, clouds, visibility, sunrise/sunset).
- Choose one of three vertical layouts (Classic, Compact, Expanded).
- Format the displayed local date/time with any site date format.
- Disable the CDN Swiper load when the theme already bundles Swiper.
