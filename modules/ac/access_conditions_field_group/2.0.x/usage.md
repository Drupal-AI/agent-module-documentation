<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Conditions Field Group adds a "Visible to certain access models" setting to Field Group formatters, so a group (tab, fieldset, accordion item) renders only when at least one referenced access model grants access.

Use it to conditionally reveal grouped fields on entity displays based on reusable Access Conditions rules, without per-field access code.

- Adds an `access_models` entity_autocomplete to each field group's format settings.
- Evaluates models in `hook_field_group_pre_render_alter()`.
- Sets `#access = FALSE` on the group when no model grants access.
- Merges the access checker's cache contexts/tags/max-age into the element.

---

Install and configure:

- Enable `drush en access_conditions_field_group` (requires `access_conditions` and `field_group >= 3.x`).
- Create access models in Access Conditions first.
- On Manage Display, edit a field group's settings and pick models under "Visible to certain access models".
- Leave blank to show the group to everyone.

---

- Configure the setting via the form alter on `entity_form_display_edit_form` and `entity_view_display_edit_form`.
- Stored as a `field_group` third-party setting `format_settings.access_models`.
- At render, target_ids are loaded and each `access_model` evaluated by `access_conditions.access_checker`.
- First model that grants access makes the group visible and resets element cache to that model's metadata.
- If no model grants access, the element cache is the merge of all models and `#access` is FALSE.
- The module moves its `form_alter` to the end so it wins over other formatters.
- Non-edited groups get a settings summary line "Visible to certain access models".
- Works for any field group format type (tabs, fieldset, html_element, etc.).
- Visibility is display-only; underlying field data still exists on the entity.
- Cacheability is handled, so it is safe with dynamic page cache.
- Combine multiple models for OR visibility on a group.
- Configuration is exportable with the display config.
- Test each display as different roles.
- Avoid heavy conditions inside models to keep displays cacheable.
- Confirm hidden groups are truly access-controlled, not just visually hidden, for sensitive data (use real field/entity access for security-critical fields).
