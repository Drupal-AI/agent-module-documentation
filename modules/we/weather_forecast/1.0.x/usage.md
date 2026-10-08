<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Weather Forecast displays a weather forecast based on region.

---

Weather Forecast **displays a regional weather forecast** — a block showing the weather forecast for a
configured region/location, via a weather API and geolocation. It depends on core Block and the Geolocation module.

Use it to show weather. It is an integration/content-display feature. Security/data handling: it **calls an external
weather API** (egress) and typically needs an **API key** (store as a secret — env/Key — over HTTPS); if it uses
the visitor's location (geolocation), that's **location data** — get consent and disclose. It has no access-control
role. Configure the weather API and region.

---

- Display a weather forecast.
- Show a regional forecast block.
- Use a weather API + geolocation.
- Depend on core Block + Geolocation.
- Serve integration/content display.
- Show weather.
- Call an external weather API (egress) with an API key (secret).
- Use the visitor's location = location data (consent + disclose).
- Store the API key as a secret (env/Key, HTTPS).
- Have no access-control role.
- Configure the weather API + region.
- Handle the forecast.
- Show forecasts.
- Configure the API.
- Fetch weather.
- Handle the integration.
- Display weather.
- Get the forecast.
- Secure the key.
- Provide a weather forecast.
