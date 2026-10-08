<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# calendar_events — agent orientation

- Block-driven calendar display (PickMeUp JS) tied to a `content_calendar_events` node type with start/end date fields.
- Dependencies: block, path_alias. Package "oscar_drupal".
- Key code: `src/Plugin/Block/CalendarEventsBlock.php` runs a node entity query and renders via bundled JS/CSS.
- No routes/controllers/permissions; nothing security-sensitive. Display-only.
- Config install ships the content type, fields, view/form displays, and language settings.
