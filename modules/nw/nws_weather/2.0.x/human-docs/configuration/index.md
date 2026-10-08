# Configuration

Setting up NWS Weather is two steps: tell it **which location** to forecast, then
**place the block** that shows the forecast.

## Open the settings form

1. Log in as a user who can administer the module (an administrator by default —
   the module provides its own permissions for this).
2. Go to **Configuration → Web services → NWS Weather**, or navigate directly to
   `/admin/config/weather/nws_weather`.

## Set the forecast location

The settings form lets you configure the location the forecast is fetched for. The
options are intended to be self‑explanatory — provide the location details the form
asks for (the National Weather Service API resolves a location to its forecast
grid). Save the configuration once the location is set.

Because the data comes from `api.weather.gov`, make sure your environment is
allowed to make outbound HTTPS requests to that host; in hosting that filters
outbound traffic, allow egress to `api.weather.gov`. No API key is required.

## Place the Multi Day Forecast block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **Multi Day Forecast** block and place it in the region where you want
   the forecast to appear.
3. Configure the block's visibility and title as you would any block, and save.

## Page cache behavior

Be aware that on pages where the **Multi Day Forecast** block appears, the module
**disables Drupal's internal page cache for anonymous users** so the forecast stays
current. This is expected behavior. If page‑cache hit rates matter for a
high‑traffic page, take that into account when deciding where to place the block.

## Save and verify

After saving the location and placing the block, load a front‑end page that
includes the block and confirm the current conditions and multi‑day forecast
render. If nothing appears, re‑check the location settings and confirm the server
can reach `https://api.weather.gov/`.
