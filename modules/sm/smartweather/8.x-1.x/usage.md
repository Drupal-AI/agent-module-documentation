<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Weather Forecast adds a block that shows the current weather and an optional 1–7 day forecast from OpenWeatherMap, either for the visitor's detected location or for a fixed latitude/longitude you choose.

---

Install the module the normal way (`drush en smartweather`), then register for a free API key at **openweathermap.org** and enter it at **Administration → Configuration → System → SmartWeather Configuration** (`/admin/config/smartweather/settings`). On that form you choose **Celsius or Fahrenheit** (`openweather_degrees`), how many **forecast days** to display (`openweather_forecast_days`, 0–7 in addition to today), and — optionally — a fixed **latitude/longitude** (`openweather_default_lat`/`openweather_default_long`) if you do *not* want per-visitor location, or a **default public IP** (`openweather_default_ip`) for local development where the server sees `127.0.0.1`. Place the **"Smart Weather Block"** (`openweather_block`) in any region via **Structure → Block layout**. With no fixed coordinates set, the block detects the visitor's IP, resolves it to a location through geoplugin.net, and fetches the forecast from OpenWeatherMap; both lookups are cached for one hour so the module stays within the free API request limits. Bots (matched by user-agent) are skipped. The output ships with CSS classes and ids (`#currentweather`, `#weatherforecast`, `weathertemp`, `weathericon`, …) so you can restyle it, and it uses the `openweathermap` Twig template which you can override in your theme.

---

- Show the current weather for each visitor's own location.
- Add a 1–7 day weather forecast to a page.
- Display today's temperature, "feels like", humidity and conditions.
- Switch the display between Celsius and Fahrenheit.
- Choose how many forecast days to show (or none).
- Show weather for one fixed location instead of the visitor's.
- Pin a specific city by latitude and longitude.
- Place the weather block in a header, sidebar or footer region.
- Restrict the block to certain pages, roles or content types via block visibility.
- Give local-dev environments a real IP so the forecast renders off-localhost.
- Keep API calls within OpenWeatherMap's free monthly limit via the built-in 1-hour cache.
- Avoid spending geolocation/weather quota on crawler traffic (bots are skipped).
- Reuse the geolocation service to resolve a client IP to coordinates in your own code.
- Reuse the weather service to fetch an OpenWeather forecast for any lat/long.
- Restyle the widget with the provided CSS classes and ids.
- Override the `openweathermap` Twig template in your theme for a custom layout.
- Configure everything from one admin settings form.
- Localize the unit labels and messages (all strings are translatable).
- Add a lightweight weather feature without writing custom code.
- Show location-aware content to personalize a landing page.
