# Live Weather — manual setup guide

**Live Weather** (`live_weather`) displays a customizable weather report as a
block, pulling the data from a third‑party weather API. You configure one or more
locations (identified by their WOEID, "Where On Earth IDentifier"), enter your API
credentials, and choose which details to show — forecast image, wind speed,
humidity, visibility, sunrise, and sunset — and the module renders a weather
widget you can place in a region. Different locations can be shown in different
blocks, and a cache option controls how often the report refreshes.

Two important caveats before you invest time in this module:

- **The historically targeted endpoint (the Yahoo Weather API) is defunct.** The
  module was written against Yahoo's weather service, which no longer operates as
  it did, so out of the box it may not return live data. Treat this module as
  usable primarily if you can point it at a compatible endpoint.
- **The outbound API request is made with TLS certificate verification disabled.**
  The module's service turns off certificate checking on the signed API call,
  which weakens the security of that connection. Factor this in before enabling it
  on a production site, especially one handling any sensitive traffic.

All configuration and location management is admin‑only, gated by the **live_weather
configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up API credentials, add
   locations, and choose what the weather block shows.

## Where it lives in the admin menu

Live Weather's admin pages handle location and settings management (the location
form, the settings form, and location deletion), all gated by the **live_weather
configuration** permission. After configuring locations, you place the weather
block through **Structure → Block layout**.
