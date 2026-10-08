HTML Field Formatter adds a single field formatter (id `html`) that outputs the stored value of text and string fields as raw HTML markup on the entity display.

---

The module ships one plugin, `HtmlFormatter` (`@FieldFormatter(id = "html")`), applicable to `text`, `text_long`, `text_with_summary`, `string`, and `string_long` fields. You select it on an entity bundle's *Manage display* tab like any other formatter; there is no global settings page (`configure` is null), no permissions, and no config schema. The formatter has one setting, `allowed_tags` (a newline-separated tag list). When `allowed_tags` is **empty (the default)** it renders the field value through a render array `#children` key, which emits the value verbatim with no filtering or escaping. When `allowed_tags` is set, it instead renders via `#markup` plus `#allowed_tags`, so Drupal's Xss filter strips everything except the listed tags. Because the default is unfiltered, the module is intended for fields that already contain trusted HTML (embeds, snippets) authored by trusted roles — the README itself puts XSS mitigation on the site operator. It is a tiny, dependency-free module (one PHP class) useful when you want a field's HTML to render as markup rather than being escaped or run through a text format.

---

- Render a plain `string` field that contains HTML so the markup is applied instead of shown as escaped text.
- Output a `text_long` field's raw value without wrapping it in a text-format filter pipeline.
- Display third-party embed codes (video, maps, social widgets) stored in a field.
- Show a hand-authored HTML snippet field exactly as entered.
- Restrict rendered markup to a safe subset by listing `allowed_tags` (e.g. `p`, `a`, `strong`).
- Allow only `<br>` and `<em>` in a short string field while stripping everything else.
- Provide a lightweight alternative to a full CKEditor text format when only raw markup is needed.
- Render `string_long` metadata fields that hold pre-built HTML fragments.
- Apply the formatter per view mode (e.g. raw HTML in full view, plain in teaser).
- Use it on a `text_with_summary` field to render the value markup directly.
- Give trusted editors a field whose HTML passes through untouched for landing-page building blocks.
- Insert inline SVG or icon markup stored in a string field.
- Render email/notification HTML templates stored as field values.
- Combine with field access control so only trusted roles can populate the HTML-rendered field.
- Set an `allowed_tags` whitelist so contributor-edited fields render a safe formatting subset.
- Replace a custom preprocess/Twig `|raw` hack with a reusable, configurable formatter.
- Show HTML tables or lists authored directly in a long-text field.
- Render markup coming from an external import into a text field.
- Use on multi-value fields — each delta is rendered as its own HTML element.
- Display a footer/disclaimer HTML field consistently across bundles.
