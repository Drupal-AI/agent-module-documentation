<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Empty Fields lets you render something in place of a field that has no value, instead of it simply being hidden — for example a non-breaking space or custom (token-aware) text.

---

The module adds an "Empty value behavior" option to every field formatter's third-party settings on an entity's *Manage display* page. You pick an **EmptyField plugin** (the module defines an `empty_fields` plugin type via `EmptyFieldsPluginManager` and the `@EmptyField` annotation) as the field's `handler`, optionally with plugin-specific `settings`; both are stored as third-party settings on the field's formatter component in the `entity_view_display` config (`third_party_settings.empty_fields.handler` and `.settings`). At render time `hook_entity_display_build_alter()` detects fields that are empty but viewable, instantiates the chosen plugin, and replaces the field's build with the plugin's output (themed as a normal field so labels still show). Two plugins ship out of the box: `nbsp` (renders a non-breaking space, useful to keep table/grid layouts aligned) and `text` (renders custom text run through the token system, so you can include entity/user tokens), plus a hidden `broken` fallback. Because it is a plugin type, you can add your own EmptyField plugin to render any placeholder logic. There is no configure route, no permissions, and no Drush; the config schema validates the third-party setting and per-handler settings.

---

- Show a non-breaking space instead of nothing when a field is empty (keeps table rows aligned).
- Display "N/A" or "Not provided" custom text when a field has no value.
- Render token-based placeholder text for an empty field (e.g. include the node title or author).
- Keep a Views/table column from collapsing when a cell's field is empty.
- Provide a consistent visual placeholder across a content type's display.
- Configure empty-value behavior per field, per view mode, on Manage display.
- Show a default label/value for an empty telephone or address field.
- Keep grid/card layouts uniform by filling empty fields with a spacer.
- Fill an empty "price" field with a "Contact us" message via the text handler.
- Use tokens to compute the placeholder from other entity data.
- Add a custom EmptyField plugin for bespoke empty-field rendering.
- Ensure empty fields still emit their label/wrapper for CSS targeting.
- Display a dash ("—") for empty date or reference fields.
- Provide accessible placeholders instead of silently omitting content.
- Standardize "missing data" presentation across an editorial site.
- Export the empty-field behavior as part of entity_view_display config.
- Differentiate empty-field handling between teaser and full view modes.
- Avoid custom Twig just to render a fallback for empty fields.
- Keep a consistent layout in email/templated output where empty fields would break spacing.
- Apply empty-value text to media, taxonomy, or user fields, not just nodes.
