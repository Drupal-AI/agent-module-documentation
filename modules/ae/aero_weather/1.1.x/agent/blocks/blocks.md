<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Aero Weather blocks + the `aero_weather.api` service

## Install & enable

```bash
composer require drupal/aero_weather
drush en aero_weather -y
```

Only dependency is core **`block`**. Then set the WeatherAPI key at
`/admin/config/system/aero-weather` (see [../config/settings.md](../config/settings.md)) and place
a block at *Structure → Block layout*.

## The service — `aero_weather.api` (`AeroWeatherApi`)

Defined in `aero_weather.services.yml`; class `src/Service/AeroWeatherApi.php`. Injected: config
factory, `http_client_factory`, `cache.default`, `logger.factory`, module handler, string
translation, `file_url_generator`, entity type manager (for file storage).

- **`getWeatherData(string $location, ?int $forecast_days = 5, bool $include_aqi = TRUE): array`**
  — reads `api_key` + `cache_enabled` from `aero_weather.settings`; returns `[]` if no key or empty
  location. Builds `https://api.weatherapi.com/v1/forecast.json?key=…&q={location}&days={n}&aqi={yes|no}&alerts=yes`
  and GETs it with `httpClientFactory->fromOptions()` (default Guzzle options — TLS verification
  on). On success decodes the JSON body and, when the `location` key is present, caches
  `['date' => Y-m-d, 'location_data' => …]` in `cache.default` under
  `aero_weather_{sha256(location_'_'.days)}`. `ConnectException`/`RequestException` are caught and
  logged; the method returns `[]` on failure.
- **Day-scoped cache read:** a cache hit is only used when its stored `date` equals *today* — so
  data is effectively refreshed at least daily even with a long TTL. TTL (when caching enabled) =
  `getCacheTimestamp()` = `time() + cache_time * (60|3600)` per `cache_unit`.
- **`searchLocations(string $query): array`** — `search.json?key=…&q={urlencode(query)}`
  autocomplete helper, 1-hour cache, min 3 chars. **Not wired to any route or block** in this
  release (no autocomplete controller ships); it is a public API surface only.
- **`getWeatherIconSettings(): array`** — for each of 9 metrics builds icon markup per the global
  `icon_style` (`upload_url` / `url` / `font` / default). Uploaded + URL icons are emitted as
  `<img>` with `Html::escape()` on src/alt; `font` markup is run through
  `Xss::filter($font, ['i','span','em'])` before `Markup::create()`. Values come from the
  admin-only settings form.
- **`isCacheEnabled()`, `getCacheTimestamp()`, `generateHashFromText()` (sha256),
  `invalidateCache()`, `getAqiLabel(int): string`** — helpers.

## Block plugins

| Plugin id | Class | admin_label |
|---|---|---|
| `aero_weather_horizontal_block` | `AeroWeatherHorizontalBlock` | Aero Weather (Horizontal) |
| `aero_weather_vertical_block` | `AeroWeatherVerticalBlock` | Aero Weather (Vertical) |

Both implement `ContainerFactoryPluginInterface`, use `AeroWeatherBlockTrait`, and inject
`aero_weather.api`, entity type manager, file usage, entity repository, `cache.default`,
`date.formatter`, `file_url_generator`.

### Shared block config (`AeroWeatherBlockTrait::buildCommonBlockForm`)

`location_name` (required textfield — city / postal code / `lat,lon`), `date_format` (select from
`date_format` entities), `color_palette` (`aero_weather_color_palettes()`), `round_border`,
`show_forecast`, `forecast_days` (3/5/7/10/14), `show_aqi`, `show_alerts`, and a `background_image`
`managed_file` (`public://aero_weather_images/`, extensions gif png jpg jpeg svg webp). The
horizontal block adds `enable_swiper_js`; the vertical block adds `layout`
(layout-1/2/3). Submit is handled by `submitCommonBlockForm()` which promotes/temporary-marks the
background file and stores the rest into `$this->configuration`.

### `build()`

Both call `apiService->getWeatherData($location_name, $forecast_days, $show_aqi)` and
`getWeatherIconSettings()`, format `location.localtime_epoch` with the chosen date format, mint a
per-render UUID (`aero_weather_generate_weather_card_uuid()`) for element ids, resolve the
background image URL, and return a render array:

```php
'#theme' => 'aero_weather_horizontal_block' | 'aero_weather_vertical_block',
'#weather_data' => $weather_data,          // full decoded WeatherAPI response
'#config' => [ 'formatted_date', 'color_palette', 'round_border', 'forecast_days',
               'uuid', 'background_image_url', 'icon_settings', 'show_aqi', 'show_alerts', … ],
'#cache' => [ 'keys' => ['aero_weather', 'horizontal'|'vertical', $location_name],
              'tags' => ['config:aero_weather.settings'], 'max-age' => 0 ],
'#attached' => [ 'library' => [ 'aero_weather/color_palettes',
                                'aero_weather/aero_weather_horizontal'|'…_vertical', (+swiper_cdn) ] ],
```

`max-age => 0` means the render layer does not cache the block; freshness is governed by the
service's own day-scoped API cache.

### Templates (`templates/*.html.twig`)

`aero-weather-horizontal-block.html.twig` and `aero-weather-vertical-block.html.twig` read
`weather_data.current`, `.location`, `.forecast.forecastday`, `.alerts.alert` and
`current.air_quality`. Every value taken from the WeatherAPI response is output escaped —
condition/alert/location text via `|e`, condition-icon URLs and the background image via
`|escape('html_attr')`, numeric metrics via `|round`. The AQI slide maps `us-epa-index` (1–6) to a
translated label. If `weather_data` is empty a "Weather data unavailable — check API key and
location" notice renders. Per-metric icon partials live in `templates/icons/`.

## Extensibility

- `hook_aero_weather_color_palettes_alter(array &$palettes)` (`aero_weather.api.php`) — invoked by
  `aero_weather_color_palettes()` in the `.module`; add/modify/remove palette options.
- The README also mentions a `hook_aero_weather_data_alter()`; **no such invocation exists in this
  release's code** — the decoded response is not passed through a data-alter hook. Treat it as
  documentation only, not a working extension point.

## Cache flush

`aero_weather_cache_flush()` (`.module`) runs `\Drupal::cache()->deleteAll()` on a full cache
flush; the settings form's "Clear All Weather Cache" button does the same via
`cache.default->deleteAll()`.
