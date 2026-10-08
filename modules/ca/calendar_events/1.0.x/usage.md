<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar Events

## What it is / when to use

- Renders a visual calendar (based on Nazar Mokrynskyi's PickMeUp) associated with a `content_calendar_events` content type.
- Lets you show 1 to 3 linked calendars and customize their styles.
- Use to surface event content on a page in an interactive month/day calendar widget.

---

## Install & configure

- Depends on core `block` and `path_alias`.
- Enabling installs the `content_calendar_events` content type with start/end date fields.
- Place the Calendar Events block via Block layout to render the calendar.
- Styling is customizable through the module's CSS and block/template overrides.

---

## Usage & API notes

- Provides a Block plugin (`CalendarEventsBlock`) that queries published event nodes and feeds them to the PickMeUp JS.
- The block entity query runs to gather node IDs for the configured event bundle.
- Fields installed: `field_start_date_of_the_event` and `field_end_date_of_the_event`.
- Frontend rendering is handled by the bundled PickMeUp JS/CSS libraries.
- Supports 1-3 calendars for side-by-side or multi-month display.
- Templates under `templates/` allow markup overrides.
- Content is authored as normal nodes of the `content_calendar_events` type.
- Language content settings are shipped for the content type (translatable).
- No custom routes or controllers — display is entirely via the block.
- No anonymous or state-changing endpoints are exposed.
- The calendar links days to their associated event nodes.
- Uses `path_alias` for clean links to event content.
- Restyle by overriding the `calendar_events` CSS library.
- Suited to simple event/calendar showcases rather than booking systems.
- Extend by altering the block plugin or the node query in a custom module.
- Package is the third-party "oscar_drupal"; there is a duplicate `events.info.yml` in the package.
