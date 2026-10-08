<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 plugin: Advanced Table

Adds `id`, `dir`, and `class` attributes to CKEditor 5 tables. All wiring is source-cited below.

## Plugin definition — `editor_advanced_table.ckeditor5.yml`

Definition id **`editor_advanced_table_table_advanced`**:

- `ckeditor5.plugins: [tableAdvanced.TableAdvanced]` — the JS plugin constructor to load.
- `ckeditor5.config.table.contentToolbar: [tableAdvanced]` — registers the button on CKEditor 5's
  **table content toolbar** (appears when a table is selected), not the main toolbar.
- `drupal.label: 'Advanced Table'`, `drupal.library: editor_advanced_table/tableAdvanced`,
  `drupal.admin_library: editor_advanced_table/admin`.
- `drupal.class: Drupal\editor_advanced_table\Plugin\CKEditor5Plugin\TableAdvanced` — the PHP
  settings/config class.
- `drupal.elements: ['<table class id dir>']` — declares that the `class`, `id`, and `dir`
  attributes on `<table>` are permitted, so they pass the text format's HTML restrictions.
- `drupal.conditions.plugins: [ckeditor5_table]` — the plugin is only available when core's Table
  plugin is enabled on the format.

Libraries (`editor_advanced_table.libraries.yml`): `tableAdvanced` ships
`js/build/tableAdvanced.js` (minified) + `css/editor_advanced_table.admin.css`, depending on
`ckeditor5/ckeditor5`; `admin` ships the same CSS as a theme asset.

## PHP class — `src/Plugin/CKEditor5Plugin/TableAdvanced.php`

`class TableAdvanced extends CKEditor5PluginDefault implements CKEditor5PluginConfigurableInterface`
(uses `CKEditor5PluginConfigurableTrait`). Marked `@internal`.

- `defaultConfiguration()` → `allow_classes`, `allow_id`, `allow_language_direction` all **TRUE**.
- `buildConfigurationForm()` → an info paragraph plus three `checkbox` elements
  (`allow_classes`, `allow_id`, `allow_language_direction`) shown on the "Advanced table" tab of the
  format's CKEditor 5 plugin settings.
- `validateConfigurationForm()` → no-op.
- `submitConfigurationForm()` → casts each checkbox to `(bool)` into `$this->configuration`.
- `getDynamicPluginConfig($static_plugin_config, $editor)` → returns
  `tableAdvanced => { allowId, allowLanguageDirection, allowClasses }` (booleans from config) and
  passes through `table => $static_plugin_config['table'] ?? []`. This is how the three toggles
  reach the browser.

## Config schema — `config/schema/editor_advanced_table.schema.yml`

`ckeditor5.plugin.editor_advanced_table_table_advanced` is a mapping with booleans `allow_id`,
`allow_language_direction`, `allow_classes`. Also defines `ckeditor5.plugin.ckeditor5_table` as an
empty mapping. Settings are stored inside the **editor** entity's
`settings.plugins.editor_advanced_table_table_advanced` (per text format) — there is no standalone
config object and no `config/install` defaults.

## Client-side behaviour (`js/ckeditor5_plugins/tableAdvanced/src/`)

- `index.js` — exports `{ TableAdvanced }`; `TableAdvanced` requires `TableAdvancedEditing` and
  `TableAdvancedUI`.
- `tableadvancedediting.js` — `schema.extend('table', { allowAttributes: ['tableId','tableDir',
  'tableClass'] })`; upcast maps view `table@id/dir/class` → model `tableId/tableDir/tableClass`;
  downcast writes the attributes back (removing them when empty); editingDowncast for `tableClass`
  unwraps the `figure` widget to target the real `<table>`. Registers command `setTableAttributes`
  (`SetTableAttributesCommand`).
- `commands/settableattributescommand.js` — `refresh()` reads current `id/dir/class` from the
  selected table; `execute({id,dir,class})` trims values and sets or removes each attribute; a `dir`
  of `''`/`'Not set'` is treated as unset.
- `tableadvancedui.js` — adds the `tableAdvanced` toolbar button (icon
  `theme/icons/table-advanced.svg`), bound to the command's `isEnabled`; opens a `ContextualBalloon`
  holding `TableAdvancedFormView`; on submit runs `setTableAttributes` with the form values.
- `ui/tableadvancedformview.js` — "Advanced table properties" form; renders the Id text input, the
  Language Direction `<select>` (Not set / LTR / RTL), and the Stylesheet Classes text input **only
  when** the corresponding `allowId`/`allowLanguageDirection`/`allowClasses` config flag is true.

## Install & enable

1. Install the module (depends on core `ckeditor5`).
2. Go to `admin/config/content/formats` (Text formats and editors) and edit a format that uses
   CKEditor 5 with the core **Table** button.
3. The `tableAdvanced` button is available on the table content toolbar; open the **Advanced table**
   plugin-settings tab to choose which of ID / language direction / CSS classes editors may set.
4. Save. Editors then select a table, click the Advanced Table button, and fill the balloon form.

`configure` (info.yml) points at the generic `editor.config_filter` text-formats route; there is no
module-specific settings page.
