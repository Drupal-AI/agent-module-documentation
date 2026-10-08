<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, dialog forms, settings form, requirements

## Routes (`dsfr4drupal_picker.routing.yml`)

- `dsfr4drupal_picker.settings` — `GET/POST /admin/config/user-interface/dsfr4drupal-picker`, form
  `Form\SettingsForm`, `_permission: 'administer site configuration'`. Menu link in
  `dsfr4drupal_picker.links.menu.yml` (under *Configuration → User interface*,
  `system.admin_config_ui`).
- `dsfr4drupal_picker.icon.dialog` — `/dsfr4drupal_picker/icon/dialog/{filter_format}`, form
  `Form\IconDialogForm`, `_entity_access: 'filter_format.use'`.
- `dsfr4drupal_picker.pictogram.dialog` — `/dsfr4drupal_picker/pictogram/dialog/{filter_format}`,
  form `Form\PictogramDialogForm`, `_entity_access: 'filter_format.use'`.

The two dialog routes are gated by `filter_format.use` entity access, so they are reachable only by
users allowed to use that text format. The option list itself is not served by an open endpoint — it
is embedded as `drupalSettings`/dynamic plugin config on render.

## Settings form (`src/Form/SettingsForm.php`)

`ConfigFormBase`, id `dsfr4drupal_picker_settings_form`, edits config object
`dsfr4drupal_picker.settings`. One field: **Widget theme** (`radios`, required; options
bootstrap / dark-grey / grey / inverted; default `grey` from `config/install/…settings.yml`).
`submitForm()` saves `theme` and calls `drupal_flush_all_caches()`.

Config schema (`config/schema/dsfr4drupal_picker.schema.yml`): `dsfr4drupal_picker.settings.theme`
(string); `field.widget.settings.dsfr4drupal_picker` (`empty_icon`, `has_search` booleans);
`ckeditor5.plugin.dsfr4drupal_picker_icon` / `_pictogram` (`allowed_groups` sequence, `has_search`
boolean).

## Dialog forms (`src/Form/`)

- `DialogFormBase` (abstract, extends `FormBase`, injects `entity_type.manager`). `buildForm()`
  seeds the current value from `element` (form value → request payload → user input), builds a
  `#type => 'dsfr4drupal_picker_<element>'` element with `#keep_open => TRUE`, `#required => TRUE`,
  and applies the editor's stored plugin `allowed_groups` / `has_search` (loaded from the `editor`
  entity for the `{filter_format}`). Submit is an AJAX `button`; `submitForm()` is a no-op.
- `IconDialogForm` (`PICKER_ELEMENT = 'icon'`) — `ajaxSubmitForm()` returns an `EditorDialogSave`
  command with `element: dsfrIcon`, attributes `data-icon` = the chosen value, `data-size: md`, then
  closes the modal.
- `PictogramDialogForm` (`PICKER_ELEMENT = 'pictogram'`) — `EditorDialogSave` with
  `element: dsfrPictogram`, attribute `data-pictogram` = the chosen value.

The value inserted is the item selected from the picker's own option set; on display it is re-rendered
through the text-format filter (see [plugins/editor-embed.md](../plugins/editor-embed.md)).

## Runtime requirements + library alter (`src/Hook/Dsfr4drupalPickerHooks.php`)

- `runtimeRequirements()` reports **error** on the status report if the DSFR icons dir
  (`libraries/dsfr/dist/icons`) or pictograms dir (`…/artwork/pictograms`) is missing, or if
  `libraries/fonticonpicker/js/jquery.fonticonpicker.min.js` is absent.
- `libraryInfoAlter()` rewrites the `fonticonpicker` library's theme CSS path from the configured
  `theme` (e.g. `grey` → `…/themes/grey-theme/jquery.fonticonpicker.grey.min.css`).
- `fieldTypeCategoryInfoAlter()` attaches `dsfr4drupal_picker/field-icon` to the fallback field-type
  category (icons on the *Add field* screen).
- `help()` implements `hook_help` for `help.page.dsfr4drupal_picker`.

Legacy procedural shims for `help`, `library_info_alter`, `field_type_category_info_alter` live in
`dsfr4drupal_picker.module` (marked `#[LegacyHook]`), delegating to the service class. Services are
declared in `dsfr4drupal_picker.services.yml`.
