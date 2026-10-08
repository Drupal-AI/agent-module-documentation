<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Live Weather shows a customizable weather report for configured locations from a third-party API.

---

An administrator configures API credentials (app id, consumer key/secret) and one or more locations (by WOEID) on admin pages gated by the `live_weather configuration` permission; the module's service then signs an OAuth request and fetches weather data to render for the site. All configuration and location management is admin-only. Note that the outbound weather API request is made with TLS certificate verification disabled (see security notes), and the historically-targeted Yahoo Weather endpoint is now defunct.

---

- Display a weather report on the site.
- Configure one or more locations by WOEID.
- Store weather API credentials in settings.
- Sign the weather API request with OAuth.
- Show temperature, wind direction, and conditions.
- Convert wind bearing to compass direction.
- Determine day/night for the report.
- Gate configuration behind `live_weather configuration`.
- Manage a list of locations in the admin UI.
- Delete configured locations.
- Render weather via provided templates.
- Support Fahrenheit/Celsius unit selection.
- Support Drupal 8.8, 9, and 10.
- Provide a simple weather widget for a region.
- Log warnings when the API returns no data.
- Serve site-wide localized weather info.
