<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Heading provides a `heading` field type that stores a text string plus a heading size (h1–h6) and renders it as a real HTML heading element, and it also adds a `heading_text` formatter so existing string/text fields can be output as a heading of a chosen size.

---

The module ships one field type and two formatters. The **`heading` field type** (`HeadingItem`) stores two columns — `text` (varchar 255) and `size` (char 2, e.g. `h2`) — with a default `heading` widget and default `heading` formatter. Its per-field settings are `label` (the form label shown for the text input) and `allowed_sizes` (a subset of h1–h6 the editor may pick). The **`heading` widget** renders a textfield plus a size `<select>`; when only one size is allowed the select is hidden and the size is set automatically as a fixed value. The **`heading` formatter** renders each item through the `heading` theme hook (template `heading.html.twig`: `<{{ size }}>{{ text }}</{{ size }}>`), skipping empty text. Separately, the **`heading_text` formatter** applies to core `string` and `text` fields: it has a single `size` setting (default `h2`) and wraps the field value in an `html_tag` of that size (running `text` through processed_text and `string` through nl2br). The module registers its theme hook and a `hook_token_info_alter()` that advertises `size` and `text` tokens for every heading field, all via a modern autowired `HeadingHooks` service. It has no admin settings page, no permissions, no Drush, and no configure route — everything is configured through the entity's *Manage fields* and *Manage display* screens (or the equivalent config). Config schema is provided for the field settings, stored value, and the `heading_text` formatter's `size`.

---

- Add a `heading` field to a content type to give editors a titled heading with a chosen level.
- Let editors pick the heading level (h1–h6) per value from a size select.
- Constrain a heading field to only h2 and h3 via the `allowed_sizes` setting.
- Lock a heading field to a single size (the widget hides the select and fixes the size).
- Output an existing plain-text `string` field as an `<h2>` using the `heading_text` formatter.
- Render a `text` field as a heading while still running it through its text format.
- Give a paragraph/section entity a configurable heading without hardcoding markup in Twig.
- Provide a "section title" field on a Layout Builder block or paragraph type.
- Present a media entity's caption as a semantic heading.
- Use the `heading` theme hook / `heading.html.twig` template to override heading markup.
- Expose a heading field's `size` and `text` as tokens (e.g. for metatags or pathauto).
- Standardize heading levels across content by limiting `allowed_sizes` per field.
- Build an accessible heading hierarchy by letting editors choose the correct level.
- Add a "banner heading" field to a hero component with an editor-selectable level.
- Migrate hardcoded heading markup into structured field data (text + size columns).
- Keep the label of a heading field's text input meaningful via the `label` field setting.
- Render a taxonomy term's title field as a heading via the `heading_text` formatter.
- Format a node title-like custom string field as an `<h3>` in a teaser view mode.
- Store the heading text and level separately so they can be themed independently.
- Provide FAQ or accordion item titles as heading-typed fields.
- Export heading field configuration (allowed_sizes, formatter size) for deployment.
- Prevent empty headings from rendering (both formatters skip empty text).
- Offer content authors a WYSIWYG-free, structured way to add headings.
