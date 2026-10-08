<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FullCalendar Block provides a configurable "FullCalendar block" that renders a calendar (powered by FullCalendar 5) from a JSON event-feed URL — typically a Drupal View REST export or a custom controller.

---

The module defines a single block plugin, `fullcalendar_block` (category "Calendar"), that you place through the normal Block layout. Its per-instance settings are stored in the block config entity (`block.block.<id>` under `settings`) with schema `block.settings.fullcalendar_block`: the mandatory `event_source` (JSON feed URL, relative or absolute), `initial_view` (default `dayGridMonth`), the three header-toolbar strings (`header_start`/`header_center`/`header_end`), click behaviour (`open_dialog` = 0 new tab / 1 dialog / 2 current tab, `dialog_width`), `use_token` (enable token replacement in the event URL), a `plugins` list (enable `moment` and/or `rrule`), and two free-form YAML/JSON blobs — `advanced` (any FullCalendar option, e.g. `initialDate`) and `advanced_drupal` (dialog/description-popup/draggable/resizable/event-background behaviour). At build time it assembles the FullCalendar options (pulling `firstDay`, direction and locale from Drupal), attaches the FullCalendar library (loaded locally from `/libraries/...` or falling back to a CDN), conditionally adds moment/rrule/DOMPurify and jQuery UI draggable/resizable, and passes everything to the browser via `drupalSettings`. It fires JS events `fullcalendar_block.beforebuild` / `fullcalendar_block.build` and exposes a PHP alter hook, `hook_fullcalendar_block_settings_alter()`, to modify block settings/calendar options. It has no configure route of its own (place the block instead), no permissions, no Drush, and no plugin types.

---

- Show a month-grid calendar of events on a page by placing the FullCalendar block and pointing it at a JSON feed.
- Feed the calendar from a Drupal View "REST export" using a relative URL like `/event-feed`.
- Feed the calendar from a custom controller or an external event API (absolute URL).
- Switch the default view to week or day via `initial_view` (e.g. `timeGridWeek`, `timeGridDay`, `listMonth`).
- Customise the header toolbar (prev/next/today, title, view switcher) with the header settings.
- Open an event in a modal dialog, a new tab, or the current tab (`open_dialog` 1/0/2) and size the dialog.
- Load events lazily via AJAX by exposing start/end view filters on the source View.
- Enable recurring events by turning on the `rrule` FullCalendar plugin.
- Support extra locales / date handling by turning on the `moment` plugin.
- Insert tokens into the event-source URL (e.g. current node id) with `use_token`.
- Set an initial date with advanced YAML: `initialDate: '2022-05-01'`.
- Color-code events by content type/field via `advanced_drupal.event_background`.
- Show an event description in a popup dialog (`description_popup` + `description_field`, sanitized by DOMPurify).
- Make dialog events draggable/resizable via jQuery UI integration in `advanced_drupal`.
- Place several independent calendars on one page (each block gets a unique index).
- Alter a specific block's calendar options from another module with `hook_fullcalendar_block_settings_alter()`.
- React in JS to `fullcalendar_block.build` to post-process the FullCalendar instance.
- Serve required JS libraries from a CDN automatically when not installed locally.
- Export a configured calendar block as config (`block.block.<id>`) for deployment across environments.
- Build an events landing page or an "upcoming events" calendar for a community or campus site.
- Provide a booking/schedule overview by feeding a calendar from availability data.
