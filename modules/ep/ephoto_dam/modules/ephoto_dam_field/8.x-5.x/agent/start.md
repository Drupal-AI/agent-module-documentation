<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ephoto DAM Field (ephoto_dam_field) — agent index

Submodule of **Ephoto Dam**. Adds a field type that stores an asset chosen from the Ephoto DAM
library (URL + metadata) and renders a preview. Package "Ephoto Dam". Depends on core `field`, core
`system`, and parent module `ephoto_dam`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed
release 8.x-5.3.

- **Field type, widget, formatter, constraint, and the JS chooser wiring** → [fields/field.md](fields/field.md)

## What it actually is

- Field type `ephoto_dam_field` (`Plugin\Field\FieldType\EphotoDamField`): stores columns
  `identifier` (int), `url`, `image_size`, `version`, `caption`, `thumbnail` (varchar). Field
  settings `version_support` (bool) and `captions_format` (string). Default widget/formatter as
  below. Constraint `EphotoDamFieldValidation`.
- Widget `ephoto_dam_field_widget` (`Plugin\Field\FieldWidget\EphotoDamFieldWidget`): "Select"
  buttons that open the Ephoto chooser via JS; fields for url/size/version/caption/thumbnail.
- Formatter `ephoto_dam_field_formatter` (`Plugin\Field\FieldFormatter\EphotoDamFieldFormatter`):
  renders `EphotoDamField::getHtmlPreview()` (thumbnail, caption, link, metadata bubbles).
- Constraint `EphotoDamFieldValidation` (`Plugin\Validation\Constraint\EphotoDamFieldConstraint` +
  `EphotoDamFieldConstraintValidator`): validates only that `image_size` matches `^[0-9x]+$`.
- Hooks in `ephoto_dam_field.module`: attaches libraries and passes the parent's `server_url` +
  field settings to JS (`drupalSettings.ephotoDamField[<field_name>]`); validates that `server_url`
  is set before a field config is saved.
- Update hook `ephoto_dam_field_update_9370()` adds the `identifier` column to existing fields.
- **No routes, no permissions, no services, no config schema of its own.** Reuses the parent's
  settings route `ephoto_dam.admin_settings` as its `configure` link.

## Key files

- `ephoto_dam_field.info.yml`, `ephoto_dam_field.module`, `ephoto_dam_field.install`,
  `ephoto_dam_field.libraries.yml`, `js/ephoto_dam_field.js`
- `src/Plugin/Field/FieldType/EphotoDamField.php`
- `src/Plugin/Field/FieldWidget/EphotoDamFieldWidget.php`
- `src/Plugin/Field/FieldFormatter/EphotoDamFieldFormatter.php`
- `src/Plugin/Validation/Constraint/EphotoDamFieldConstraint.php`,
  `EphotoDamFieldConstraintValidator.php`
