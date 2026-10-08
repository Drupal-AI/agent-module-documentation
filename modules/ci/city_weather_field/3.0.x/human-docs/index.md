# City Weather Field — manual setup guide

**City Weather Field** (`city_weather_field`) provides a Drupal field type that
stores a city and displays that city's **current weather**. When the field is
shown, the module queries a weather API (OpenWeatherMap) and renders the live
conditions for the selected place — handy for location, travel, or event content
that wants weather context alongside a location. Editors pick a US city from a
select list on the field, and the weather for that city appears with the content.

There are two things to set up. First, the module needs an **API key** from
OpenWeatherMap before it can fetch anything; you enter that on the module's
settings form. Second, you add a **City – weather** field to whatever content type
should carry it, and choose the city per content item.

Because the module calls an external weather service on each display, treat the
API key as a secret (store it in an environment variable, not in code), and be
mindful of request volume — cache responses so you don't hammer the API or slow
down page loads. The module depends only on core's Field system and supports
Drupal 9.3+, 10.1+, and 11. It is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the OpenWeatherMap API key and
   add a City – weather field.

## Where it lives in the admin menu

The API-key settings form sits at **Configuration → City Weather Field → Settings**
(`/admin/config/city_weather_field/settings`). The field itself is added and
configured through the Field UI on your content types (**Manage fields**).
