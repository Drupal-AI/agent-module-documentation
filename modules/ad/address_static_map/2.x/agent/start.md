<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Static Map (address_static_map) — agent index

A single **field formatter** that renders a contrib **Address** field value as a **Google Static
Maps** image (`<img src="…maps.googleapis.com/maps/api/staticmap…">`). Package `Fields`. Requires
core **`field`**, contrib **`address`** and **`key`**. Core requirement
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.2.

- **The formatter, its display settings, and how to enable it on a field** →
  [fields/formatter.md](fields/formatter.md)
- **The site-wide credentials settings form + config/schema + URL signing** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `AddressStaticMapFormatter` (id **`address_static_map`**, label *"Address Static
  Map"*), in `src/Plugin/Field/FieldFormatter/AddressStaticMapFormatter.php`, extending core
  `FormatterBase`. `field_types = { "address" }` — targets **contrib Address fields only**.
- No field type, no widget, **no permissions of its own**, no Drush, no hooks, no submodules.
- The map is a plain **`<img>`** built server-side and fetched by the **visitor's browser** — the
  Drupal server never fetches the map (no server-side HTTP, so no SSRF/TLS surface here).

## Provides

- **Formatter plugin** `address_static_map` (Address fields).
- **Two services** (`address_static_map.services.yml`):
  - `address_static_map.map_renderer` → `Service\MapRenderer` — builds the Static Maps URL and the
    `#theme => 'image'` render array (`renderGoogleMapsImage()`).
  - `address_static_map.map_signer` → `Service\MapSigner` — HMAC-SHA1 signs the URL using a **Key**
    entity (`generateSignature()`, args `@key.repository`).
- **Settings route/form** `address_static_map.settings` → `Form\SettingsForm` at
  **`/admin/config/system/address_static_map`**, `_permission: 'administer site configuration'`
  (menu link in `address_static_map.links.menu.yml`, under *Configuration → System*).
- **Config object** `address_static_map.settings` (install defaults + schema in `config/`).

## Data flow (from source)

- `AddressStaticMapFormatter::viewElements()` renders each address via the Address module's
  `address_plain` view, flattens it with `formatPlainAddress()` into a comma-joined string, merges
  the site-wide credential config into the per-display `$settings`, resolves the marker
  `icon_url`, and calls `MapRenderer::renderGoogleMapsImage($address, $settings)`.
- `MapRenderer::renderGoogleMapsImage()` assembles the query (`center`, `zoom`, `size`, `scale`,
  `maptype`, `markers`, and `key` **or** `client`) with `Url::fromUri(...)` (query params are
  URL-encoded), appends the admin `additional` string, then `MapSigner::generateSignature()` HMACs
  the URL path+query with the Key value and appends `&signature=…`. Returns
  `['#theme' => 'image', '#uri' => <url>, '#alt' => <address>]` (attribute-escaped by core).

## Credentials (site-wide, `config/settings.md`)

Standard mode: `api_key` (plain string in config) + `secret_key_id` (a **Key** entity id) for URL
signing. Premier mode (`premier` = 1): `premium_client_id` (plain string) + `premium_crypto_key_id`
(a **Key** entity id). Optional `icon_url` for a custom marker. The signing secret / crypto key
live in Key entities, never in the map URL — only the derived signature is sent.
