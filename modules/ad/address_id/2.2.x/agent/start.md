<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Indonesia (address_id) — agent index

Adds Indonesian **provinces → regencies/cities → districts** and a matching 3-level address
**format** to the Address field, via one event subscriber. Package `Custom`. Depends on
**`address`** (composer `drupal/address:^2.0`). Core `^9.1 || ^10 || ^11`. GPL-2.0-or-later.
Version 2.2.0.

- **The subscriber, the events it handles, the format it sets, and how the subdivision data is
  shaped** → [events/subscriber.md](events/subscriber.md)

## What it actually is

- One service **`address_id.indonesia_subscriber`** (tag `event_subscriber`) →
  `Drupal\address_id\EventSubscriber\IndonesiaEventSubscriber` (`address_id.services.yml`).
- Subscribes to **`AddressEvents::ADDRESS_FORMAT`** (`onAddressFormat`) and
  **`AddressEvents::SUBDIVISIONS`** (`onSubdivisions`); both act **only when country_code == 'ID'**.
- `onAddressFormat`: `subdivision_depth = 3`, a custom format string, and adds `locality` +
  `dependentLocality` to `required_fields`.
- `onSubdivisions`: returns large **inline PHP arrays** — provinces (ISO codes `ID-BA`, `ID-JK`, …),
  then regencies/cities, then districts — keyed by the `$parents` path (`['ID']`,
  `['ID', <province>]`, `['ID', <province>, <regency>]`).

## Key facts

- **No routes, no permissions, no config, no config schema, no Drush, no external/network calls.**
- All subdivision data is compiled into the subscriber class; nothing to configure — enabling the
  module is the whole setup.
- Pure data/format contribution to Address; no attack surface.
