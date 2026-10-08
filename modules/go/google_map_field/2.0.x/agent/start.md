# Google Map Field — agent index

Defines the **`google_map_field`** field type (an interactive Google/OpenLayers map stored per
entity), plus its widgets and formatters, and a global Google Maps API-key settings form. No
plugin manager of its own, no Drush, no permissions beyond core's `administer site configuration`.

- **Configure the global API key + attach a map field (widgets/formatters, config keys, route)** →
  [configure/settings.md](configure/settings.md)
- **Field storage columns and setting map values in code / via config** →
  [api/field-data.md](api/field-data.md)

Key facts:
- Global config object `google_map_field.settings`; keys `google_map_field_auth_method` (1 = API
  Key, 2 = API for Work), `google_map_field_apikey`, `google_map_field_map_client_id`. Form route
  `gmap.field.settings` at `/admin/config/services/gmap-field-settings`.
- Field type id `google_map_field`. Widgets: `google_map_field_default`, `olmap_field`.
  Formatters: `google_map_field_default`, `google_map_field_embed`, `google_map_field_open_layers`.
- OpenLayers widget/formatter work without a Google API key; Google ones need a valid key.
