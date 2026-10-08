# Flexible Weather API — manual setup guide

**Flexible Weather API** (`flexible_weather_api`) brings live weather data —
current conditions and forecasts — into your Drupal site by connecting to external
weather services. Its defining feature is a **flexible provider system** built on
Drupal's plugin architecture: it ships integrations for several services (such as
Open Weather Map, WeatherStack, and Yahoo Weather) and is designed so that new
providers can be added as plugins.

You configure which weather service to use, and its credentials, on the module's
settings form. Two submodules extend it: **weather_api_entity** and
**weather_api_plugin**, which you enable only if you need what they provide.

Because it talks to a third-party API on your behalf, there are two things to keep
front of mind. First, the service **authenticates with an API key** — that key is
a secret and must be stored as one (never committed to configuration exports).
Second, every page that fetches weather makes an **outbound request** to the
provider and counts against its rate limits and terms — so cache output where you
can, and be aware of any per-call costs your plan may carry. The module has no
access-control role; the weather data it retrieves is external content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick any submodules you need.
2. [Configuration](configuration/index.md) — choose a weather provider, store the
   API key as a secret, and connect the service.

## Where it lives in the admin menu

The module's settings form is registered as
`flexible_weather_api.weather_api_services` (in the **Weather API** package) — this
is where you select and configure the weather service.
