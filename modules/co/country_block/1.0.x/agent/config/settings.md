<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Country Block — configuration & enforcement

## Install / enable

- Requires the **Smart IP** module (`drupal/smart_ip:^5.0`) and a working Smart IP data source
  (e.g. a GeoIP database) so it can resolve a visitor's `countryCode`. Without a source, country
  resolution returns NULL and no one is blocked.
- Enable: `drush en country_block -y` (pulls in `smart_ip`). Core `^10 || ^11`.
- Grant the **`administer country block`** permission to trusted roles at
  `/admin/people/permissions`.

## Config object

`country_block.settings` (install defaults in `config/install/country_block.settings.yml`):

- `blocked_countries` — array of two-letter ISO 3166-1 alpha-2 codes. Default `[]` (block
  nothing).
- `message` — string shown to blocked visitors. Default `'Access from your country is not
  permitted.'`

No `config/schema/` file ships with the module (`provides_config_schema` = false).

## Settings form

- Class `Drupal\country_block\Form\SettingsForm` (extends `ConfigFormBase`, form id
  `country_block_settings`, editable config `country_block.settings`).
- Route `country_block.settings` → path **`/admin/config/people/country-block`**, permission
  **`administer country block`** (`country_block.routing.yml`). Menu link under the *People* admin
  index (`user.admin_index`).
- `buildForm()`: a `blocked_countries` **textarea** (one code per line; description links to the
  Wikipedia ISO 3166-1 alpha-2 list) and a **required** `message` textfield.
- `submitForm()`:
  `array_filter(array_map('trim', explode("\n", ...)))` then
  `array_values(array_unique(...))` — trims each line, removes blanks, de-duplicates — and saves
  both values. Standard `ConfigFormBase` CSRF protection applies.

## Enforcement (runtime)

- Service `country_block.event_subscriber` = `CountryBlockSubscriber`
  (`src/EventSubscriber/CountryBlockSubscriber.php`), tagged `event_subscriber` **priority 10**,
  constructor args `@current_user`, `@config.factory`, `@smart_ip.smart_ip_location`.
- Subscribes to `KernelEvents::REQUEST` → `checkCountryBlock()`. Logic:
  1. Skip if not `isMainRequest()`.
  2. Skip if current user has `administer site configuration` (admins are exempt — prevents
     lockout).
  3. Load `blocked_countries`; if empty, return.
  4. `$countryCode = $this->locationService->get('countryCode')` (Smart IP).
  5. If `$countryCode !== NULL` and it is in the blocklist (strict `in_array` compare) →
     `throw new AccessDeniedHttpException($message)` (message defaults to the config string).

## Operating notes

- Codes are compared **case-sensitively and exactly** to Smart IP's returned code (uppercase),
  so enter uppercase codes (e.g. `RU`, `CN`).
- To disable blocking without uninstalling, clear the `blocked_countries` textarea and save.
- Country resolution, and any reverse-proxy / trusted-IP handling, is owned by **Smart IP** — this
  module reads only the resolved `countryCode`. Configure Drupal/Smart IP trusted proxies if the
  site sits behind a proxy or CDN so the resolved IP is the real client.
- This is a **site-wide, coarse** gate (every path, no per-content granularity) and is bypassable
  via VPN/proxy; combine it with real access controls for anything sensitive.
