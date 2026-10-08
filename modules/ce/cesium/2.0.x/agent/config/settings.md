<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cesium site settings

## Route & access

- Form: `CesiumSettingsForm` (`src/Form/CesiumSettingsForm.php`, extends core `ConfigFormBase`,
  form id `cesium_settings_form`).
- Route **`cesium.settings`** → `/admin/config/services/cesium`
  (`cesium.routing.yml`), permission **`administer site configuration`**.
- Menu link `cesium.admin_settings` under *Configuration → Web services*
  (`system.admin_config_services`), weight 100 (`cesium.links.menu.yml`).
- This is the module's **only** route, and it is state-changing only for a site admin holding
  `administer site configuration`.

## Config object `cesium.settings`

Install defaults (`config/install/cesium.settings.yml`) and schema
(`config/schema/cesium.schema.yml`, type `config_object`):

| Key | Type | Default | Form control | Meaning |
|---|---|---|---|---|
| `variant` | string | `cesium` | select (required) | `cesium` = Production (minified) or `cesium.dev` = Development (unminified). Chooses the `CESIUM_BASE_URL` asset folder. |
| `ion_token` | string | `''` | textfield (maxlength 1024) | Cesium Ion access token; removes the watermark and unlocks Ion imagery/terrain. |
| `enable_terrain` | boolean | `false` | checkbox | Load Cesium World Terrain (`Cesium.Terrain.fromWorldTerrain()`). |
| `enable_buildings` | boolean | `false` | checkbox | Load global OSM 3D Buildings (`Cesium.createOsmBuildingsAsync()`). |

Edit via UI, or:

```bash
drush cset cesium.settings variant cesium -y
drush cset cesium.settings enable_terrain 1 -y
drush cr
```

## How settings reach the browser (`cesium_page_attachments()`)

`cesium.module` implements `hook_page_attachments()` and, **on every page request**, attaches:

```
drupalSettings.cesium = {
  cesiumBaseUrl:   base_path() + 'libraries/cesium/' + (variant=='cesium.dev' ? 'Build/CesiumUnminified/' : 'Build/Cesium/'),
  ionToken:        <ion_token>,
  enableTerrain:   <enable_terrain>,
  enableBuildings: <enable_buildings>,
}
```

`js/cesium_formatter.js` then sets `window.CESIUM_BASE_URL = cesiumBaseUrl` and, if present,
`Cesium.Ion.defaultAccessToken = ionToken`, and honors the terrain/buildings flags when building
each `Cesium.Viewer`.

The `cesiumBaseUrl` value is composed from `base_path()` and one of two **fixed** subfolder strings
selected by `variant`; it is not assembled from any request input. `hook_js_settings_alter()` exists
but is a no-op stub.

## Operating notes

- `variant` only affects `CESIUM_BASE_URL` (where the viewer loads its Web Workers, styles and asset
  files from). The `cesium/cesium.formatter` library always loads the **minified** `Cesium.js`
  (`cesium/cesium`); switching to `cesium.dev` does not by itself swap in the unminified core script.
- World Terrain and OSM Buildings require network access to Cesium's Ion/asset services at runtime and
  generally need a valid `ion_token`.
- The token/flags are emitted globally, so they take effect for any Cesium viewer anywhere on the
  site once configured.
