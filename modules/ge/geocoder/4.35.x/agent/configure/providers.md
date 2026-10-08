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
  FreeGeoIp, MaxMind, Yandex, Photon, Pelias, Azure Maps, OpenCage, … 31 bundled plugin
  definitions), and
- fill its `configuration` (API key, locale, region, base URL, etc. — defined by the plugin's
  annotation `arguments` and validated by the per-plugin schema
  `geocoder_provider.configuration.<plugin_id>`).

An entity stores `id`, `label`, `plugin`, and `configuration` (config_export keys). Provider
credentials such as `apiKey` / `accessToken` live inside `configuration` as plain config values,
so they travel with a config export — treat exports as sensitive and keep them out of public
repositories. Google Maps' own field help notes the key is used for server-side calls and is not
exposed in the browser.

Order matters: when you call `geocode()`/`reverse()` you pass a list of provider entity ids and
they are tried in order. Many providers require installing the matching
`geocoder-php/*-provider` Composer package first (they are `require-dev` in the module and
pulled in per-site as needed); the `geocoder_geocoder_provider_info_alter()` hook filters out
plugin definitions whose handler class is not installed.

Rate limiting: a provider plugin annotation may declare a `throttle` (`period` seconds +
`limit`); the `geocoder.throttle` service (stiphle `LeakyBucket`, per-process storage) enforces
it. Nominatim ships a default throttle of 1 request / 2 seconds.
