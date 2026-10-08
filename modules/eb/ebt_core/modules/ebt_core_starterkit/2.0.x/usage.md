<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Core Starterkit is a developer submodule of EBT Core that adds a Drush code generator (`drush generate ebt:module`) for scaffolding a brand-new EBT block-type module from the bundled boilerplate.

---

The submodule registers a DrupalCodeGenerator generator, `EbtGenerator`, exposed as the Drush command **`ebt:module`** (alias `ebt-module`, generator type `MODULE_COMPONENT`, label "EBT module"). Running it interviews you for a machine name and human name, then writes a complete new EBT block-type module: `{machine_name}.info.yml`, `{machine_name}.libraries.yml`, a `block_content` type plus its form/view displays and body/`field_ebt_settings` field config under `config/install/`, `block--block-content--*` / `block--inline-block--*` Twig templates, a functional install test, a README, `composer.json`, CSS, and logo assets (all rendered from the Twig templates in the submodule's `generator/` directory). It requires **Drush 12+** (its `hook_requirements` blocks install on older Drush). It depends on `ebt_core`, `block_content`, and `media`, and adds no config, permissions, or plugins of its own beyond the generator. Machine names must use the `ebt_` prefix for the generated block type to work with EBT Core's theme/preprocess plumbing.

---

- Scaffold a new EBT block-type module with a single `drush generate ebt:module` command.
- Generate the boilerplate `block_content` type + field/display config for a new EBT block.
- Produce ready-made `block--block-content--*` and `block--inline-block--*` Twig templates.
- Create a starter `composer.json`, README, libraries file, and CSS for a new EBT module.
- Include a functional `InstallTest` in the generated module.
- Speed up contributing a new EBT block type to the ecosystem.
- Enforce the `ebt_` machine-name convention for compatibility with EBT Core.
- Avoid hand-copying and renaming the starterkit boilerplate.
- Use the alias `ebt-module` as a shorthand for the generator.
- Bootstrap project-specific custom block types that reuse EBT's design-options field.
- Provide a consistent module structure across all EBT block-type modules.
- Generate the `field_ebt_settings` field instance config wired to the new block type.
- Give developers a repeatable starting point rather than a blank module.
- Integrate with Drush 12+'s `generate` command family.
- Keep the generator opt-in (enable the submodule only when scaffolding).
- Render every generated file from versioned Twig templates in `generator/`.
