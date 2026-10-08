<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address DE (address_de) — agent index

**Adds Germany's 16 federal states (Bundesländer) as administrative-area subdivisions and appends a state line to the Address module's `DE` address format, via one event subscriber.**

- **Version:** 1.2.x (`version: 1.2.1` in the info file)
- **Core:** `^9.2 || ^10 || ^11`; PHP `^8.0 || ^8.1 || ^8.2 || ^8.3`
- **Dependency:** `address:address` (Address module `^1.7 || ^2.0`); pulls in the CommerceGuys addressing library.
- **Provides:** one service, `address_de_events_subscriber` → `Drupal\address_de\EventSubscriber\AddressEventsSubscriber` (tagged `event_subscriber`).
- **No** routes, controllers, permissions, forms, config objects, config schema, install/update hooks, hook_menu, or Drush commands. Enabling the module is the whole setup.

## What the subscriber does

`AddressEventsSubscriber` (`src/EventSubscriber/AddressEventsSubscriber.php`) subscribes to two Address events:

- `AddressEvents::ADDRESS_FORMAT` → `onAddressFormat()` — when the definition's `country_code == 'DE'`, appends `"\n%administrativeArea"` to `format`, sets `administrative_area_type` to `AdministrativeAreaType::STATE`, and `subdivision_depth` to `1`.
- `AddressEvents::SUBDIVISIONS` → `onSubdivisions()` — returns early unless `getParents() == ['DE']`; otherwise returns the fixed 16-state list (`BW`, `BY`, `BE`, `BB`, `HB`, `HH`, `HE`, `MV`, `NI`, `NW`, `RP`, `SL`, `SN`, `ST`, `SH`, `TH`) each with a `name` and `iso_code` (e.g. `DE-BW`).

All state data is static and hardcoded; there is no user input, remote call, or storage.

## Solution docs

- [agent/api/subdivisions.md](api/subdivisions.md) — the event subscriber, the events it hooks, the emitted definitions, and how to verify/extend the same pattern for other countries.
