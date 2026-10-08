<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Display Label lets a field show a **different label when its content is viewed** than the label used on entry forms — e.g. a field labelled "Body" on the edit form can render as "Body Display" on the page.

---

The module adds a single **"Display label"** textfield to the standard field settings form
(`field_config_edit_form`), just below the normal Label field. Whatever you type there is saved as a
**third-party setting** on that `FieldConfig` entity:
`field.field.<entity_type>.<bundle>.<field_name>` → `third_party_settings.field_display_label.display_label`.
At render time, `hook_preprocess_field()` (implemented in the OOP `FieldDisplayLabelHooks` class)
looks up that third-party setting on the field definition and, if present, overwrites
`$variables['label']` with it — so the displayed field label changes without touching the field
storage, the form label, or a Twig template override. If the Display label is left blank the setting
is unset and the normal field label is used. The label is stored **per field instance (per bundle)**,
so the same field can display differently on different content types. There is no admin settings
page, config object of its own, permission, service API, plugin, or Drush command — the entire
module is those two hooks plus a one-key config schema
(`field.field.*.*.*.third_party.field_display_label`).

---

- Show a field as "Author" on the page while editors still see "Byline" on the edit form.
- Give the core Body field a friendlier public label like "Article text" without renaming it.
- Present a technical field (e.g. "field_ref_target") with a human label like "Related item" on display.
- Use one field label for data entry and another for the rendered output.
- Change a field's display label on just one content type while leaving it untouched elsewhere.
- Relabel a field for the front-end without creating a template override or preprocess hook.
- Keep an internal/administrative field name but show a marketing-friendly label to visitors.
- Rename a field's display label without a database field rename or config migration.
- Localize-friendly relabeling of a field's shown title separate from its form title.
- Display "Price (incl. VAT)" on the page while the edit form label stays "Price".
- Give date fields context-specific display labels (e.g. "Published on" vs form's "Date").
- Distinguish a form label ("Upload image") from a display label ("Photo").
- Apply a cleaner label to a reused field that means different things on different bundles.
- Avoid confusing editors by keeping an explicit form label while simplifying the public one.
- Set the display label via exported config (`third_party_settings.field_display_label.display_label`).
- Deploy per-bundle display labels as part of field config in a config-managed workflow.
- Override the label a theme prints for a field without editing the theme.
- Show a shortened display label where the form label is long and descriptive.
- Provide different display labels for the same field across two content types sharing it.
- Relabel taxonomy, media, or user fields on display through their field settings form.
- Quickly A/B two public labels for a field by toggling the Display label value.
- Keep accessibility-friendly descriptive form labels while showing terse display labels.
