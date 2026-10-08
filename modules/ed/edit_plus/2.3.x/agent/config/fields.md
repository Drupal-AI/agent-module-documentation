<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-field Edit+ configuration & Drush

Edit+ has **no global settings form** and no `configure` route. Its only configuration is
**per-field third-party settings** stored on `field_config` entities.

## Field settings form (`src/Form/FieldConfigFormAlter.php`)

`edit_plus_form_field_config_edit_form_alter()` (in `edit_plus.module`) delegates to
`FieldConfigFormAlter::formAlter()`, which adds an *"Edit+"* details group (`#tree = TRUE`,
`#weight 23`) to the *Manage fields* → field edit form (`field_config_edit`), with two controls:

- `disable` — checkbox *"Disable inline editing for this field"*.
  Read from `$field->getThirdPartySetting('edit_plus', 'disable')`.
- `handle` — radios *"Form Item Handle"*, options `form_item` (default) / `wrapper`. Controls whether
  the rendered page markup replaced during inline editing is the whole **wrapper** or just the
  **form item**. Default resolved via `$field->getThirdPartySetting('edit_plus','handle')` →
  `FormHandleFieldAttribute::getDefault($field)` → `'form_item'`. Hidden (via `#states`) when
  `disable` is checked.

A submit handler (unshifted onto `actions.submit.#submit`) copies
`$values['edit_plus']` into `$values['third_party_settings']['edit_plus']` so core persists them on
the `field_config` entity.

## Config schema (`config/schema/edit_plus.schema.yml`)

Defines `field.field.*.*.*.third_party.edit_plus` (mapping):

- `disable` — boolean, *"Disable inline editing for this field"*.
- `handle` — string, *"Form Item Handle"*.

That is the module's entire config-schema footprint (`provides_config_schema: true`). It ships no
`config/install/*` defaults of its own (the submodules do — they install block types, view modes,
fields, and a Landing Page node type).

## How the settings are consumed

The `disable`/`handle` third-party settings and the `FieldAttributes` events (see api/extending.md)
drive which rendered elements get `data-edit-plus-*` attributes and how the AJAX update targets the
page markup (`EditPlusFormTrait::updatePage()` chooses the wrapper vs form-item selector from the
`only_update_element` value).

## Drush commands (`src/Drush/Commands/UpdateInlineEditor.php`)

Maintenance helpers for keeping the bundled CKEditor 5 inline-editor build aligned with core
(`provides_drush_commands: true`, tagged in `drush.services.yml`):

- `edit_plus:update-ckeditor-version` (alias `e+_update`) — reads core's `core/package.json`
  `devDependencies.ckeditor5` version and writes it into the module's `package.json`
  `@ckeditor/ckeditor5-editor-inline` entry.
- `edit_plus:move-library` (alias `e+_move`) — copies the built inline editor from
  `node_modules/@ckeditor/ckeditor5-editor-inline/build/editor-inline.js` into
  `assets/vendor/ckeditor5/editor-inline.js`.

Both are developer/packaging tools (they edit files in the module directory), not runtime features.
