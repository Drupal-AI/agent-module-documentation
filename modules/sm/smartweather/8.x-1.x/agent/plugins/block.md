<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Weather block — smartweather

`Drupal\smartweather\Plugin\Block\WeatherBlock` — the module's only rendering surface.

```
@Block(
  id = "openweather_block",
  admin_label = @Translation("Smart Weather Block"),
  category = @Translation("Openweather")
)
```

Implements `ContainerFactoryPluginInterface`; `create()` injects `smartweather.clientlocation` and
`smartweather.openweather`. The block has **no `blockForm`/`blockSubmit`** — it has no per-instance
settings; everything comes from `smartweather.settings`. Place it via
`/admin/structure/block` (or in code) like any block.

## Data flow (all in the constructor)

`WeatherBlock::__construct` reads `\Drupal::config('smartweather.settings')` and runs the lookups
immediately (not lazily in `build()`):

1. `get_lat_long()` — if `openweather_default_lat` **and** `openweather_default_long` are set, use
   them directly. Otherwise call `client_location->get_client_location($openweather_default_ip)`
   (the configured dev IP, or `''` → real client IP). An `error_data` key becomes `error_message`.
2. `weather_details()` — if no error, calls
   `open_weather->get_weather($openweather_api_key, $lat, $long, $openweather_degrees)` and stores
   the result under `weather_data['data']`, plus `weather_data['unit']` and
   `weather_data['forecast_days']`.
3. `weather_data['error']` is set to the first error encountered (empty string when OK).

`build()` returns:

```php
[
  '#theme' => 'openweathermap',
  '#weather_data' => $this->weather_data,
  '#attached' => ['library' => ['smartweather/weatherblock']],
]
```

Because the block does not set cache contexts/max-age, rendered output follows the block/page cache;
the underlying HTTP data is separately cached 3600s in `cache.default`.

## Theme + template

- Theme hook `openweathermap` is registered in `smartweather.module` (`smartweather_theme()`), single
  variable `weather_data` (default `NULL`).
- Template `templates/openweathermap.html.twig`. Structure of `weather_data`:
  - `error` — string; when non-empty the template renders only `<span class="weathererror">`.
  - `unit` — `metric` (rendered as "C") or `imperial` ("F").
  - `forecast_days` — `''` or `1`..`7`; drives the `#weatherforecast` loop.
  - `data` — the raw OpenWeather One Call payload. Template reads `data.current.dt`,
    `data.current.temp`, `data.current.feels_like`, `data.current.humidity`,
    `data.current.weather.0.main`, `data.current.weather.0.icon`, and `data.daily[i]` (`dt`,
    `temp.max`, `temp.min`, `weather.0.icon`) for each forecast day.
- Weather icons are loaded from `http://openweathermap.org/img/wn/<icon>@2x.png` (plain-HTTP `<img>`
  src — expect mixed-content warnings on an HTTPS site).
- All dynamic values are printed through Twig `{{ }}` (auto-escaped); no `|raw`.

## Styling

Library `smartweather/weatherblock` = `templates/css/smart-weather.css`. Hook points: ids
`#currentweather`, `#weatherforecast`; classes `weathererror`, `weatherdate`, `weathertemp`,
`weathericon`, `weathertempunit`, `weatherfeelslike`, `weatherhumidity`, `main`.
