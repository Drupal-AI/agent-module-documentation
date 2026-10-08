# Configuration

Live Weather is configured entirely from its admin pages, all gated by the
**live_weather configuration** permission. You'll do three things: enter your API
credentials, add one or more locations, and choose which weather details the block
displays.

## Open the settings

1. Log in as a user with the **live_weather configuration** permission.
2. Open Live Weather's configuration pages (the location form and the settings
   form). The location page is the module's primary configure route.

## API credentials

Live Weather signs its request to the weather provider, so it needs your API
credentials — an **app id**, a **consumer key**, and a **consumer secret**. Enter
these on the configuration page.

Historically these came from creating an app in Yahoo's developer portal; as noted
in the [overview](../index.md), that endpoint is now defunct, so in practice you'll
need credentials for a compatible service.

> **Keep the secret out of code and out of Git.** Even though this module stores
> its credentials in configuration rather than a Key entity, treat the consumer
> secret as sensitive. If you deploy configuration, be careful not to commit the
> secret value — use per‑environment overrides (for example a settings override
> that reads from an environment variable) so the secret never lands in your
> exported config or repository.
>
> **A word on transport security:** this module's outbound API call disables TLS
> certificate verification. That means the connection to the weather provider is
> not authenticated the way a normal HTTPS request would be. Weigh this before
> using it in production.

## Locations

Add one or more locations by their **WOEID** (Where On Earth IDentifier). Each
WOEID identifies a place for which the module will fetch weather. You can manage a
list of locations, add new ones, and delete locations you no longer need. Because
different locations can be shown in different blocks, add every location you plan to
display.

## What the weather block shows

On the settings form you choose which details appear in the weather block:

- **Forecast image** — show or hide the conditions icon/image.
- **Wind speed** — show or hide wind information.
- **Humidity level** — show or hide humidity.
- **Visibility level** — show or hide visibility.
- **Sunrise time** and **Sunset time** — show or hide each.
- **Units** — Fahrenheit or Celsius for the temperature reading.

There is also a **cache** option that controls how often the weather report
refreshes — lengthen it to reduce calls to the API, shorten it for fresher data.

## Place the block

Once locations and display options are set, go to **Structure → Block layout**
(`/admin/structure/block`) and place a Live Weather block in the region where you
want the report to appear. Repeat with different blocks if you want to show
different locations in different regions.

## Save

Save each form after making changes. The weather block reflects your settings on
the next page load (or after the cache window you configured elapses).
