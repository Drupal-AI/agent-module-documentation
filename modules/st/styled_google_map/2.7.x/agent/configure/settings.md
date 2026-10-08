<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings — Google Maps API key

Form: `\Drupal\styled_google_map\Form\StyledGoogleMapSettingsForm`
Route: `styled_google_map.settings` → path `/admin/config/services/styled_google_map`
(permission `administer site configuration`). Config object: **`styled_google_map.settings`**.
There is **no config schema file**, so keys are stored as plain scalars/arrays.

## Config keys

| Key | Type | Meaning |
|---|---|---|
| `styled_google_map_google_auth_method` | int | `1` = API Key, `2` = Google Maps API for Work. Constants `StyledGoogleMapInterface::STYLED_GOOGLE_MAP_GOOGLE_AUTH_KEY` / `..._WORK`. |
| `styled_google_map_google_apikey` | string | Google Maps JavaScript API key (used when auth method = 1). |
| `styled_google_map_google_client_id` | string | Maps-for-Work Client ID (used when auth method = 2). |
| `styled_google_map_libraries` | array | Checkbox map of extra Google libraries to load: `drawing`, `geometry`, `localContext`, `places` (each value = key or `0`). The `visualization` library is always loaded (needed for heatmaps). |

The key is injected into the Google Maps API `<script>` URL by
`styled_google_map_build_api_url()` (called from `hook_library_info_alter`), so **changing
the key clears library discovery caches** — the submit handler already calls
`library.discovery->clearCachedDefinitions()`. Run `drush cr` if a map still loads the old URL.

## Set it with drush

```bash
drush config:set styled_google_map.settings styled_google_map_google_auth_method 1 -y
drush config:set styled_google_map.settings styled_google_map_google_apikey 'YOUR_KEY' -y
drush cr
```

Read it back: `drush config:get styled_google_map.settings`.

Without a valid key the Google map renders grey — this is the #1 troubleshooting cause.
The key is a public browser key; scope it by HTTP referrer in the Google Cloud console.
