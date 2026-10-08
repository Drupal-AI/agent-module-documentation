# Styled Google Map — manual setup guide

**Styled Google Map** (`styled_google_map`) renders a
[Geofield](https://www.drupal.org/project/geofield) value as a fully styled,
interactive **Google Map**. Give it a latitude/longitude and it produces a
branded map with custom pins, styled popups, zoom and gesture controls, and
optional turn‑by‑turn directions — all configured through the normal Field
display and Views user interface, with no theming or JavaScript required.

There are two ways to use it. The **field formatter**
(`styled_google_map_default`) shows a single entity's location on its display
page — for example a node's address on its full view. The **Views style**
(`styled_google_map`) plots many entities as markers on one map — a
store‑locator, a directory, or a property map — and adds multi‑marker features
like clustering (grouping nearby pins so the map stays readable), spiderfying
(fanning out pins that share the same coordinates), heatmaps, and a configurable
map center. Both share a rich set of appearance options: a raw Google Maps JSON
style string (paste one from Snazzy Maps or Google's styling wizard), custom
marker images, default/min/max zoom, individual control toggles, and a styleable
info‑bubble popup that can render a chosen view mode as its body.

The one thing every map needs is a **Google Maps API key**, which you enter once
on the module's global settings form and it reuses everywhere. Two optional
submodules — a Real Estate **demo** entity type and a **data** package of example
content and views — showcase every feature if you want to see it working before
building your own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the submodules.
2. [Configuration](configuration/index.md) — set the Google Maps API key, then
   build a single‑location or multi‑location map.

## Where it lives in the admin menu

- The global settings form (the API key) sits at **Configuration → Web services
  → Styled Google Map** (`/admin/config/services/styled_google_map`).
- Individual maps are configured on a bundle's **Manage display**
  (the field formatter) or in a **View**'s Format settings (the Views style).

## How to use it

First, get a Google Maps JavaScript API key from the Google Cloud console and
enter it on the settings form (see [Configuration](configuration/index.md)) —
without a valid key the map renders as a plain grey box, which is the single most
common cause of "my map isn't showing". Then add a Geofield to your content and
either set that field's display format to **Styled Google Map** (single
location) or build a View of geolocated content and choose **Styled Google Map**
as the Views style (many locations).
