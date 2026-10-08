<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Styled Google Map — agent index

Renders a **Geofield** value as a styled Google Map. Two entry points: a field formatter
(`styled_google_map_default`, single entity) and a Views style (`styled_google_map`,
many markers). Requires the `geofield` module. Depends on the Google Maps JS API — set the
API key first. No Drush, no permissions, no config schema.

- **Global Google Maps API key / auth method / extra libraries** (config
  `styled_google_map.settings`, route `styled_google_map.settings`) →
  [configure/settings.md](configure/settings.md)
- **Show one entity's location — the geofield field formatter and its display settings** →
  [configure/field-formatter.md](configure/field-formatter.md)
- **Multi-location map from a View — clustering, spiderfy, heatmap, map center, popups** →
  [configure/views.md](configure/views.md)
- **Alter markers/settings in code before render** (`hook_styled_google_map_views_style_alter`) →
  [hooks/alter.md](hooks/alter.md)
- **Theme hooks / templates** (`styled_google_map`, `styled_google_map_directions`) →
  [theming/templates.md](theming/templates.md)

Key facts: field formatter id `styled_google_map_default` (field type `geofield`); Views
style id `styled_google_map`; Views area handler id `google_map_control`. Global config
object `styled_google_map.settings` keys: `styled_google_map_google_auth_method` (1 = API
Key, 2 = Maps for Work), `styled_google_map_google_apikey`, `styled_google_map_google_client_id`,
`styled_google_map_libraries` (checkboxes: drawing/geometry/localContext/places). No config
schema ships, so those keys are plain scalars/arrays.
