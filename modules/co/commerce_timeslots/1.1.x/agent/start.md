<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Time Slots — agent index

**Delivery/pickup time-slot booking** for Drupal Commerce with per-slot capacity. Version **1.1.x**.
Core `^9 || ^10 || ^11`. Depends on `commerce`, `commerce_shipping`, `jquery_ui_datepicker`, `datetime_range`.

Config entities: timeslot, timeslot_day, day_capacity, booking — all admin-managed under
`/admin/commerce/timeslots` behind granular permissions. Only public route is
`commerce_timeslots.get_availability` (AJAX, `access content`, read-only availability markup — no mutation).
Provides its own permissions.yml. No payment/callback surface.
