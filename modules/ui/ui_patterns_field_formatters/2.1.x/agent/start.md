<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Field Formatters (ui_patterns_field_formatters) — agent index

Exposes **UI Patterns (1.x) components as Drupal field formatters**. On a field's "Manage
display", pick a pattern, then map field properties (raw value, label, formatted output) onto the
pattern's fields/props — no custom field template needed. Version **2.1.0**, branch `2.1.x`.

Dependencies (see `.info.yml`): `field_formatter:field_formatter` and `ui_patterns:ui_patterns`.
This branch targets **UI Patterns 1.x** (`drupal/ui_patterns:^1.0@RC`) + Field Formatter
(`drupal/field_formatter:^3.0@RC`); the UI Patterns 2.x / SDC stack ships its own separate
`ui_patterns_field_formatters` submodule inside the `ui_patterns` project.

- **No settings page.** `configure` route: none. Configuration is per-field, in the formatter
  settings on each entity view display.
- Provides no permissions, no drush commands, no routes, no services, no plugin *types* of its own.
- Provides: 2 field formatter plugins, 2 UI Patterns *source* plugins, config schema.

## What you'd do

- **Render a field through a pattern (map field values → pattern props)** →
  [fields/formatters.md](fields/formatters.md)
- **Understand / extend the field-property sources you can map from** →
  [plugins/source-plugins.md](plugins/source-plugins.md)

## Key facts (real machine names)

- Field formatters: `pattern_all_formatter` ("Pattern (one for all)",
  `PatternOneForAllFormatter`) and `pattern_each_formatter` ("Pattern (one for each)",
  `PatternOneForEachFormatter`). Both extend `field_formatter`'s `FieldWrapperBase`.
- `hook_field_formatter_info_alter()` sets both formatters' `field_types` to **every** field type,
  so they appear on all fields.
- Source plugins (`@UiPatternsSource`, tag `field_properties`): `field_meta_properties`
  (`FieldMetaPropertiesSource`) and `field_raw_properties` (`FieldRawPropertiesSource`).
- Config schema keys (`config/schema/ui_patterns_field_formatters.schema.yml`):
  `field.formatter.settings.pattern_all_formatter` (extends `field.formatter.settings.field_link`)
  with `pattern`, `pattern_variant`, `pattern_mapping` (weight/destination/plugin/source),
  `pattern_settings`, `variants_token`; `pattern_each_formatter` inherits it.
- Managers used: `plugin.manager.ui_patterns`, `plugin.manager.ui_patterns_source`.
- Update hooks (`.install`): `_9001/_9002` clean legacy settings, `_9200` installs
  `field_formatter`, `_9201` converts the old `pattern_formatter` /
  `pattern_wrapper_entity_reference_formatter` config to the current two-formatter split.
