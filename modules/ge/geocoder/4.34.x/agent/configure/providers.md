# Settings & providers

## Global settings — `geocoder.settings`
Schema `config/schema/geocoder.schema.yml`. UI at `/admin/config/system/geocoder`
(route `geocoder.settings`, `SettingsForm`, permission `administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cache` | bool | `true` | Cache geocoding results in the `cache.geocoder` bin. |
| `queue` | bool | `false` | Process geocoding via a queue instead of inline. |
| `geocoder_presave_disabled` | bool | `false` | Disable the geocode-on-entity-presave behavior. |

`drush config:get geocoder.settings` / `drush config:set geocoder.settings cache 0 -y`.

## Provider config entities — `geocoder_provider`
Each configured geocoding backend is a `geocoder_provider` config entity, managed at
`/admin/config/system/geocoder/geocoder-provider` (route
`entity.geocoder_provider.collection`). Add/edit/delete forms let you:
- pick a **Provider plugin** (Google Maps, Nominatim, ArcGIS Online, Mapbox, TomTom,
  FreeGeoIp, MaxMind, Yandex, Photon, Pelias, … ~31 bundled plugin definitions), and
- fill its `arguments` (API key, locale, region, base URL, etc. — defined by the plugin's
  annotation `arguments`).

Order matters: when you call `geocode()`/`reverse()` you pass a list of provider entity ids and
they are tried in order. Many providers require installing the matching
`geocoder-php/*-provider` Composer package first (they are `require-dev` in the module and
pulled in per-site as needed).

Rate limiting: a provider plugin annotation may declare a `throttle` (`period` seconds +
`limit`); the `geocoder.throttle` service (stiphle) enforces it.
