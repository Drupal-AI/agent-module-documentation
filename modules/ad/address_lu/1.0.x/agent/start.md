<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address for Luxembourg (address_lu) — agent index

Adds Luxembourg's **12 cantons → localities** and a Luxembourg address **format** to the Address
field, via one event subscriber. Depends on **`address`** (composer `drupal/address:^1.7 || ^2.0`).
Core `^9 || ^10 || ^11`. PHP `^7.3 || ^8.x`. GPL-2.0-or-later. Version 1.0.4.

- **The subscriber, the events it handles, the format it sets, and the canton/locality data
  shape** → [events/subscriber.md](events/subscriber.md)

## What it actually is

- One service **`address_lu_events_subscriber`** (tag `event_subscriber`) →
  `Drupal\address_lu\EventSubscriber\AddressEventsSubscriber` (`address_lu.services.yml`).
- Subscribes to **`AddressEvents::ADDRESS_FORMAT`** (`onAddressFormat`) and
  **`AddressEvents::SUBDIVISIONS`** (`onSubdivisions`); both act **only when country_code == 'LU'**.
- `onAddressFormat`: LU format string, `subdivision_depth = 2`, adds `ADMINISTRATIVE_AREA` +
  `LOCALITY` to `required_fields`, `administrative_area_type = CANTON`.
- `onSubdivisions`: **inline PHP arrays** — the 12 cantons (`LU-CA`, `LU-CL`, …), then each
  canton's localities — keyed by `$parents` (`['LU']` or `['LU', <canton>]`).
- `hook_help()` in `address_lu.module` (help.page.address_lu) — the only hook.

## Key facts

- **No routes, no permissions, no config, no config schema, no Drush, no external/network calls.**
- All data is compiled into the subscriber class; enabling the module is the whole setup.
- Pure data/format contribution to Address; no attack surface.
