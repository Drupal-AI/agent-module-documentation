# Configuration

Setting up Open Weather has two stages: enter your API credentials on the settings
form, then place and configure one or more weather blocks.

## 1. Get your credentials

- **OpenWeatherMap appid:** sign up at
  [openweathermap.org](https://openweathermap.org/) and copy your API key.
- **GeoNames username:** register at [geonames.org](https://www.geonames.org/),
  confirm your account by email (check spam), log in, open your account page, and
  click **"Enable account for free webservices"** at the bottom. This username is
  used only for timezone and sunrise/sunset lookups.

## A note on storing the appid

The module sends its API calls over plain `http://`, so the appid is transmitted
**unencrypted** and should not be treated as a high-value secret. Even so, avoid
committing it to version control. On DDEV you can keep it in an environment
variable rather than hard-coding it:

```bash
ddev dotenv set .ddev/.env --openweather-appid=YOUR_APPID
ddev restart
```

That exposes it as `OPENWEATHER_APPID` inside the container (keep `.ddev/.env` out
of version control); you can then reference it from `settings.php` via
`getenv('OPENWEATHER_APPID')` and set it into config. If you prefer, simply type
the appid straight into the settings form below — just remember it is not
transmitted securely.

## 2. Settings form

Go to **Configuration → Web services → Open Weather**
(`/admin/config/services/openweather`). This page requires the **administer
openweather settings** permission. It stores three values in the
`openweather.settings` config object:

- **App Id** — your OpenWeatherMap appid. If this is wrong, the block shows an
  error and the failure is logged to dblog (**Reports → Recent log messages**).
- **Geonames username** — the GeoNames webservice username you enabled above.
- **Default cache duration (seconds)** — how long API responses are cached.
  Raising this reduces how often the module calls OpenWeatherMap; lowering it makes
  the displayed weather fresher at the cost of more API calls.

You can also set these from the command line:

```bash
drush cset openweather.settings appid 'YOUR_APPID' -y
drush cset openweather.settings geonames_username 'YOUR_GEONAMES_USER' -y
drush cset openweather.settings cache_duration 3600 -y
```

## 3. Place and configure a weather block

Go to **Structure → Block layout** (`/admin/structure/block`) and place the **Open
Weather Block** in a region. Each block instance has its own settings:

- **Input option** — choose how the location is specified: **city name**,
  **city ID**, **ZIP code**, or **geographic coordinates** — then enter the
  matching value in the text field. With the Token module enabled, you may instead
  enter a token such as `[current-user:field_city_name]` (where `field_city_name`
  is a field you added to user accounts at
  `/admin/config/people/accounts/fields`) to base the location on the viewing user.
- **Display type** — **current weather details**, an **hourly forecast**, or a
  **daily forecast**.
- **Count** — the number of forecast entries to show. The maximum is **36** for the
  hourly forecast (3-hour intervals) and **7** for the daily forecast.
- **Output items** — tick exactly which fields to render: temperature, min/max,
  humidity, pressure, wind speed and direction, sunrise and sunset, and so on.
- **Localization** — a language code and custom date/time formats control how
  times (such as sunrise/sunset) are displayed.
- **Warning message** — the text shown if the input or count field is left empty.

Place the block several times — once per city — to show weather for multiple
locations. You can override the block's Twig template in your theme to fully
restyle the output.

## Save

Save the settings form after entering your credentials, and save each block after
configuring it. Changes take effect on the next page load (subject to the cache
duration you set).
