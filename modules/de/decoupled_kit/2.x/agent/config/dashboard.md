<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard form, config object, routes & permission

## Route & permission

`decoupled_kit.dashboard` (`decoupled_kit.routing.yml`):

```yaml
path: '/admin/config/services/decoupled-kit/dashboard'
defaults:
  _form: 'Drupal\decoupled_kit\Form\DashboardForm'
requirements:
  _permission: 'administer site configuration'
options:
  _admin_route: TRUE
```

Menu link `decoupled_kit` (`decoupled_kit.links.menu.yml`) places it under
`system.admin_config_services` (Configuration → Web services). `info.yml` sets
`configure: decoupled_kit.dashboard`.

## Config object & schema

- Config: `decoupled_kit.config` with a single key `current_path` (string). Install default
  `current_path: "/"` (`config/install/decoupled_kit.config.yml`). Schema
  `decoupled_kit.config` typed `config_entity` with `current_path` string
  (`config/schema/decoupled_kit.schema.yml`).

## Form behavior (`DashboardForm`)

- `buildForm()` seeds the **Current path** textfield from `?current_path`, else the stored
  `decoupled_kit.config:current_path`, else `/`, normalized via `decoupledKit->canonicalPath()`.
- When `decoupled_kit_block` is enabled it adds a collapsed **Blocks options** details group: a
  **Theme** select (all installed themes) with an AJAX callback `updateRegionsCallback` that
  refreshes a **Regions** checkboxes list (regions come from
  `theme_handler->getTheme($theme)->listVisibleRegions()`, via `DeprecationHelper` for pre-11.4).
- `submitForm()` saves `current_path` (canonicalized) into `decoupled_kit.config`, then redirects
  back to the dashboard with `current_path` (and `current_theme` / `selected_regions` when set) as
  query args.
- `getTableRows()` builds a **Table of functions**: one target-blank link per enabled resource —
  `decoupled_kit.router` always; `decoupled_kit.block` and `decoupled_kit.redirect` when their
  submodules are enabled — each pre-filled with the chosen `current_path` (and theme/regions for
  the block link). The dashboard is purely a preview/inspection tool; it stores only `current_path`.

## Operating it

1. `drush en decoupled_kit -y` (optionally the submodules).
2. Visit `/admin/config/services/decoupled-kit/dashboard` as a user with
   `administer site configuration`.
3. Enter a front-end path, pick a theme/regions if the block submodule is on, **Set parameters**,
   then click the generated links to inspect each JSON endpoint.
