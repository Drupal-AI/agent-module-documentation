<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Bundle Field (entity_bundle_field) — agent index

A dependency-free module that adds one custom **Field API field type**, `entity_bundle`
("Entity bundle reference"), plus its widget and formatter. The field stores a single **bundle
machine name** (a content type, vocabulary, media type, etc.) of a **bundleable entity type** that
the site builder picks in the field settings. Package `Administration`. Core requirement
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.4.

- **The field type, its settings, the widget, the formatter, install/enable, and how to operate it** →
  [fields/entity_bundle.md](fields/entity_bundle.md)

## What it actually is (from source)

Three Field API plugins under `src/Plugin/Field/`, and nothing else — **no** `*.routing.yml`,
`*.permissions.yml`, `*.services.yml`, `*.install`, `*.module`, `composer.json`, `config/`, or
config schema. Requires no modules outside core.

- **Field type** `EntityBundle` (id **`entity_bundle`**, label *"Entity bundle reference"*),
  `src/Plugin/Field/FieldType/EntityBundle.php`, extends core `FieldItemBase`. One column
  `bundles` (`varchar(255)`), `cardinality = 1`, `category = "reference"`,
  `default_widget = entity_bundle_widget`, `default_formatter = entity_bundle_formatter`. Its
  `fieldSettingsForm()` builds a select of every entity type that returns a value from
  `getBundleEntityType()` and stores the chosen entity type id in the `entity_type` field setting
  (`defaultFieldSettings()`).
- **Widget** `EntityBundleWidget` (id **`entity_bundle_widget`**),
  `src/Plugin/Field/FieldWidget/EntityBundleWidget.php`, extends `WidgetBase`. Renders a `select`
  of the configured entity type's bundles (loaded via `entity_type.manager`), storing the selected
  bundle id in `bundles`.
- **Formatter** `EntityBundleFormatter` (id **`entity_bundle_formatter`**, label *"Entity Bundle
  Formatter"*), `src/Plugin/Field/FieldFormatter/EntityBundleFormatter.php`, extends
  `FormatterBase`. Resolves the stored bundle id to its human-readable label via
  `entity_type.bundle.info` and renders it (falls back to *"Undefined"*).

No permissions, no Drush, no hooks, no services. Everything is configured per field in the
standard *Manage fields / Manage form display / Manage display* UI.
