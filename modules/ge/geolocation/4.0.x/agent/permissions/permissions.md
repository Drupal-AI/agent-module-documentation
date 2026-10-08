# Geolocation permissions

From `geolocation.permissions.yml`:

| Permission | Gates |
|---|---|
| `configure geolocation` | Configure Geolocation settings. |

Provider submodules add their own settings pages (e.g. `geolocation_google_maps.settings` for
the Google Maps API key) which are gated by core's `administer site configuration` unless noted
otherwise. Viewing maps on rendered content requires no special permission beyond access to the
content itself.
