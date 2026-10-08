<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service Availability (service_availability) — agent index

**Renders current status and upcoming scheduled disruptions for services via a block, from two content types.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Dependencies:** block, datetime_range.
- **Provides:** content types `service` and `service_message` (installed config), block plugin `service_availability_services`, `DateConversion` utility.
- **No custom routes or permissions.** Behaviour is content + block placement.
- **Security:** block queries only published nodes (`status = 1`) with `accessCheck(TRUE)`, so node access is enforced and unpublished content is not leaked. `blockAccess()` returns allowed (intended public status display); control exposure via publish state and block placement. No anonymous mutation, no external calls, no secrets.

See [configure/block.md](configure/block.md)
