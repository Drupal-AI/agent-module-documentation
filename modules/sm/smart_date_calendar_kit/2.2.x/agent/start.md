<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Date Calendar Kit (smart_date_calendar_kit) — agent index

A **configuration kit** (no PHP): on install it imports one view, **`events_calendar`**, that
renders the `event` nodes from [Smart Date Starter Kit](../../../smart_date_starter_kit/2.3.x/agent/start.md)
on a FullCalendar month/week/day/list calendar at **`/events/calendar`**. It adds no runtime
code and can be uninstalled without losing the imported view. Core `^10 || ^11`.

Dependencies: [`smart_date`](../../../smart_date/4.3.x/agent/start.md) (the `field_when` date
field + `smartdate_default` formatter), [`smart_date_starter_kit`](../../../smart_date_starter_kit/2.3.x/agent/start.md)
(the `event` node type + `field_when`), [`fullcalendar`](../../../../fu/fullcalendar/3.0.x/agent/start.md)
(the `fullcalendar` Views style plugin), [`add_content_by_bundle`](../../../../ad/add_content_by_bundle/2.0.x/agent/start.md)
(the "Add an Event" header button), plus core `node`, `user`. No settings page (`configure`
null), no permissions, no Drush, no services, no plugins, no config schema of its own.

- **The Events Calendar view — displays, path/menu tab, FullCalendar style options, drag-and-drop,
  colours, popups, recurring events** → [views/events_calendar.md](views/events_calendar.md)

Key facts:
- View id `events_calendar` (`views.view.events_calendar`, from `config/install/`), base table
  `node_field_data`. Master "Events Calendar" + a `page_1` page at path **`events/calendar`**,
  registered as a menu **tab** (title "Calendar", `main` menu) alongside the Starter Kit's
  Upcoming/Past tabs.
- Style plugin `fullcalendar`; date source `date_field: field_when`; views enabled
  month/week/day/list (`initialView: dayGridMonth`, `firstDay: 0`). Default event colour `#3788d8`.
- Filters `status = 1` (published) and `type = event`; access `perm` → **`access content`**.
- `add_content_by_bundle` header ("Add an Event", `bundle: event`) renders a node-add button.
- Config deps: `field.storage.node.field_when`, `node.type.event` (both installed by Starter Kit).
- Enable recurring events by enabling `smart_date_recur` and editing `node.event.field_when` at
  `admin/structure/types/manage/event/fields/node.event.field_when`.
