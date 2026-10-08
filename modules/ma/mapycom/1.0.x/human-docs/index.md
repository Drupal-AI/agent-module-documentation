# Mapy.com — manual setup guide

**Mapy.com** (`mapycom`) integrates the [Mapy.com](https://mapy.com) mapping
service (the mapping platform formerly known as Mapy.cz) into your Drupal site. It
adds a **field type** for storing a location, a **field widget** for picking that
location on a map, a **field formatter** for displaying the map in entity views,
and a **Views style plugin** for showing many locations on a single map. AJAX
support means filters and dynamic map updates work without full page reloads.

You configure map layers, controls, and — importantly — your **Mapy.com API key**
in the module's settings, then attach the Mapy.com field to whichever content types
need a location. It builds on core's **Field** module and supports Drupal 10 and
11.

Because the maps are rendered using Mapy.com's REST API, the module loads
third‑party map assets from Mapy.com and needs a valid API key to work. That makes
it both a **privacy/consent** consideration (visitors' browsers talk to a
third‑party service) and a **secret‑handling** one (the API key should be stored
safely). Both are covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
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
