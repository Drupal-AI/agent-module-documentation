<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Core Starterkit — agent index

Developer submodule of EBT Core: adds a Drush generator that scaffolds a new EBT block-type
module. No config, permissions, or plugins of its own beyond the generator.

- **The `ebt:module` generator: command, what it produces, requirements** →
  [drush/ebt-module-generator.md](drush/ebt-module-generator.md)

Key facts:
- Drush command `drush generate ebt:module` (alias `ebt-module`), from the
  DrupalCodeGenerator generator `Drupal\ebt_core_starterkit\Drush\Generators\EbtGenerator`
  (type `MODULE_COMPONENT`).
- Prompts for machine name + human name; use an `ebt_` prefix so the generated block type works
  with EBT Core's theme/preprocess plumbing.
- Generates a full module: info/libraries yml, `block_content` type + form/view display +
  body/`field_ebt_settings` field config, Twig templates, InstallTest, README, composer.json, CSS.
- Requires **Drush 12+** (`hook_requirements` blocks install otherwise).
