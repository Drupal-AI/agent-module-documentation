<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal - Picker (dsfr4drupal_picker) — agent index

Lets editors select **DSFR icons and pictograms** (French State Design System — Système de Design de
l'État) as field values and insert them inline in CKEditor 5. Package `DSFR for Drupal`. License
GPL-2.0-or-later. Installed **1.2.1** (branch 1.2.x). Core `^10.3 || ^11 || ^12`. Requires PHP
`ext-iconv`. Depends only on core **`field`**. Configure at `dsfr4drupal_picker.settings`
(`/admin/config/user-interface/dsfr4drupal-picker`).

Needs two webroot libraries: the **DSFR** distribution at `libraries/dsfr/dist/` (its icon CSS and
pictogram SVGs are auto-scanned) and the jQuery **FontIconPicker** at `libraries/fonticonpicker/`
(the widget UI). `Dsfr4drupalPickerHooks::runtimeRequirements()` reports an error on the status
report until both are present.

## What it provides

- **Picker plugin type** `Dsfr4DrupalPicker` (manager `plugin.manager.dsfr4drupal_picker`) with two
  plugins: `icon` and `pictogram`. Scans the DSFR library for the available item set.
- **Field types** `dsfr4drupal_picker_icon`, `dsfr4drupal_picker_pictogram` (+ matching widgets and
  formatters), each with a per-instance *allowed groups* setting and a value constraint.
- **Form/render elements** `dsfr4drupal_picker_icon`, `dsfr4drupal_picker_pictogram` (extend core
  Select), backing the widgets and the CKEditor dialogs.
- **Text-format filters** `dsfr4drupal_picker_icon` / `dsfr4drupal_picker_pictogram` turning
  `<dsfr-icon>` / `<dsfr-pictogram>` tags into rendered markup.
- **CKEditor 5 plugins** `Icon` / `Pictogram` (two toolbar buttons) with dialog forms.
- **SDC components** `dsfr4drupal_picker:icon` and `:pictogram` render icons/pictograms.
- **Twig extension** `PictogramExtension` (`dsfr_pictogram_url` filter, `svg_attributes()` function).
- **Alter hooks** for extending/altering the icon and pictogram sets (see `dsfr4drupal_picker.api.php`).
- No permissions of its own; no Drush. Config schema in `config/schema/dsfr4drupal_picker.schema.yml`.

## Solution docs

- The picker plugin type, `PickerManager`, and the `icon`/`pictogram` plugins →
  [plugins/picker-plugin-type.md](plugins/picker-plugin-type.md)
- Field types, widgets, formatters and the value constraint →
  [fields/fields.md](fields/fields.md)
- Text-format filters + CKEditor 5 plugins (token → markup) →
  [plugins/editor-embed.md](plugins/editor-embed.md)
- Routes, dialog forms and the settings form →
  [config/settings-and-routes.md](config/settings-and-routes.md)
- Render/form elements and allowed-values validation →
  [elements/render-elements.md](elements/render-elements.md)

## Submodules (documented separately)

- `dsfr4drupal_picker_examples` — example configuration demonstrating the picker fields.
- `dsfr4drupal_picker_link` — a link-icon widget attaching a DSFR icon to a link field.
- `dsfr4drupal_picker_media` — a Pictogram media type (+ category vocabulary) for custom pictograms.
