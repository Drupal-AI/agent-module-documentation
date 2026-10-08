<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Locator (module_locator) — agent index

Adds a **Location** (filesystem path) line to every module on the core **Extend** page
(`/admin/modules`). Version 2.0.2. A UI-only developer/admin diagnostic — no config, no routes,
no permissions, no services, no external calls, no stored data.

## What it does
- Alters the core `system_modules` form to attach each module's path from the
  `extension.list.module` service (`hook_form_system_modules_alter`).
- Overrides the `system_modules_details` theme with its own `system_modules_details_alter`
  hook + Twig template so the path renders inside each module's details block.

## Dependencies
- Drupal core only (`core_version_requirement: ^8 || ^9 || ^10 || ^11`). No contrib deps,
  no Composer requirements, no libraries.

## Provides
- Hooks (in `module_locator.module`): `hook_help`, `hook_theme`,
  `hook_theme_suggestions_HOOK_alter`, `hook_preprocess_HOOK`, `hook_form_FORM_ID_alter`.
- Theme hook `system_modules_details_alter` (template
  `templates/system-modules-details-alter.html.twig`).
- No entities, plugins, routes, permissions, services, config, or Drush commands.

## Access
- Reuses core's Extend page, which requires the core `administer modules` permission. The
  module defines no access controls of its own.

## Install / operate
- `drush en module_locator -y`, then open `/admin/modules`; each module's details show
  `Location: <path>`. Nothing to configure.

## Solution docs
- [agent/api/form-alter.md](api/form-alter.md) — how the form alter, theme override, and
  preprocess hook work together.
