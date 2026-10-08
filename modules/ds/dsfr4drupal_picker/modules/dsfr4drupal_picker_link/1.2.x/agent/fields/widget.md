<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link-with-icon field widget

Adds a DSFR icon picker to core `link` fields.

## Install / enable
- `drush en dsfr4drupal_picker_link -y` (pulls in `dsfr4drupal_picker` and core `link`).
- On any `link` field's **Manage form display**, choose the **Link with DSFR icon** widget (`dsfr4drupal_picker_link_icon`). No config form of its own.

## Widget: `LinkIconWidget`
File: `src/Plugin/Field/FieldWidget/LinkIconWidget.php`. Declared with `#[FieldWidget(id: 'dsfr4drupal_picker_link_icon', label: 'Link with DSFR icon', field_types: ['link'])]`. Extends core `Drupal\link\Plugin\Field\FieldWidget\LinkWidget` and `use`s the parent module's `PickerWidgetTrait` (aliasing `defaultSettings`, `settingsForm`, `settingsSummary`, `formElement` to `trait*`). Each override calls the core `LinkWidget` method and then unions in the trait's result:
- `defaultSettings()` = `LinkWidget::defaultSettings()` + trait defaults (`has_search => TRUE`).
- `settingsForm()` = link settings + the trait's `has_search` checkbox.
- `settingsSummary()` = link summary + trait summary line.
- `formElement()` = the core link element (URL/title) + the trait's picker element.

The trait's `formElement()` adds an `#type => 'dsfr4drupal_picker_icon'`-style picker sub-element seeded with `#allowed_groups` (from field settings) and `#has_search` (from widget settings). Editors thus get the normal link form plus an icon picker.

## Settings trait: `LinkiconWidgetTrait`
File: `src/Plugin/Field/FieldWidget/LinkiconWidgetTrait.php`. A helper trait that re-exports `PickerWidgetTrait::defaultSettings()` with every key prefixed `icon_`, then adds `icon_allowed_groups => []` and `icon_required => FALSE`. (This is the naming scheme reflected in the config schema.)

## How the icon is stored
`dsfr4drupal_picker_link.module` implements `hook_config_schema_info_alter()`: if `field.value.link` `options` mapping exists, it registers an extra `icon` key (`type: string`, label "Icon"). The selected icon's **machine name** is therefore persisted inside the standard link field item's `options` array (`options.icon`) — no new field storage, no separate table. The value is a plain string (an icon identifier), stored as-is.

## Config schema
`config/schema/dsfr4drupal_picker_link.schema.yml` defines:
- `field.widget.settings.dsfr4drupal_picker_link_icon` (extends `field.widget.settings.link_default`): `icon_allowed_groups` (sequence of strings), `icon_has_search` (bool), `icon_required` (bool).
- `field.formatter.settings.dsfr4drupal_picker_link_icon` (extends `field.formatter.settings.link`, `FullyValidatable`): `icon` (string), `icon_display` (string).

Note: this submodule ships only the widget class; the stored `options.icon` string is consumed by theming/the parent module's rendering rather than by a formatter class inside this submodule.
