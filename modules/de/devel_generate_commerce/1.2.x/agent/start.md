<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Devel Generate Commerce (devel_generate_commerce) — agent index

A **development-only** tool that adds a `commerce` **Devel Generate** plugin to bulk-create dummy
Drupal Commerce content: product types (+ variation types), products, product variations and
orders. Package `Development`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.2.0.

Depends on: `commerce`, `devel`, `devel_generate`, `commerce_order`, `commerce_product`,
`commerce_checkout`, `commerce_store`, `commerce_price`. Composer: `drupal/commerce >=3.2`,
`drupal/devel >=4.1`.

- **The generate plugin, its settings, the admin form and the Drush command, plus how it builds each
  entity** → [plugins/commerce-generate.md](plugins/commerce-generate.md)

## What it actually is

- One class: `CommerceDevelGenerate` (`src/Plugin/DevelGenerate/CommerceDevelGenerate.php`),
  a `@DevelGenerate` plugin with **id `commerce`**, `url = "commerce"` and
  `permission = "administer devel_generate_commerce"`, extending `DevelGenerateBase`. Devel Generate
  provides the route `admin/config/development/generate/commerce` and its access check from that
  `permission` key.
- One Drush command class: `CommerceDevelGenerateCommand` (`src/Commands/…`) extending devel_generate's
  `DevelGenerateCommands`. Command `devel-generate:commerce`, aliases `gencom` /
  `devel-generate-commerce`, `@pluginId commerce`. Registered in `drush.services.yml` as
  `develgenerate.commands` (arg `@plugin.manager.develgenerate`).
- One permission: **`administer devel_generate_commerce`** (`devel_generate_commerce.permissions.yml`),
  which also pulls in devel_generate's `permission_callbacks`.
- No config objects, **no config schema**, no `config/install`, no hooks, no services beyond the Drush
  command, no front-end/runtime behaviour. Settings are the plugin annotation defaults, persisted the
  way Devel Generate persists its plugin settings.

## Provides

- **DevelGenerate plugin** `commerce` — the only functional surface.
- **Route** (from devel_generate): `admin/config/development/generate/commerce`.
- **Drush command** `devel-generate:commerce` (`gencom`).
- **Permission** `administer devel_generate_commerce`.

## Notes

- Purely for dev/test environments — it mass-creates and (with `kill`) mass-**deletes** commerce
  entities. See the plugin doc for the exact entities touched and the settings/options.
