# Mapy.com — manual setup guide

**Mapy.com** (`mapycom`) integrates the [Mapy.com](https://mapy.com) mapping
service (the platform formerly known as Mapy.cz) into your Drupal site. It adds a
**field type** for storing a location, a **field widget** for picking that location
on an interactive map with address autocomplete, two **field formatters** — a full
map (`mapycom_map`) and a single-marker address view (`mapycom_address`) — and a
**Views style plugin** for showing many locations on one map. AJAX support means
filters and dynamic map updates work without full page reloads.

You configure your **Mapy.com API key** and the map options (layers, marker labels,
navigation controls, zoom behaviour) in the module's settings, then attach the
Mapy.com field to whichever content types need a location. It builds on core's
**Field** and **Inline Form Errors** modules and supports Drupal 10, 11 and 12.
Installing it with Composer also brings in the **Color Field** module, which the
optional routeplanner submodule uses.

Because the maps are rendered in the browser using Mapy.com's REST API, the module
loads third-party map assets from Mapy.com and needs a valid API key to work. The
map, address suggestions and geocoding all run client-side, so the key is delivered
to the page for the map scripts to use — that is how a client-rendered map is meant
to work. It does mean a **privacy/consent** consideration (visitors' browsers talk
to a third-party service). Both points are covered in
[Configuration](configuration/index.md).

## What's new since 1.0.x

- Drupal 12 is now supported alongside 10 and 11.
- Webform support moved to a separate **`mapycom_webform`** submodule (enable it only
  if you use Webform).
- A new **routeplanner** submodule family adds route drawing (and pulls in Color
  Field).
- Saving the settings form now **validates your API key** against the Mapy.com
  Geocoding API and remembers which languages that API supports.
- When no key is set, the map area shows a clear "service unavailable" placeholder
  instead of a broken map, and the Status report flags it for administrators.
- More display options: marker-label toggles, navigation controls, scroll-zoom
  behaviour, auto-zoom-to-fit, a points-of-interest toggle, and an address formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your Mapy.com API key and map
   options, then add the Mapy.com field to your content.

## Where it lives in the admin menu

The module's settings — including the API key — live at
**Configuration → Web services → Mapy.com**
(`/admin/config/services/mapycom`). The field itself is added per content type
under **Structure → Content types → *(your type)* → Manage fields**.
