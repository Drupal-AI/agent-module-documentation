<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Date Starter Kit (smart_date_starter_kit) — agent index

A **configuration kit** (no PHP): on install it imports an **Event** node type with a
Smart Date `field_when` field, form/view displays, and an **Events** view with Upcoming/Past
tabs. Meant to bootstrap a site's use of [Smart Date](../../../smart_date/4.3.x/agent/start.md);
once installed it adds no runtime code and can be uninstalled (deleting the Event type + view
first). Core `^9 || ^10 || ^11`.

Dependencies: `smart_date`, `add_content_by_bundle` (the view's "Add an Event" header button),
plus core `node`, `menu_ui`, `user`. No settings page (`configure` null), no permissions, no
Drush, no services, no plugins, no config schema of its own.

- **The Event content type, the `field_when` Smart Date field, form/view displays, recurring
  events, adding fields** → [configure/event-content-type.md](configure/event-content-type.md)
- **The Events view (Upcoming/Past pages, block, filters, tabs)** → [views/events.md](views/events.md)

Key facts:
- Node type `event` (`node.type.event`), unlimited-cardinality Smart Date field `field_when`
  (`field.storage.node.field_when`, type `smartdate`) + a `body` field.
- Form widget `smartdate_inline`; display formatter `smartdate_default`. View mode `teaser`.
- View id `events`: displays `page_1` at `events/upcoming` (default tab "Upcoming"), `page_2` at
  `events/past` (tab "Past"), `block_1`, and master "Upcoming Events". Upcoming vs. past is split
  on `field_when_end_value` `>`/`<=` `now`.
- Optional config (installed only if the module is present): `pathauto.pattern.events`
  (`/events/[node:title]`).
- Pairs with `smart_date_calendar_kit` for a calendar display, and `smart_date_recur` to enable
  recurring events on `field_when`.
