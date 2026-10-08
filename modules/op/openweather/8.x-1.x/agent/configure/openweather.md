<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Open Weather

## 1. Credentials
- **OpenWeatherMap appid:** sign up at openweathermap.org and copy your API key.
- **GeoNames username:** register at geonames.org, then enable the account for free webservices
  (used only for timezone/sunrise/sunset lookups).

## 2. Settings form
`/admin/config/services/openweather` (permission `administer openweather settings`), config
object `openweather.settings`:
- **App Id** → `appid`
- **Geonames username** → `geonames_username`
- **Default Cache duration (seconds)** → `cache_duration`

```
drush cset openweather.settings appid 'YOUR_APPID' -y
drush cset openweather.settings geonames_username 'YOUR_GEONAMES_USER' -y
```

## 3. Place the block
`/admin/structure/block` → place **Open Weather Block**. Per block, choose:
- **Input option**: city name / city id / ZIP code / geo coordinates, and the value.
- **Display type**: current details, hourly forecast, or daily forecast.
- **Count**: number of forecast entries (max 36 hourly, max 7 daily).
- **Output items**: which fields to render (temp, humidity, wind, sunrise, etc.).

With the Token module enabled you may enter a token like `[current-user:field_city_name]` as the
input value to derive the location from the viewing user.

## Notes
- Responses are cached for `cache_duration` seconds; raise it to cut API calls.
- A wrong appid surfaces as an error in dblog (watchdog).
- API calls use plain HTTP — do not treat the appid as a confidential secret in transit.
