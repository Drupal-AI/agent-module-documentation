<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cesium (cesium) — agent index

Integrates the **CesiumJS** 3D globe library with Drupal through **Geofield**. Renders geofield
point data as an interactive 3D globe. Package `Other`. Core `^10 || ^11`. PHP `^8.1`. License
GPL-2.0-or-later. Version dir `2.0.x` (release `2.0.0-alpha1`).

- **Field formatter "Cesium Globe" (single geofield point)** → [fields/formatter.md](fields/formatter.md)
- **Views style "Cesium 3D Map" (multiple rows on one globe)** → [views/style.md](views/style.md)
- **Site settings, library variants, Ion token, terrain/buildings** → [config/settings.md](config/settings.md)

## What it actually is

- A **display-only** integration for point data stored in **Geofield** (`geofield:geofield` is the
  sole module dependency). It defines **no entities, no fields, no permissions of its own, no Drush
  commands, no services, no plugin types**.
- The CesiumJS runtime is **self-hosted** at `/libraries/cesium/Build/Cesium/` (or
  `Build/CesiumUnminified/`), installed via `npm-asset/cesium` (`^1.138 || ^2.0`) through Asset
  Packagist. **No CDN** and no request- or config-supplied library URL — see
  `cesium.libraries.yml`.

## Provides (from source)

- **Field formatter** `cesium_geofield_formatter` (label *"Cesium Globe"*, `field_types = {geofield}`)
  — `src/Plugin/Field/FieldFormatter/CesiumGeofieldFormatter.php`. One setting: `zoom` (altitude m,
  default 1000).
- **Views style** `cesium_map` (title *"Cesium 3D Map"*, theme `views_view_cesium_map`) —
  `src/Plugin/views/style/CesiumMap.php`. Options: `width`, `height`, `auto_fit`, `geofield`,
  `title_field`, `description_field`.
- **Settings form** `CesiumSettingsForm` (`src/Form/CesiumSettingsForm.php`) at route
  **`cesium.settings`** → `/admin/config/services/cesium`, permission
  **`administer site configuration`** (`cesium.routing.yml`; menu link in `cesium.links.menu.yml`
  under *Configuration → Web services*). Config object **`cesium.settings`**.
- **Theme hooks** `cesium_formatter` and `views_view_cesium_map` (`cesium.module`,
  `templates/views-view-cesium-map.html.twig`).
- **Libraries** (`cesium.libraries.yml`): `cesium` (minified), `cesium.dev` (unminified),
  `cesium.formatter` (this module's JS/CSS + `core/drupal`, `core/drupalSettings`, `cesium/cesium`).
- **Config schema** (`config/schema/`): `cesium.settings` and `views.style.cesium_map`.

## Mechanism (from source)

- `cesium_page_attachments()` (`cesium.module`) runs on **every page** and pushes
  `drupalSettings.cesium` = `{ cesiumBaseUrl, ionToken, enableTerrain, enableBuildings }` from
  `cesium.settings`. `cesiumBaseUrl` is `base_path() . 'libraries/cesium/' . (Build/Cesium/ | Build/CesiumUnminified/)`
  chosen by the `variant` config (fixed strings; not user-controlled).
- The formatter emits a `<div class="cesium-viewer-container" data-wkt … data-lat … data-lon … data-zoom …>`
  render array (`#type html_tag`) and attaches `cesium/cesium.formatter`.
- The Views style's `render()` builds a `locations` array (`wkt`, `title`, `description`) per row and
  passes it via `drupalSettings.cesium.locations` + `autoFit`.
- `js/cesium_formatter.js` (`Drupal.behaviors.cesiumFormatter`) reads those settings/attributes,
  sets `window.CESIUM_BASE_URL` and `Cesium.Ion.defaultAccessToken`, instantiates `Cesium.Viewer`
  per container, adds point entities and flies the camera.

No routes are state-changing; the only route is the admin config form. No server-side HTTP fetches,
no database queries, no user-supplied library URL.
