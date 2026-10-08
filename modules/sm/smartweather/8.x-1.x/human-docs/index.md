# Smart Weather — manual setup guide

**Smart Weather** (`smartweather`) displays current weather and an optional
forecast of up to seven days on your Drupal site, sourced from
[OpenWeatherMap.org](https://openweathermap.org/). It is "smart" in that, by
default, it detects each visitor's location automatically and shows the weather for
where they are — or you can pin it to a fixed latitude and longitude if you would
rather everyone see the same location's weather.

The problem it solves is the whole pipeline of turning a visitor into a local
forecast: it looks up the visitor's approximate location from their IP address
(using GeoPlugin.com, which includes MaxMind GeoLite data), then fetches the weather
for that location from OpenWeatherMap. You can show temperatures in Celsius or
Fahrenheit, and the markup includes CSS classes and IDs so you can style it to match
your theme.

It needs configuration before it does anything useful — specifically a free
**OpenWeatherMap API key**, which you create by registering at OpenWeatherMap.org.
Keep that key out of plain, committed configuration; it is the one sensitive value
here (the forecasts themselves are public data). Be mindful of the third-party rate
limits: OpenWeatherMap's free tier allows 60 calls/minute and up to 1,000,000
calls/month, and GeoPlugin's free service allows 120 requests/minute; if your
traffic approaches those limits you may need a paid plan. To ease this, Smart
Weather caches weather data in Drupal for a period so it does not hit the APIs on
every request.

It has no module dependencies and runs on Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add your OpenWeatherMap API key and
   choose location, units, and forecast options.

## Where it lives in the admin menu

The settings form is at **Administration → Configuration → Smart Weather → Settings**
(`/admin/config/smartweather/settings`), where you enter the API key and set how the
weather is sourced and displayed.
