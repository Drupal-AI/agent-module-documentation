Advanced Text Formatter adds a single field formatter, "Advanced Text" (plugin id `advanced_text`), that displays text/string fields with configurable trimming, HTML filtering, text-format handling, token replacement, summary use, and optional linking to the entity.

---

The module provides one `@FieldFormatter` plugin, `advanced_text`, that works on the `string`, `string_long`, `text`, `text_long`, and `text_with_summary` field types. It is configured per field on an entity's **Manage display** page (or in a View), not through any global admin form (`configure` is null, and it defines no permissions, services, or Drush commands). Its settings let you trim the output to a length (with an optional ellipsis and word-boundary awareness), choose whether to render the field's summary when one exists, and run the value through Drupal's token system before display. A "Filter" select controls how markup is handled: `none` (raw), `input` (the item's own selected text format via `check_markup()`), `limit_html` (strip to an allowed-tags list with `Xss::filter()`, with optional auto-paragraphing), `drupal` (a specific named text format you pick), or the deprecated `php`. All settings are stored in the `entity_view_display` config as the component's `settings` array. Its only dependencies are core Text and Filter. It replaces the need to build a custom formatter when you just want to truncate or re-filter existing text output.

---

- Truncate a long Body field to a fixed character count for a teaser/listing view mode.
- Append an ellipsis ("...") automatically when text is trimmed.
- Trim only on word boundaries so words are never cut mid-way.
- Show a text field's manually-entered summary when present, falling back to the full value.
- Display a plain string field but strip it down to a whitelist of safe HTML tags.
- Remove all HTML from a field's output entirely (empty allowed-tags list).
- Render a raw text field through a specific named text format (e.g. "Full HTML") regardless of the value's own stored format.
- Honor each text item's own selected text format via `check_markup()`.
- Run token replacement (e.g. `[node:title]`, `[node:author:name]`) inside a text field before it is displayed.
- Convert line breaks into `<br>`/`<p>` tags (auto-paragraph) when limiting allowed HTML.
- Wrap the rendered field value in a link to its host entity.
- Provide a lightweight teaser without configuring a separate "Trimmed" core formatter chain.
- Apply consistent trimming to string, string_long, text, text_long, and text_with_summary fields with one formatter.
- Configure different trim lengths per view mode (full vs. teaser vs. search index).
- Sanitize user-supplied text fields displayed in an untrusted context by limiting HTML tags.
- Strip markup from a field so its plain text can be reused (e.g. in a meta description).
- Show only the summary in listings while the full display shows the whole body.
- Use it inside a View's field display to trim or re-filter a text field column.
- Migrate away from a custom formatter module whose only job was truncation.
- Combine token replacement with trimming to build dynamic, length-capped snippets.
- Disable trimming (length 0) but still use the filter/token/link options.
- Standardize teaser length across many content types by reusing the same formatter settings.
- Force a stricter output filter than the field's stored format allows, for display only.
