# NWS Weather — manual setup guide

**NWS Weather** (`nws_weather`) displays a daily weather forecast on your site
using the US **National Weather Service** REST/JSON API at
[api.weather.gov](https://api.weather.gov/). It fetches the forecast for a location
you configure and renders it — current conditions and a multi‑day outlook — as a
**Multi Day Forecast** block you can place anywhere.

The problem it solves is showing live, official US weather data without wiring up
an API integration yourself. The National Weather Service API is public and free
(no API key required), and this module handles the fetching and rendering, leaving
you to set the location and place the block.

It is a **content‑display** feature: it provides its own permissions and a settings
form, but has no content‑access role. One operational detail to know up front — the
Multi Day Forecast block **disables Drupal's internal page cache for anonymous
users** on pages where it appears, so the forecast stays current. It works on
Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the forecast location and place
   the Multi Day Forecast block.

## Where it lives in the admin menu

Configure the weather block at **Configuration → Web services → NWS Weather**
(`/admin/config/weather/nws_weather`). Place the **Multi Day Forecast** block from
**Structure → Block layout** (`/admin/structure/block`). See
[Configuration](configuration/index.md) for details.
