<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field as Plugin (efap) — agent index

Defines a **plugin type for entity-display "extra fields"** (pseudo-fields). Instead of writing
`hook_entity_extra_field_info()` + `hook_entity_view()` by hand, a developer declares each extra
field as an annotated plugin class in `src/Plugin/ExtraField/` of any module. efap discovers them
and wires them into displays. Package `Code`. No config UI, no permissions, no runtime module
dependencies. Core `^8 || ^9 || ^10 || ^11`. Version 8.x-2.4. License GPL-2.0-or-later.

Composer package name is `drupal/extra_field_as_plugin`; drupal.org project id is `efap`.

## What it provides (from source)

- **Plugin type** `extra_field`: manager service `efap.plugin_manager`
  (`ExtraFieldPluginManager`, `efap.services.yml`) scanning subdir **`Plugin/ExtraField`**, annotation
  `@ExtraField` (`src/Annotation/ExtraField.php`), interface `ExtraFieldInterface`
  (`info()`, `view()`), abstract base `ExtraFieldBase`.
- **Two hooks** (`efap.module`) that drive every discovered plugin:
  `efap_entity_extra_field_info()` calls each plugin's `info()`;
  `efap_entity_view()` calls each plugin's `view()` when the display component is enabled.
- **Optional Drupal Console generator** `generate:efap` (`GenerateCommand`, `Generator`,
  `templates/ExtraField.php.twig`, wired in `console.services.yml`) — scaffolds a plugin class. Not
  Drush; requires the (deprecated) Drupal Console.

## Solution docs

- **The plugin type — interface/base/manager/annotation, the two hooks, and how to write a
  plugin** → [plugins/extra-field.md](plugins/extra-field.md)
- **The `generate:efap` Drupal Console scaffolder** → [tools/generate-command.md](tools/generate-command.md)

Developer/API only: a plugin's rendered output is developer-controlled, so escaping and any access
checks live in that plugin code — efap has no content or access role of its own.
