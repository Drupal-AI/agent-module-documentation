<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Field - Linkit integration adds Linkit-powered widgets and formatters to the Custom Field module, so a `link` or `uri` subfield/column can use Linkit's autocomplete to reference internal entities.

---

This submodule registers plugins into the parent Custom Field plugin system (it defines no new plugin types). It provides two `CustomFieldWidget` plugins — `linkit` (for a `link` column, extending the parent's LinkWidget) and `linkit_url` (for a `uri` column, extending UrlWidget) — and two matching `CustomFieldFormatter` plugins, `linkit` and `linkit_url`, that render the stored value using the configured Linkit profile. The widgets add a Linkit autocomplete to the subfield input so an editor can search for and link to internal content by title, while still allowing external URLs. Selection of these plugins happens per column inside a normal `custom` field: the widget id is stored in the entity form display under the Custom Field widget component's `settings.fields.<column>.type`, and the formatter id under the entity view display's `settings.fields.<column>.format_type`. The widget/formatter carry Linkit-specific settings (e.g. `linkit_profile`, auto-link text) contributed to the Custom Field schema via `hook_config_schema_info_alter()` in `src/Hook/ConfigSchemaHooks.php`. It depends on `custom_field` and `linkit`.

---

- Add Linkit autocomplete to a `link` subfield in a Custom Field so editors link internal nodes by title.
- Use the `linkit` widget on a link column instead of the plain link widget.
- Use the `linkit_url` widget on a `uri` column for URL-only Linkit autocomplete.
- Render a Linkit-referenced link with the `linkit` formatter (resolves internal entity URLs).
- Render a uri column with the `linkit_url` formatter.
- Point a subfield at a specific Linkit profile to scope which entity types are searchable.
- Keep internal links valid when referenced content's alias changes (Linkit stores an entity URI).
- Combine a Linkit link column with other subfields (image, text) in one composite Custom Field.
- Let editors add a "call to action" link that autocompletes internal pages.
- Provide external + internal linking in the same subfield input.
- Configure whether the link text is auto-filled from the referenced entity.
- Avoid a standalone Link/Linkit field by embedding the capability inside a Custom Field.
- Migrate a plain link column to a Linkit-enabled one by switching the subfield widget.
- Use Linkit on a multi-value Custom Field where each item has its own link.
- Standardise internal linking UX across bundles via the Custom Field.
- Present a related-resource uri column with searchable internal autocomplete.
- Ensure link integrity for editorial content referenced from a Custom Field.
- Pair the Linkit widget on the form display with the Linkit formatter on the view display.
- Reuse an existing Linkit profile configured elsewhere on the site for a Custom Field column.
