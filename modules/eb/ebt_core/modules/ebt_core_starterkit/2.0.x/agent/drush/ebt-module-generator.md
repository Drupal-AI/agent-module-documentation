<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ebt:module` Drush generator

## Command

```bash
drush generate ebt:module        # alias: drush generate ebt-module
```

Provided by `Drupal\ebt_core_starterkit\Drush\Generators\EbtGenerator`, a
DrupalCodeGenerator `BaseGenerator` registered with the `#[Generator]` attribute:

- name: `ebt:module`
- aliases: `ebt-module`
- description: "Generates Extra Block Type (EBT) module"
- type: `GeneratorType::MODULE_COMPONENT`
- label: "EBT module"
- templatePath: the submodule's `generator/` directory (Twig templates).

## Requirements

**Drush 12+.** `ebt_core_starterkit_requirements()` (install phase) returns a blocking error
if the detected Drush major version is < 12, so the submodule will not install on older Drush.
Depends on `ebt_core`, `block_content`, and `media`.

## What it asks / generates

The generator interviews for a **machine name** (`askMachineName()`) and **human name**
(`askName()`), derives `machine_name_with_dashes`, then writes (rendered from `generator/*.twig`):

- `{machine_name}.info.yml`, `{machine_name}.libraries.yml`
- `config/install/block_content.type.{machine_name}.yml`
- `config/install/core.entity_form_display.block_content.{machine_name}.default.yml`
- `config/install/core.entity_view_display.block_content.{machine_name}.default.yml`
- `config/install/field.field.block_content.{machine_name}.body.yml`
- `config/install/field.field.block_content.{machine_name}.field_ebt_settings.yml`
- `templates/block--block-content--{machine_name_with_dashes}.html.twig`
- `templates/block--inline-block--{machine_name_with_dashes}.html.twig`
- `tests/src/Functional/InstallTest.php`
- `logo.png`, `logo.svg`, `.gitignore`, `README.md`, `composer.json`, `css/styles.css`

The result is a self-contained EBT block-type module: a new `block_content` bundle wired with
a body field and the EBT design-options field (`field_ebt_settings`, storage from `ebt_core`),
plus its own templates.

## Conventions

- **Use an `ebt_` prefix** for the machine name (e.g. `ebt_cards`, `ebt_tabs`). EBT Core's
  `hook_theme_registry_alter` / `hook_preprocess_block` only apply to `ebt_`-prefixed bundles,
  so a non-prefixed name will not get the automatic templates/design rendering.
- After generating, install the new module like any Drupal module; if contributing it, export
  the resulting config back into its `config/install/`.

## Verifying the generator is available

```bash
drush generate | grep ebt          # lists 'ebt:module'
```
