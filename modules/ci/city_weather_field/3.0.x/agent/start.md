<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# City Weather Field (city_weather_field) — agent index

A custom **field** (type + widget + formatter) that lets an editor pick a **US city** from a
select list and renders that city's **current weather** from the **OpenWeatherMap** API on the
entity display. Package `weather`. Depends only on core **`field`**. Core requirement
`^9.3 || ^10.1 || ^11`. License GPL-2.0-or-later. Version 3.0.1. No permissions, no Drush,
no config schema, no submodules.

- **The three field plugins (type/widget/formatter) and how weather is rendered** →
  [fields/weather-field.md](fields/weather-field.md)
- **The API-key settings form, config object, service and external call** →
  [config/settings.md](config/settings.md)

## What it actually provides

- **Field type** `weather_field_type` (label *"City - weather"*),
  `src/Plugin/Field/FieldType/WeatherFieldType.php`. One column `value`, `char(2)`, indexed —
  it stores a **numeric index into the bundled city list**, not the city name. Default widget
  `weather_widget`, default formatter `weather_formatter`.
- **Widget** `weather_widget` (label *"US Cities"*),
  `src/Plugin/Field/FieldWidget/WeatherFieldWidget.php`. A `select` whose `#options` come from
  `city_weather_field_get_cities()` (reads the bundled `cities.json`, 1000 US cities).
- **Formatter** `weather_formatter` (label *"Weather"*),
  `src/Plugin/Field/FieldFormatter/WeatherFieldFormatter.php`. Looks up the selected city, calls
  `WeatherService::getWeatherInformation($apiKey, $cityName)`, themes the result.
- **Service** `city_weather_field.default` → `Drupal\city_weather_field\WeatherService`
  (`src/WeatherService.php`, arg `@http_client`). Calls OpenWeatherMap `/data/2.5/weather`.
- **Settings form** `WeatherSettingsForm` at route
  `city_weather_field.weather_settings_form` = **`/admin/config/city_weather_field/settings`**
  (permission `administer site configuration`; menu link under *Configuration → System*). Writes
  config object **`city_weather_field.weathersettings`** key `api_key_openweather`.
- **Theme hook** `city_weather_field` (`hook_theme` in `city_weather_field.module`) →
  `templates/city-weather-field.html.twig` (name, description, °C temp, humidity, wind, icon).

## Mechanism (from source)

- `WeatherFieldFormatter::viewElements()` reads `api_key_openweather` from config, builds the city
  list, and for each item with a matching index calls the service, then emits a
  `#theme => 'city_weather_field'` element per delta (only when the service returns an array).
- `WeatherService::getWeatherInformation()` requests
  `<baseUri>/data/2.5/weather?q=<city>&lang=en&units=metric&APPID=<key>` with Guzzle, decodes the
  JSON, and returns an array of `name, description, max_temperature, min_temperature, humidity,
  wind, icon`; on a Guzzle exception it logs and returns `FALSE`.
- Weather values are rendered by the Twig template, which **auto-escapes** all interpolated values.

## Notes / caveats

- The formatter fetches from OpenWeatherMap on **every uncached view** (no cache metadata / max-age)
  — one external HTTP call per field item. Size traffic and OWM quota accordingly.
- No config schema ships, so strict config-schema tooling may flag `city_weather_field.weathersettings`.
- The stored value is a `char(2)` index, so the list is effectively capped at 100 addressable
  positions of `cities.json`.
