<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Read Time adds an estimated "reading time" display to nodes, computed from the node's text (and referenced Paragraphs/blocks) and a configurable words-per-minute rate.

---

The module exposes reading time three ways, all driven by one config object,
`node_read_time.settings`. On the settings page at `/admin/config/reading-time` (route
`system.admin_config_reading_time`) you tick which content types it applies to
(`reading_time.container.<type>.is_activated`), set the `words_per_minute` rate (default
225 when empty), and choose a `unit_of_time` format. For each activated type the module
registers an **extra field** named `reading_time` via `hook_entity_extra_field_info()`; you
position it on the node's *Manage display* and it renders through the `reading_time` theme
hook (`templates/reading-time.html.twig`, output `{{ reading_time }}`). The
`ReadingTime` service (`node_read_time.reading_time`) collects words from `text`,
`text_long`, `text_with_summary`, `string_long`, and `entity_reference_revisions`
(Paragraphs) fields, strips scripts/iframes and tags, counts words, and formats the result
per `unit_of_time`: `minute` (e.g. "3 minutes"), `second` ("2 minutes, 30 seconds"), `below`
(minute+second but "1 minute" when under one WPM's worth), or `default` (a bare rounded-up
number). The module also adds a **computed base field** `node_read_time` on nodes and a
**Views field** ("Node read time") so the value can be shown in views or read programmatically.
There is no permission, no Drush, and no plugin type; a Twig template makes the markup themeable.

---

- Show an estimated reading time on blog posts ("5 minutes").
- Enable reading time only for specific content types (e.g. Article but not Page).
- Set a custom words-per-minute rate to match your audience's reading speed.
- Display reading time as whole minutes only.
- Display reading time as minutes and seconds ("2 minutes, 30 seconds").
- Use the "below" unit so short posts always show at least "1 minute".
- Position the reading-time field anywhere on the node via Manage display.
- Render reading time in a custom Twig template with `{{ content.reading_time }}`.
- Include Paragraphs/entity-reference-revisions text in the word count.
- Include long text, formatted text, and summary fields in the calculation.
- Exclude scripts and iframes from the word count automatically.
- Add a "Node read time" column to a view of articles.
- Read the computed reading time programmatically via the node's `node_read_time` base field.
- Give readers an at-a-glance sense of article length.
- Keep reading time in sync automatically as content changes (it is computed, not stored).
- Override the reading-time markup/label by overriding the `reading_time` template.
- Apply a site-wide default 225 WPM without configuring anything when words-per-minute is unset.
- Show reading time on news/press content types for editorial planning.
- Combine reading time with other extra fields in a teaser display.
- Provide a lightweight reading-time feature without a third-party JS library.
