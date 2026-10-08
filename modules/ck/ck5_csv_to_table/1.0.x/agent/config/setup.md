<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, permission & toolbar setup

No configuration form and no config entities ship with this module. Setup is
done through the standard text-format/editor and permissions UIs.

## Install / enable
- `composer require drupal/ck5_csv_to_table` then `drush en ck5_csv_to_table -y`
  (or enable at `/admin/modules`), then `drush cr`.
- Requires the core `ckeditor5` module (declared dependency). Core `^10 || ^11`.

## Grant the permission
- Permission machine name: `use csv importer` (defined in
  `ck5_csv_to_table.permissions.yml`, `restrict access: true`,
  label "Use CSV Importer button in CKEditor 5").
- Assign at `/admin/people/permissions` to trusted editorial roles.
- Effect: the permission value is read server-side in
  `ElementSettingsAttachment::getSettings()` and exposed to the browser as
  `drupalSettings.ck5_csv_to_table.hasPermission`. The JS plugin only renders
  the button when this flag is not `false` (see `plugins/csv_importer.md`).

## Add the button to a text format
1. `/admin/config/content/formats` → edit a CKEditor 5 format
   (e.g. Full HTML / Basic HTML).
2. Drag the **CSV Importer** button (toolbar item `csvImport`) into the active
   toolbar.
3. The format must allow the table tags the plugin declares:
   `<table> <thead> <tbody> <tr> <td> <th>`. The plugin also requires the core
   `ckeditor5_table` plugin to be present (declared as a condition), so enable
   the core Table button/feature in the same format.
4. Save, then `drush cr`.

## How the settings get attached
- `hook_element_info_alter()` (`ck5_csv_to_table.module`) appends
  `[ElementSettingsAttachment::class, 'getSettings']` to the `text_format`
  element's `#pre_render`.
- `ElementSettingsAttachment::getSettings(array $element)`
  (`src/Render/ElementSettingsAttachment.php`) reads
  `current_user`->`hasPermission('use csv importer')`, writes it to
  `$element['#attached']['drupalSettings']['ck5_csv_to_table']['hasPermission']`,
  and adds `user.permissions` and `session` cache contexts. It implements
  `TrustedCallbackInterface` (`trustedCallbacks()` returns `['getSettings']`).

## Notes
- No `*.routing.yml`, `*.services.yml`, `config/install`, or `config/schema` —
  nothing to export or configure beyond the format/permission steps above.
- Kernel test `tests/src/Kernel/CsvImporterSettingsTest.php` covers the
  attachment: it asserts `hasPermission` is a bool, is `FALSE` for an
  unprivileged user, and `TRUE` for a user granted `use csv importer`.
