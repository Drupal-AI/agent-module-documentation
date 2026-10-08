<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEE: Bookable Entities Everywhere (bee) — agent index

Makes content types **bookable** via the **BAT** toolkit, with optional **Commerce** checkout.
Version **11.1.0-rc3**. Core `^10.2 || ^11`. Depends on the BAT booking/event stack,
`office_hours`, and `commerce_order`/`commerce_product`/`commerce_store`. Submodule `bee_webform`.

Substantial adoption — the centre of a booking system, not a small add-on. Daily/hourly
availability; a booking can become a paid Commerce order.

Permissions incl. `create bee reservation`, `administer bee settings`, and calendar-view perms —
set who may book and who sees availability. Configure Commerce for paid bookings.