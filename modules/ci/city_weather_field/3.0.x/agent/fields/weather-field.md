<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "City - weather" field (type + widget + formatter)

## Install & enable

```bash
composer require drupal/city_weather_field
drush en city_weather_field -y
```

Only dependency is core **`field`**. No sub-modules, no permissions, no Drush commands.
Set the OpenWeatherMap API key first — see [../config/settings.md](../config/settings.md).

## The three plugins

| Plugin | Id | Label | File |
|---|---|---|---|
| Field type | `weather_field_type` | *City - weather* | `src/Plugin/Field/FieldType/WeatherFieldType.php` |
| Widget | `weather_widget` | *US Cities* | `src/Plugin/Field/FieldWidget/WeatherFieldWidget.php` |
| Formatter | `weather_formatter` | *Weather* | `src/Plugin/Field/FieldFormatter/WeatherFieldFormatter.php` |

The field type declares `default_widget = "weather_widget"` and
`default_formatter = "weather_formatter"`, so choosing the field on *Manage form display* /
*Manage display* wires the widget and formatter automatically.

## Add it to a bundle

UI: *Structure → (entity type) → Manage fields → Add field* → choose **"City - weather"** → save.
On *Manage form display* the field shows the **US Cities** select; on *Manage display* choose the
**Weather** format. No formatter or widget settings exist (neither plugin defines
`defaultSettings()` / `settingsForm()`).

Drush/config equivalent adds a field of type `weather_field_type` like any other field.

## What is stored

`WeatherFieldType::schema()` defines one column:

```php
'value' => ['type' => 'char', 'length' => 2, 'not null' => FALSE]
```

Property `value` is a `string` DataDefinition labelled *City*. `isEmpty()` is true when `value`
is `NULL` or `''`. The stored value is the **numeric index** of the chosen city within the list
returned by `city_weather_field_get_cities()` — not the city name and not an OWM city id. Because
the column is `char(2)`, only the first ~100 positions are addressable.

## The widget (city select)

`WeatherFieldWidget::formElement()` builds:

```php
$cities = city_weather_field_get_cities();
$element['value'] = $element + [
  '#type' => 'select',
  '#options' => $cities,
  '#empty_value' => '',
  '#default_value' => ... // current index if still present in $cities
  '#description' => $this->t('Select a city'),
];
```

`city_weather_field_get_cities()` (in `city_weather_field.module`) reads the module's bundled
**`cities.json`** (1000 US cities, each `{city, state, latitude, longitude, ...}`) with
`file_get_contents()` on the module's own path, and returns a numerically-indexed array of the
`city` names. The array **keys** (0,1,2,…) are what get stored; the **values** are the city names.

## The formatter (render weather)

`WeatherFieldFormatter` implements `ContainerFactoryPluginInterface` and is injected with
`city_weather_field.default` (the `WeatherService`) and `config.factory`.

`viewElements()`:

1. Reads `api_key_openweather` from config `city_weather_field.weathersettings`.
2. Rebuilds the city list; for each item whose stored index exists in the list, resolves the
   **city name** `$city_name = $cities[$item->value]`.
3. Calls `$this->weatherService->getWeatherInformation($open_weather_api_key, $city_name)`.
4. If the service returns an array, emits one element:

```php
$elements[$delta] = [
  '#theme' => 'city_weather_field',
  '#name' => ...,
  '#description' => ...,
  '#max_temperature' => ...,
  '#min_temperature' => ...,
  '#humidity' => ...,
  '#wind' => ...,
  '#icon' => ...,
];
```

If the service returns `FALSE` (API/Guzzle error) the delta is skipped — the field renders empty.

## The template

`templates/city-weather-field.html.twig` (theme hook `city_weather_field`, registered in
`city_weather_field_theme()`) renders an `<h2>{{ name }} Weather Status</h2>`, the description, an
`<img src="http://openweathermap.org/img/w/{{ icon }}">` icon, `{{ max_temperature }}°C`, humidity
and wind. All interpolated values are auto-escaped by Twig. Note the theme hook declares `date`
and `time` variables that the formatter never populates.

## Caveats

- **One external HTTP request per field item, per uncached view.** The formatter attaches no cache
  metadata / max-age, so every cold render triggers a fresh OpenWeatherMap call — a traffic, latency
  and OWM-quota consideration on high-traffic or anonymous pages.
- The stored value is an index into the current `cities.json`; if that file changed order across
  versions, existing stored values would point at different cities.
- No formatter/widget settings and no config schema for them.
