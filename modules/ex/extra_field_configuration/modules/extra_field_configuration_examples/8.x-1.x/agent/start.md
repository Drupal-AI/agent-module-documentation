<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field Configuration Examples (extra_field_configuration_examples) — agent index

Optional submodule of **extra_field_configuration**. Ships two sample `@ExtraFieldDisplay` plugins
that opt into the parent module's deriver, so they appear as selectable providers on
`/admin/structure/extra-field`. Pure demonstration/reference code. Version **8.x-1.2**. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later.

## Dependencies

Core `field`; contrib `extra_field:extra_field`; parent
`extra_field_configuration:extra_field_configuration`.

## What it provides

- `Plugin\ExtraField\Display\ExampleField` — id `example_configurable_field`, extends
  `ExtraFieldDisplayBase`, `view()` returns static `#markup`.
- `Plugin\ExtraField\Display\ExampleFormattedField` — id `example_configurable_formatted_field`,
  extends `ExtraFieldDisplayFormattedBase`, `viewElements()` returns static `#markup`, plus
  `getLabel()` / `getLabelDisplay()` ("above").

Both declare `deriver = ExtraFieldConfigurationDeriver` and inject `string_translation` via
`ContainerFactoryPluginInterface`. No routes, permissions, config, schema, services or hooks.

## Solution doc

- **The two example plugins in detail** → [plugins/example-fields.md](plugins/example-fields.md)

Parent module: [../../../../8.x-1.x/agent/start.md](../../../../8.x-1.x/agent/start.md).
