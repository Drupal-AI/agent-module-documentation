<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit in place field (edit_in_place_field) — agent index

Provides four **field formatters** that render a fieldable entity's value on the page as an
inline-editable control (in a View, a teaser, or a full display). When a user who has the
`edit in place field editing permission` permission views the field, the formatter renders the normal
read display **plus** a hidden Drupal form built with `FormBuilder::getForm()`. Clicking the value
reveals a text/textarea/select input and a **Save** button whose `#ajax` submits through core's
standard `/system/ajax` Form API path. The AJAX callback (`EditInPlaceFormBase::inPlaceAction()`)
re-loads the target entity from the server-side form **build args**, checks `update` access on the
entity and `edit` access on the field, writes the submitted value(s), calls `$entity->save()`, and
returns AJAX commands that re-insert the field HTML and re-bind the JavaScript. For users **without**
the permission every formatter falls through to its core parent (`StringFormatter`,
`BasicStringFormatter`, `EntityReferenceLabelFormatter`) and renders read-only.

- Depends on: nothing (info.yml declares no `dependencies`). Soft/optional: **Select2** and **Chosen**
  (used for the reference select only when installed); **Views** (a reference field's option list can
  come from a View). There is no `composer.json`.
- Core: `^10.3 || ^11 || ^12`. Package: `Fields`.
- No settings page / `configure` route — **all configuration is per field** on the entity's *Manage
  display*. Provides config schema; one permission; **no drush; no plugin types** (it ships formatter
  plugins, it does not define new plugin types); no services beyond the hook helper.
- Permission: `edit in place field editing permission` ("Allow to use edit in place field to save
  entities.").

## What you'd do → where

- **Turn a field into an inline-editable one / choose the right formatter and its settings** →
  [fields/formatters.md](fields/formatters.md)
- **Understand the AJAX save — form ids, the request/response data flow, the access check, the AJAX
  commands and re-render theme hooks** → [api/forms.md](api/forms.md)

## Key facts (real machine names)

- Field formatters (`Plugin/Field/FieldFormatter/`):
  - `edit_in_place_field_text` — field types `string`, `uri` — `EditInPlaceTextFormatter` (extends
    core `StringFormatter`).
  - `edit_in_place_field_long_text` — `string_long`, `email` — `EditInPlaceLongTextFormatter`
    (extends `BasicStringFormatter`).
  - `edit_in_place_field_entity_reference` — `entity_reference` — `EditInPlaceFieldReferenceFormatter`
    (extends `EntityReferenceLabelFormatter`).
  - `edit_in_place_field_reference_with_parent` — `entity_reference`, label "Edit in place filtered by
    parent" — `EditInPlaceFieldReferenceWithParentFormatter`.
- AJAX forms (`Form/`, all extend `EditInPlaceFormBase`, callback `inPlaceAction`):
  `edit_in_place_string_form`, `edit_in_place_long_string_form`, `edit_in_place_field_reference_form`,
  `edit_in_place_reference_with_parent_form`.
- Permission: `edit in place field editing permission`.
- Theme hooks / templates (registered in `Hook\EditInPlaceFieldHooks::theme()`):
  `edit_in_place_string_values`, `edit_in_place_reference_label`,
  `edit_in_place_reference_with_parent_label`.
- Custom AJAX commands: `Ajax\StatusMessageCommand` (extends core `InsertCommand`; JS command
  `insert`) and `Ajax\RebindJSCommand` (JS command `rebindJS`, implemented in
  `js/edit-in-place-field.js`).
- Render element: `edit_in_place_field_select` (`Element\EditInPlaceFieldSelect`, extends core
  `Select`).
- Library: `edit_in_place_field/edit_in_place` (`js/edit-in-place-field.js`,
  `css/edit-in-place-field.css`; deps `core/jquery`, `core/once`, `core/drupal`,
  `core/drupal.ajax`).
- Formatter settings schema keys: reference — `label_substitution`; reference-with-parent —
  `reference_parent_field_name`, `label_substitution`, `parent_label_substitution` (plus inherited
  `link`). The string formatter reuses core string-formatter settings.
- Hooks: `hook_help` (route `help.page.edit_in_place_field`) and `hook_theme`, via attribute-based
  `Hook\EditInPlaceFieldHooks` with `#[LegacyHook]` shims in `edit_in_place_field.module`.
