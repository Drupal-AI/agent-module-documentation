<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Statistics ships two config-only Paragraph bundles — an outer `bp_statistics` container and an inner `bp_stat` item — that together render a "by the numbers" row of up to four statistics.

---

Unlike the other Bootstrap Paragraphs submodules this one installs a **pair** of paragraph types and nests one inside the other. The outer bundle `bp_statistics` ("Statistics") carries the shared styling fields `bp_header`, `bp_width` and `bp_background` plus its own field `bp_statistic` — an `entity_reference_revisions` storage with `cardinality: 4` whose `handler_settings.target_bundles` allows only `bp_stat`, edited inline with the `entity_reference_paragraphs` widget (`edit_mode: closed`, `add_mode: dropdown`, `default_paragraph_type: bp_stat`, item title "Stat"/"Stats"). The inner bundle `bp_stat` ("Stat") has three plain `string` fields, each max 255 characters: `bp_statistic_header`, `bp_statistic_item` and `bp_statistic_description`. The module's only PHP is a `hook_theme()` registering three suggestions and a `hook_help()` that prints its README — there are no plugins, services, permissions, Drush commands, config schema or configure route. Its three twig templates do the layout work: `paragraph--bp-statistics.html.twig` maps `bp_width`/`bp_background` values straight to CSS classes and attaches the `bootstrap_paragraphs/bootstrap-paragraphs` and `bp_statistics/bp-statistics` libraries, `paragraph--bp-stat.html.twig` wraps each stat in `.statistic-header` / `.statistic-item` / `.statistic-description` divs, and `field--paragraph--bp-statistic.html.twig` wraps each item in `paragraph--type--bp-statistics__{{ loop.length }}col` — so a row of three stats gets `__3col` and a row of four gets `__4col`, and the shipped CSS turns those into 33%/25% floated columns above 768px. As with every bp_* submodule the config lives in `config/optional`, so it is imported once at install and then owned by the site; nothing is editor-visible until you add a Paragraphs field somewhere that allows the `bp_statistics` bundle.

---

- Add a "By the numbers" band to an About page with three or four headline figures.
- Show impact metrics (people served, grants awarded, years running) on a nonprofit homepage.
- Render KPI tiles on a product or service landing page.
- Give editors a repeatable stats component without building a custom block plugin.
- Display uptime / SLA figures on a status or reliability page.
- Build a "Why choose us" strip of four short numeric claims.
- Present survey headline results as a row of percentages with captions.
- Add annual-report highlights (revenue, headcount, locations) as structured content.
- Use the `bp_statistic_header` field as a small eyebrow label above each number.
- Use `bp_statistic_description` for the caption under each figure.
- Automatically switch between one-, two-, three- and four-column layouts by adding stats.
- Cap a statistics row at four items using the shipped `cardinality: 4` storage limit.
- Constrain the band to a narrow measure with `bp_width: paragraph--width--narrow`.
- Give the band a brand background via `bp_background: paragraph--color paragraph--color--primary`.
- Nest a Statistics paragraph inside a `bp_columns` or `bp_column_wrapper` layout paragraph.
- Reuse the same stats component across many content types from a single paragraphs field.
- Translate stat labels and captions per language (all three string fields are translatable).
- Restrict a dedicated paragraphs field to only `bp_statistics` for a locked-down page template.
- Theme the numbers separately from their captions using the `.statistic-item` class hook.
- Override `field--paragraph--bp-statistic.html.twig` to change the column-count logic.
- Swap the shipped `bp-statistics.min.css` for your own grid via a theme `libraries-override`.
- Migrate a legacy "facts and figures" table into structured paragraph content.
- Let editors reorder stats by dragging the inline paragraph rows.
- Add a stats band to a campaign landing page built entirely from Bootstrap Paragraphs.
- Show conference or event numbers (attendees, sessions, speakers) on an event page.
- Build a comparison strip of "before / after" figures for a case study.
- Give a department page a compact set of headline metrics without touching a theme file.
