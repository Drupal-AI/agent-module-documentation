<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Estimated Read Time adds a `estimated_read_time` field type that automatically computes and stores an entity's reading time (minutes + seconds) on save, with a widget for manual override and a formatter that renders a tokenized string like "5 min read".

---

The module ships a field type, widget, and formatter plus one service. The **field type**
(`estimated_read_time`) stores three columns — `auto` (bool), `minutes`, `seconds` — and has
two settings: `view_mode` (which view mode to render for the calculation) and
`words_per_minute` (default 230). On `hook_entity_presave`, the
`estimated_read_time.entity_read_time_estimator` service finds any `estimated_read_time`
field whose `auto` is not 0, renders the entity in the configured view mode **using the
site's default (front-end) theme** (`renderInIsolation`), and passes the resulting text to
the `estimated_read_time.read_time_adapter` service, which wraps the `mtownsend/read-time`
PHP library to compute minutes/seconds from the word count and words-per-minute. It handles
node preview (sets `in_preview`) and re-estimates changed translations. The **widget**
(`estimated_read_time_default`) offers an "Automatically estimate read time" checkbox plus
manual minutes/seconds inputs (disabled while auto is on) and a `sidebar` setting that moves
the field into the entity form's advanced/sidebar group. The **formatter**
(`estimated_read_time_text`) renders via the `estimated_read_time_text` theme using a
`tokenized_string` setting (default `@minutes min read`) where `@minutes` and `@seconds` are
replaced; it prints nothing if the relevant token value is empty. There is no admin settings
page — you configure it entirely through the field, widget, and formatter on an entity
bundle. Requires the `mtownsend/read-time` Composer library.

---

- Show a "5 min read" estimate on blog posts and articles.
- Automatically recompute read time whenever an article is edited and saved.
- Let editors override the automatic estimate with a manual minutes/seconds value.
- Display read time in minutes and seconds via a customizable tokenized string.
- Configure reading speed per field (e.g. 200 wpm for technical content, 260 for casual).
- Calculate read time from a specific view mode (e.g. "Full content") rather than teaser.
- Place the read-time field in the node edit form's sidebar/advanced group.
- Add reading-time estimates to any fieldable entity type, not just nodes.
- Render read time on media, taxonomy terms, or custom entities.
- Base the estimate on rendered front-end output (so it reflects what readers actually see).
- Provide accurate estimates that include text from referenced/embedded fields in the view mode.
- Set a per-bundle words-per-minute tuned to your audience.
- Show only minutes ("@minutes min read") or include seconds ("@minutes min @seconds sec").
- Suppress the label entirely when both minutes and seconds are zero (empty-token handling).
- Recalculate read time for each translation of a multilingual article on save.
- Keep a manually entered read time stable by unchecking "Automatically estimate".
- Surface read time in Views by adding the field to a content listing.
- Give content teams a consistent reading-time badge across the site.
- Theme the output by overriding the `estimated-read-time-text.html.twig` template.
- Feed the stored minutes/seconds into other displays or components.
- Estimate read time using the front-end theme even when saving from the admin theme.
- Bulk-generate sample read-time values in tests via the field type's sample value generator.
- Migrate reading speed settings across fields with the module's update hooks.
- Add reading-time context to long-form documentation or knowledge-base entities.
- Improve UX by setting reader expectations before they start an article.
