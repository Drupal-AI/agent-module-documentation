<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & providers

## Global settings — `geocoder.settings`
Schema `config/schema/geocoder.schema.yml`. UI at `/admin/config/system/geocoder`
(route `geocoder.settings`, `Form\SettingsForm`, permission `administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cache` | bool | `true` | Cache geocoding results in the `cache.geocoder` bin. |
| `queue` | bool | `false` | Process geocoding via a queue instead of inline. |
| `geocoder_presave_disabled` | bool | `false` | Disable the geocode-on-entity-presave behavior globally (useful during content migration). |
| `geocode_country_only_address` | bool | `true` | When an address carries only a country (no street/locality), geocode it to the country name. Disable to treat such a value as empty, so no country-centroid result is produced (e.g. for optional address fields with a pre-selected country). Added in the 4.37.x branch. |

`drush config:get geocoder.settings` / `drush config:set geocoder.settings cache 0 -y`.

![Geocoder settings form](../../../../../../../screenshots/geocoder/4.37.x/settings-form.png)

## Provider config entities — `geocoder_provider`
Each configured geocoding backend is a `geocoder_provider` config entity, managed at
`/admin/config/system/geocoder/geocoder-provider` (route
`entity.geocoder_provider.collection`, `GeocoderProviderListBuilder`). Add/edit/delete forms
(`Form\GeocoderProviderAddForm` / `GeocoderProviderEditForm`, both gated by
`administer site configuration`) let you:
- pick a **Provider plugin** (Google Maps, Nominatim, ArcGIS Online, Mapbox, TomTom,
  FreeGeoIp, MaxMind, Yandex, Photon, Pelias, Azure Maps, OpenCage, … 31 bundled plugin
  definitions), and
- fill its `configuration` (API key, locale, region, base URL, etc. — defined by the plugin's
  annotation `arguments` and validated by the per-plugin schema
  `geocoder_provider.configuration.<plugin_id>`).

![Geocoder providers collection](../../../../../../../screenshots/geocoder/4.37.x/providers-collection.png)

An entity stores `id`, `label`, `plugin`, and `configuration` (`config_export` keys, see
`geocoder.install` `geocoder_update_8301`). Provider credentials such as `apiKey` /
`accessToken` / `subscriptionKey` / `privateKey` live inside `configuration` as plain config
values, so they travel with a config export — treat exports as sensitive and keep them out of
public repositories. Google Maps' own field help notes the key is used for server-side calls and
is not exposed in the browser.

![Add a Geocoder provider](../../../../../../../screenshots/geocoder/4.37.x/provider-add.png)

Order matters: when you call `geocode()`/`reverse()` you pass a list of provider entity ids and
they are tried in order. Many providers require installing the matching
`geocoder-php/*-provider` Composer package first (they are `require-dev` in the module and
pulled in per-site as needed); the `geocoder_geocoder_provider_info_alter()` hook
(`geocoder.module`) filters out plugin definitions whose handler class is not installed.

Rate limiting: a provider plugin annotation may declare a `throttle` (`period` seconds +
`limit`); the `geocoder.throttle` service (`GeocoderThrottle`, stiphle `LeakyBucket`,
per-process storage) enforces it. Nominatim ships a default throttle of 1 request / 2 seconds.
