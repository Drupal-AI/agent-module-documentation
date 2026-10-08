# Configuration

## Get an OpenWeatherMap API key

Register a free account at [OpenWeatherMap.org](https://openweathermap.org/) and
create an API key. Note that the free tier is limited to **60 calls/minute** and
**1,000,000 calls/month** — if your traffic is higher you will need a paid plan.
Keep this key out of committed configuration; treat it as a secret.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → Smart Weather → Settings**
   (`/admin/config/smartweather/settings`).

## The settings

- **OpenWeatherMap API key** — paste the key you generated. This is required for the
  module to fetch any weather data.
- **Location source** — decide how the location is chosen:
  - *Automatic (visitor-based)* — the default. The module detects each visitor's
    approximate location from their IP address via GeoPlugin.com and shows the
    weather for where they are.
  - *Fixed location* — instead, enter a specific **latitude** and **longitude** so
    every visitor sees the same location's weather. Use this if you do not want
    per-visitor detection.
- **Units** — choose whether temperatures display in **Celsius** or **Fahrenheit**.
- **Forecast** — the multi-day forecast (up to seven days) is **optional**; enable
  it if you want the forecast shown alongside the current conditions, or leave it off
  for current weather only.

Save the form to apply your choices.

## Rate limits and caching

Both third-party services are rate-limited: OpenWeatherMap as above, and GeoPlugin's
free location lookup at **120 requests/minute**. To stay within these, Smart Weather
caches fetched weather data in Drupal for a period, so it does not call the APIs on
every page request. If your visitor volume regularly approaches either limit,
consider the respective service's premium plan.

## Theming

The rendered weather markup includes relevant CSS classes and IDs, so you can style
it to fit your site by targeting those in your theme's CSS — no configuration change
is needed for that.
