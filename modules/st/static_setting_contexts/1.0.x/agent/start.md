<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Setting Contexts — agent index

Bridges the `owenbush/static-settings` PHP API to Drupal's Condition system: define static settings as
enum plugins, use them as visibility/context conditions. No admin UI, no permissions, no Drush.

- **Defining a StaticSettings enum plugin and using the Condition plugin (autoloader gotcha, evaluate logic)** → [plugins/static-settings.md](plugins/static-settings.md)

Key facts:
- Plugin type `static_setting_contexts`: attribute `#[StaticSettings(id, label, description)]`, base
  interface `StaticSettingsInterface`, discovered under `src/Plugin/StaticSettings`. Plugins are PHP
  `enum`s implementing the package's `BaseStaticSettingInterface`.
- Condition plugin id `static_setting_contexts_static_settings` ("Static Settings") — checkbox group
  per setting; `evaluate()` compares the live `StaticSettings::get(class)->name` against selected
  case names (AND across settings, supports negation).
- Value is resolved in PHP (not stored in config); requires PSR-4 autoload for your
  `Plugin/StaticSettings` namespace.
