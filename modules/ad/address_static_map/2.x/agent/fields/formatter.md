<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Address Static Map" field formatter

## Install & enable

```bash
composer require drupal/address_static_map
drush en address_static_map -y
```

Pulls in dependencies **`address`** (contrib) and **`key`** (contrib); also needs core **`field`**.
No submodules, no permissions of its own, no Drush commands. Configure the Google credentials once
site-wide (see [../config/settings.md](../config/settings.md)) before the map will load.

## Enable it on a field

Plugin id **`address_static_map`**, label *"Address Static Map"*, in
`src/Plugin/Field/FieldFormatter/AddressStaticMapFormatter.php` (`@FieldFormatter`,
`field_types = { "address" }`). It applies **only to contrib Address fields** — not to Geofield,
plain text, or link fields.

UI path: *Structure → (entity type) → (bundle) → Manage display* → set the Address field's format
to **Address Static Map** → click the gear to set the options below.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.place.default \
  content.field_address.type address_static_map -y
drush cr
```

## Formatter settings

From `defaultSettings()` / `settingsForm()`:

| Setting key | Default | Meaning |
|---|---|---|
| `zoom_level` | `auto` | Google zoom. `auto` (Google auto-frames) or `0`–`21`. When `auto`, the `zoom` query param is **omitted** so Google fits the marker. |
| `map_size` | `400x400` | `WIDTHxHEIGHT` for the `size` query param. Free-text field. |
| `map_style` | `roadmap` | `maptype`: `roadmap`, `satellite`, `terrain`, `hybrid`. |
| `scale` | `1` | Retina `scale` param: `1`, `2` or `4` (4 needs a Google premium subscription). |
| `additional` | `''` | Free-form string appended raw to the URL as `&<additional>` (e.g. Static Maps `style=` / `format=` parameters). **Admin-entered.** |

`settingsSummary()` lists zoom, size, additional (if set), scale and map style on the Manage-display
summary line. Config schema for these lives in
`config/schema/address_static_map.schema.yml` (`field.formatter.settings.address_static_map`).

### Example view-display config

```yaml
# core.entity_view_display.node.place.default
content:
  field_address:
    type: address_static_map
    label: above
    settings:
      zoom_level: '14'
      map_size: '600x300'
      additional: ''
      map_style: roadmap
      scale: 2
```

## How an address becomes a map (from source)

`viewElements()` loops the field items. For each:

1. `$item->view(['type' => 'address_plain'])` renders the address with the Address module's plain
   formatter, then `formatPlainAddress()` flattens that render array into a single
   comma-separated string (`address_line1, address_line2, locality, admin-area postal-code,
   country`). It handles both Address 1.x (string `#locality`) and 2.0.x (array with
   `code`/`name`) shapes.
2. The per-display `$settings` are merged with the **site-wide** credential config
   (`address_static_map.settings`): `premier`, then either `client_id`+`crypto_key_id` (premier) or
   `api_key`+`secret_key_id` (standard), plus `icon_url`. An empty `icon_url` becomes the literal
   marker style `color:green`; otherwise `icon:` + `Url::fromUri($icon_url)->toString()`.
3. `MapRenderer::renderGoogleMapsImage($address, $settings)` (service
   `address_static_map.map_renderer`) builds the query with
   `Url::fromUri('https://maps.googleapis.com/maps/api/staticmap', ['query' => …])` — so `center`,
   `markers` (icon + address) and the other params are **URL-encoded**. It drops `zoom` when it is
   `auto`, adds `key=` (standard) or `client=` (premier), appends `&<additional>`, then signs.

The return is a render array `['#theme' => 'image', '#uri' => $url, '#alt' => $address]`. Core's
image theming places `#uri` in `src` and `#alt` in `alt`, both **attribute-escaped**; the address
is URL-encoded inside the query. The image is loaded by the **browser** from Google — Drupal makes
**no server-side HTTP request** for it.

## URL signing

`MapRenderer` strips the `https://maps.googleapis.com` host to get the path+query, then calls
`MapSigner::generateSignature($key_id, $url)` (service `address_static_map.map_signer`, in
`src/Service/MapSigner.php`). Given a **Key** entity id it loads the key via `@key.repository`,
`base64_decode`s the URL-safe secret, and computes `hash_hmac('sha1', $data, $secret, TRUE)`,
returning the URL-safe base64 signature appended as `&signature=…`. Standard mode uses
`secret_key_id`; premier mode uses `crypto_key_id`. If the key id is empty or missing it returns
`''` (an unsigned URL — Google may then reject the request depending on account settings).

## Notes

- The map only appears once the site-wide credentials are configured; without a valid API key /
  signature Google returns an error image.
- `additional` is appended before signing, so admin-supplied extra params are covered by the
  signature.
- `map_size` and `additional` are free-text with no server-side validation — a malformed value just
  yields a broken Google request, not a Drupal error.
