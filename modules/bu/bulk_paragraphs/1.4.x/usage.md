<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Paragraphs adds a "Bulk generate" action to Paragraphs widgets that creates many paragraph items at once with default and auto-incrementing field values.

---

Bulk Paragraphs extends the contributed Paragraphs module. On any content form that has an `entity_reference_revisions` (Paragraphs) field, users with the `use bulk paragraphs` permission get a "Bulk: <type>" button next to each paragraph-type add button. Clicking it opens a modal where you choose how many paragraphs to create (1-100) and set per-field default values. Numeric and date fields support increment patterns (e.g. `+1 day`, `+5`); text/string/link/email/telephone fields support templates with `{n}`, `{n0}` and `{date:FORMAT}` placeholders; image, file, boolean and list fields take a single shared value. Generated paragraphs are staged in the user's private tempstore and injected into the widget over AJAX (with a page-reload fallback), so nothing is persisted until you save the host entity. Nested paragraph fields are fully supported. An admin settings form at `/admin/config/content/bulk-paragraphs` controls which increment options are offered and their defaults, generation can be toggled per widget via a third-party setting, and a cron job deletes orphaned (never-attached) generated paragraphs after 24 hours. Requires the Paragraphs module and core Datetime; runs on Drupal 11.1+ and 12.

---

- Add dozens of identical cards, rows, or blocks to a Paragraphs field in one action instead of clicking "Add" repeatedly.
- Generate a batch of 1-100 paragraphs of a chosen type from a modal on the content form.
- Pre-fill string fields with a template like `Item {n}` so each paragraph is numbered automatically.
- Use `{n0}` for 0-based numbering when you need sequences starting at zero.
- Insert generated dates with `{date:Y-m-d}` in text fields, offset one day per item.
- Seed a numeric field with a start value and step it by `+1`, `+5`, or `+10` per paragraph.
- Populate a datetime/date field with a start date and increment `+1 day`, `+1 week`, or `+1 month` per item.
- Fill link fields with a templated URL such as `https://example.com/page-{n}` plus templated link text.
- Set templated email addresses like `user{n}@example.com` across many paragraphs.
- Set templated telephone numbers like `03-1234-000{n}`.
- Apply one shared uploaded image (with templated alt text) to every generated paragraph.
- Apply one shared uploaded file to every generated paragraph.
- Choose a single list/select option to apply to all generated paragraphs.
- Set a boolean/checkbox default for every generated paragraph.
- Fill text-with-summary fields with separate body and summary templates.
- Bulk-generate paragraphs inside nested paragraph fields, not just top-level ones.
- Preserve other unsaved values on the content form because generation refreshes only the widget over AJAX.
- Restrict who can bulk-generate by granting the `use bulk paragraphs` permission to specific roles.
- Disable bulk generation on individual Paragraphs widgets via the "Enable Bulk Paragraphs generation" widget setting.
- Curate which increment options editors see via the admin settings form.
- Set a site-wide default increment for date and numeric fields.
- Quickly build demo, prototype, or test content made of repetitive paragraphs.
- Rely on automatic cron cleanup so paragraphs generated but never saved don't accumulate.
- Match the module's add-button UI to the Paragraphs widget's dropdown vs. buttons `add_mode` setting.
