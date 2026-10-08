<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Delimiter adds a "Field Delimiter" text setting to any field formatter on a **multi-value** field, so its values render separated by a string you choose (e.g. a comma, a `<br>`, a bullet) instead of stacked.

---

The module has no field type, widget, settings page, permissions, plugins, or Drush of its own — it is a small formatter enhancement for core. Via `hook_field_formatter_third_party_settings_form()` it adds a 5-character **Field Delimiter** textfield to the formatter settings (the cog) of any field whose storage is multiple (`isMultiple()`) on an entity's *Manage display* page, and `hook_field_formatter_settings_summary_alter()` shows the chosen delimiter in the formatter summary. The value is stored as a **third-party setting** `field_delimiter.delimiter` on that field's component inside the `entity_view_display` config entity (schema `field.formatter.third_party.field_delimiter`). At render time `hook_preprocess_field()` reads the setting and, when the field has 2+ items, appends the (XSS-filtered) delimiter as a `#suffix` to every rendered item except the last, producing an inline delimited list. The delimiter is passed through `Xss::filter()` allowing only `br`, `hr`, `span`, `img`, and `wbr` tags, so simple HTML separators are supported but arbitrary markup is stripped. It has no effect on single-value fields (the checkbox/textfield only appears for multi-value fields, and preprocess bails when there are fewer than 2 items).

---

- Display taxonomy tags on a node as a comma-separated inline list.
- Separate multiple author names with " / " instead of stacking them.
- Put a `<br>` between each value of a multi-value text field to force line breaks.
- Render a multi-value link field as a bullet-like `•`-separated list.
- Show a list of categories separated by " | " in a compact teaser.
- Comma-separate a multi-value "keywords" field in a card layout.
- Use a thin-space `<wbr>` or `<span>`-wrapped delimiter for styling control.
- Configure a different delimiter per view mode (teaser vs. full) via each view display.
- Present multi-value entity-reference labels inline for a table cell.
- Join repeated phone numbers with "; " for readability.
- Delimit a multi-value date field with ", " in a summary.
- Add an `<hr>` between grouped multi-value items in a full view.
- Keep single-value fields untouched — the setting only appears for multi-value fields.
- Avoid writing a custom formatter or Twig just to insert separators between values.
- Standardise list separators across many fields by setting the same delimiter on each display.
- Export the delimiter in config (`third_party_settings.field_delimiter.delimiter`) for deployment.
- Show a multi-value "ingredients" field as a comma list on a recipe node.
- Separate repeated tags with a middot for a magazine-style byline.
- Render multi-value reference fields inline in a Views field via the entity display.
- Give editors control of list separators without touching code.
