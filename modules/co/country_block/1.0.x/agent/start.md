<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Country Block (country_block) — agent index

Denies all site access to visitors whose **GeoIP country** (resolved by **Smart IP**) is on an
admin blocklist, throwing `AccessDeniedHttpException` with a configurable message. Package
`Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.4. Depends on **`smart_ip`**
(`^5.0`).

- **The settings form, config object, permission, route and the enforcement subscriber** →
  [config/settings.md](config/settings.md)

## What it actually is

- One event subscriber: `CountryBlockSubscriber` (`src/EventSubscriber/CountryBlockSubscriber.php`,
  `final readonly`), registered as `country_block.event_subscriber` on `KernelEvents::REQUEST`
  with **priority 10** (`country_block.services.yml`). Injected: `@current_user`,
  `@config.factory`, `@smart_ip.smart_ip_location`.
- One config form: `SettingsForm` (`src/Form/SettingsForm.php`, extends `ConfigFormBase`,
  form id `country_block_settings`) at route **`country_block.settings`**
  (`/admin/config/people/country-block`), permission **`administer country block`**.
- One permission (`country_block.permissions.yml`): `administer country block`. One menu link
  (`country_block.links.menu.yml`) under `user.admin_index`. One config object
  `country_block.settings` (install default in `config/install/`: `blocked_countries: []`,
  `message: 'Access from your country is not permitted.'`).
- **No** Drush, **no** plugin types, **no** config schema file shipped, **no** entities, **no**
  per-content access hook — it is a global request gate only.

## Mechanism (from source)

- `checkCountryBlock()` returns early if not the main request, or if the current user has
  `administer site configuration` (admins are never blocked). It loads `blocked_countries` from
  `country_block.settings`; empty list → no-op. It reads `countryCode` from the Smart IP location
  service and, when it is non-NULL and `in_array($countryCode, $blockedCountries, TRUE)`, throws
  `AccessDeniedHttpException($message)`.
- The client-IP → country resolution is entirely **Smart IP's** responsibility; this module never
  parses request headers itself. Accuracy and proxy/trusted-IP handling are inherited from Smart
  IP and its configured data source.
- `SettingsForm::submitForm()` trims each line, drops empties, de-duplicates, and stores the
  codes plus the message. Codes are matched exactly and case-sensitively against Smart IP's
  country code (upstream Smart IP returns uppercase ISO 3166-1 alpha-2).

## Caveats

- **Coarse gate, not a strong boundary.** GeoIP is approximate and a client IP can be changed via
  VPN/proxy, so a determined visitor can bypass it. Use for compliance/UX, not as the only control
  on sensitive content.
- Requires Smart IP to be installed and to have a working location data source; with no source,
  `countryCode` may be NULL and nothing is blocked.
- The gate applies site-wide to every path; there is no per-route or per-content granularity.
