# Cesium — manual setup guide

**Cesium** (`cesium`) integrates the open-source
[CesiumJS](https://cesium.com/platform/cesiumjs/) library into Drupal so you can
render geospatial data on a high-performance, interactive **3D globe**. It adds a
**Cesium Globe** field formatter for [Geofield](https://www.drupal.org/project/geofield):
point a Geofield at this formatter and its coordinates are drawn on a 3D globe,
with the camera automatically flying to the location. It's well suited to
geospatial and scientific visualization where a flat map isn't enough.

The formatter reads several input formats from Geofield (including WKT and raw
latitude/longitude pairs) and works with different storage backends, including the
default and PostGIS. It uses Drupal's core library system (via Asset Packagist) to
load CesiumJS rather than the legacy Libraries API. It depends on the **Geofield**
module and supports Drupal 10 and 11.

There is one setup wrinkle worth knowing before you start: CesiumJS is a large
JavaScript library that Cesium does **not** bundle, so it must be present at
`web/libraries/cesium/`. Getting it there via Composer needs a little extra
project configuration (an Asset Packagist repository and an installer for npm
assets) — the [Installation](installation/index.md) page walks through it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and get the CesiumJS
   library in place.
2. [Configuration](configuration/index.md) — the settings form (library variant
   and Cesium Ion access token) and how to use the field formatter.

## Where it lives in the admin menu

Cesium's settings form sits at **Configuration → Web services → Cesium settings**
(`/admin/config/services/cesium`). The globe itself is enabled per field on a
content type's **Manage display** by choosing the **Cesium Globe** formatter.

## How to use it

In short: add a **Geofield** to a content type, then on its **Manage display** set
the field's format to **Cesium Globe**. Use the formatter's cog icon to set the
zoom altitude. When you create content and enter spatial data (for example
`POINT (lon lat)`), the field renders as an interactive 3D globe that flies the
camera to that location. See [Configuration](configuration/index.md) for details.
