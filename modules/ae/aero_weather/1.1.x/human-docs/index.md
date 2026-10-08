# Aero Weather — manual setup guide

**Aero Weather** (`aero_weather`) shows real-time weather and forecasts on your
site as responsive widgets, using data from the third-party service
[WeatherAPI](https://www.weatherapi.com/). It is a display/integration module: you
place a weather block, and it renders current conditions and a forecast with a
choice of layouts, colour palettes, and which metrics to show. It depends on
core's **Block** module.

Because the data comes from WeatherAPI, the module makes outbound calls to that
service and needs a **WeatherAPI key** to authenticate. You sign up with
WeatherAPI, obtain a key, and give it to the module.

**A note on the key and on privacy.** Treat the WeatherAPI key as a secret: prefer
storing it in an environment variable (or a Key entity) rather than committing it
anywhere public, and make sure calls go over HTTPS. If you configure the widget to
use a visitor's own location, remember that location is personal data — disclose
it in your privacy policy and obtain consent as your jurisdiction requires.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on these docs:** the available reference material for this module is
> brief. This page explains what it does and how to install it and honestly
> describes the API-key requirement, but the exact settings screen is not
> documented here. After enabling the module, look for its options in the admin
> menu and its weather block under **Structure → Block layout**.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Sign up at WeatherAPI and get your API key.
2. Store the key securely (an environment variable or a Key entity is preferable
   to typing it into plain configuration) and provide it to the module.
3. Place the weather block from **Structure → Block layout**
   (`/admin/structure/block`) in the region where you want the widget to appear.
4. Configure the widget — its location, layout, palette, and which weather metrics
   to display — then save.

Visitors then see live weather rendered by the widget, refreshed from WeatherAPI.
