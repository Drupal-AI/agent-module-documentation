<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & the OpenWeatherMap service

## Settings form

`src/Form/WeatherSettingsForm.php` (`WeatherSettingsForm extends ConfigFormBase`).

- Form id: `weather_settings_form`.
- Editable config: `city_weather_field.weathersettings`.
- Route: `city_weather_field.weather_settings_form` →
  **`/admin/config/city_weather_field/settings`**, permission
  **`administer site configuration`**, `_admin_route: TRUE`
  (`city_weather_field.routing.yml`).
- Menu link `city_weather_field.weather_settings_form` (title *"City Weather field Settings"*)
  under parent `system.admin_config_system` (`city_weather_field.links.menu.yml`).
- This route is the module's `configure:` entry in `city_weather_field.info.yml`.

The form has one required field:

| Form key | Type | Meaning |
|---|---|---|
| `api_key_openweather` | `textfield` (maxlength/size 64, `#required`) | OpenWeatherMap API key |

`submitForm()` saves it to `city_weather_field.weathersettings.api_key_openweather`.

## Config object

`config/install/city_weather_field.weathersettings.yml`:

```yaml
api_key_openweather: ""
```

Single key `api_key_openweather` (string). **No `config/schema/`** ships, so there is no typed
schema for this object.

## The weather service

Service id **`city_weather_field.default`** → `Drupal\city_weather_field\WeatherService`
(`city_weather_field.services.yml`, argument `@http_client`).

`WeatherService::getWeatherInformation($apiKey, $cityId)`:

- Builds the request URL from `$baseUri` + `/data/2.5/weather?q=<cityId>&lang=en&units=metric&APPID=<apiKey>`
  and issues a Guzzle `GET`.
- Decodes the JSON response and returns an array:
  `name`, `description` (`ucwords()` of `weather[0].description`), `max_temperature`
  (`main.temp_max`), `min_temperature` (`main.temp_min`), `humidity` (`main.humidity`),
  `wind` (`wind.speed`), `icon` (`weather[0].icon` + `.png`). Missing keys default to `""`.
- On `GuzzleException` it logs via `Error::logException` (with a `watchdog_exception` fallback for
  older core) to channel `city_weather_field` and returns `FALSE`.

`units=metric` is why the template shows temperatures in °C. `lang=en` fixes the description
language.

## Operating it

1. Get an API key from https://home.openweathermap.org/api_keys.
2. Save it at `/admin/config/city_weather_field/settings`, or via config:

```bash
drush cset city_weather_field.weathersettings api_key_openweather 'YOUR_KEY' -y
drush cr
```

3. Add a **"City - weather"** field (see [../fields/weather-field.md](../fields/weather-field.md)),
   pick a city, and view the entity.

If the key is empty or invalid, OpenWeatherMap returns an error response / the Guzzle call fails,
the service returns `FALSE`, and the formatter renders nothing for that item.
