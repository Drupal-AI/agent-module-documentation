<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Field Autocomplete Filter lets you restrict which content types appear as suggestions in a Link field's internal-link autocomplete, per field instance, and validates the saved value against that list.

---

Core Link fields autocomplete against *all* node types. This module adds an **"Autocomplete Filter"** fieldset to each Link field instance's settings form (`field_config_edit_form`, only for fields of type `link`). There you pick an **include/exclude mode** (`negate`) and a set of **content types** (`allowed_content_types`); both are saved as third-party settings on the field's `FieldConfig` config entity (`field.field.<entity>.<bundle>.<field>` → `third_party_settings.link_field_autocomplete_filter`). At form build, `hook_field_widget_single_element_form_alter()` detects the `LinkWidget`, and if any bundles are selected it sets the `uri` element's `#selection_handler` to `default:node` and `#selection_settings['target_bundles']` to the resolved bundle list (inverting it when `negate` is on), so the autocomplete only suggests those types. It also adds an element validation callback that raises a form error if the entered node's type is not in the allowed list — protecting you when field settings change after content was created. If no content types are checked, all are allowed (the default core behavior). No settings page, permission, Drush command, or plugin — everything lives in per-field third-party settings.

---

- Limit a "Related page" link field so its autocomplete only suggests Basic pages.
- Restrict a menu/CTA link field to Landing page and Article types only.
- Exclude certain content types (e.g. internal-only) from a link field's suggestions.
- Configure include mode to whitelist specific content types for internal links.
- Configure exclude mode (`negate`) to blacklist a few types and allow the rest.
- Keep a "Read more" link field pointing only at News content.
- Prevent editors from linking to unpublished-workflow content types via a link field.
- Validate on save that a chosen node's type is still allowed after settings change.
- Set the filter per field instance so the same base field differs across bundles.
- Leave all boxes unchecked to allow every content type (core default) on a given field.
- Narrow autocomplete results to reduce noise for editors on large sites.
- Deploy the filter through config by exporting the field's `FieldConfig`.
- Script the third-party settings in an update hook via `setThirdPartySetting()`.
- Enforce internal-link governance without writing a custom selection handler.
- Apply a whitelist to a paragraph's link field for curated internal linking.
- Restrict a hero link field to promotional content types only.
- Combine include/exclude filtering with the standard Link field widget.
- Use `default:node` selection so only nodes (not other entities) are suggested.
- Read a field's allowed types with `drush cget field.field.<entity>.<bundle>.<field>`.
- Guard against broken links by rejecting references to now-disallowed content types.
- Standardize link governance across content types by copying the field settings.
