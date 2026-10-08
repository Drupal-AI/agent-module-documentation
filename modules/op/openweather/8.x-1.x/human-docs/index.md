# Open Weather — manual setup guide

**Open Weather** (`openweather`) fetches live weather data from the
[OpenWeatherMap](https://openweathermap.org/) API and renders it in a configurable,
themeable block. It was written to fill the gap left when Google retired its
weather API, giving Drupal sites a straightforward way to show current conditions
and forecasts again.

The heart of the module is the **Open Weather Block**, which you can place as many
times as you like — each instance configured for a different location and a
different mix of details. You give a block a location as a **city name**, a
**city ID**, a **ZIP code**, or **geographic coordinates**; with the optional
[Token](https://www.drupal.org/project/token) module installed you can even derive
the location from the viewing user's profile field, using a placeholder like
`[current-user:field_city_name]`. A block can show **current conditions**, an
**hourly forecast** in 3-hour steps (up to 36 entries), or a **daily forecast**
(up to 7 days), and you choose exactly which fields it outputs — temperature,
min/max, humidity, pressure, wind, sunrise and sunset, and more.

Behind the scenes a weather service builds each query, calls OpenWeatherMap, and
caches the response for a duration you set (in seconds) to keep API usage down.
Sunrise/sunset and timezone data are resolved through the **GeoNames** webservice,
which needs its own free username. To make any of this work you need two things: an
OpenWeatherMap API key (the "appid") and a GeoNames username — both entered on the
settings form and covered in [Configuration](configuration/index.md).

One security note worth stating plainly: the service calls both OpenWeatherMap and
GeoNames over plain `http://`, so your appid travels **unencrypted**. Treat it as
a low-value key (it grants read access to a weather API), rotate it if you are
concerned, and do not reuse a secret you care about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your OpenWeatherMap appid and
   GeoNames username, and place and configure weather blocks.

## Where it lives in the admin menu

- **Configuration → Web services → Open Weather**
  (`/admin/config/services/openweather`) — the settings form for the appid,
  GeoNames username, and cache duration (permission: *administer openweather
  settings*).
- **Structure → Block layout** (`/admin/structure/block`) — place the **Open
  Weather Block** and configure each instance's location and output.
