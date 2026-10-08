<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address for Rep. of Moldova (address_md) — agent index

Adds Moldova's **districts → localities** and a Moldovan address **format** to the Address field,
via one event subscriber that loads subdivisions from **bundled JSON**. Depends on **`address`**
(composer `drupal/address:>=1.0`). Core `^8.8 || ^9 || ^10 || ^11`. PHP `>=7.4`.
GPL-2.0-or-later. Version 1.0.8.

- **The subscriber, the events it handles, the format it sets, and the JSON/caching mechanism** →
  [events/subscriber.md](events/subscriber.md)

## What it actually is

- One service **`address_md_events_subscriber`** (tag `event_subscriber`) →
  `Drupal\address_md\EventSubscriber\AddressEventsSubscriber`, constructed with
  `@extension.path.resolver` and `@cache.data` (`address_md.services.yml`).
- Subscribes to **`AddressEvents::ADDRESS_FORMAT`** (`onAddressFormat`) and
  **`AddressEvents::SUBDIVISIONS`** (`onSubdivisions`); both act **only when country_code == 'MD'**.
- `onAddressFormat`: MD format string, `subdivision_depth = 2`,
  `administrative_area_type = DISTRICT`.
- `onSubdivisions`: computes the Addressing group key (`hash('tiger128,3', …)`), reads the matching
  `json/<group>.json` from the module dir via `file_get_contents`, `json_decode`s it, and caches
  it in `cache.data` (permanent, tag `subdivisions`). `json/MD.json` = districts; per-district
  files = localities.
- `hook_help()` in `address_md.module` (help.page.address_md) — the only hook.

## Key facts

- **No routes, no permissions, no config, no config schema, no Drush.** The only file I/O is
  reading the module's own bundled JSON (no user-supplied path, no network).
- Enabling the module is the whole setup; data appears when a user selects **Moldova**.
- Pure data/format contribution to Address; no attack surface.
