<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Webmaster: Redirect (drush_webmaster_redirect) — agent index

Submodule of **Drush Webmaster** adding `wm:redirect:*` Drush commands for URL-redirect management.
CLI-only: no routes, no permissions of its own, no config. Release **1.0.0-beta1** (beta).

- Deps (`drush_webmaster_redirect.info.yml`): **`drush_webmaster`** + contributed **`redirect`**.
- Command class `RedirectCommands` (extends `DrushCommands` directly — it does **not** use the base
  module's admin-switch base class) → service `drush_webmaster_redirect.redirect_manager`
  (`RedirectManager`, args `@entity_type.manager @path_alias.manager @redirect.repository`).
- Output: mostly `RowsOfFields`/`PropertyList` (table/property formatters) rather than raw YAML.

## What it adds → [drush/redirect.md](drush/redirect.md)

All commands: `wm:redirect:list` (`wm-rl`), `:get` (`wm-rg`), `:search` (`wm-rs`), `:find` (`wm-rf`),
`:add` (`wm-ra`), `:update` (`wm-ru`), `:delete` (`wm-rd`), `:stats` (`wm-rst`), `:import` (`wm-rim`),
`:export` (`wm-rex`). CSV import/export supported; every mutating command takes `--dry-run`.

## Parent

Base module docs: [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md)
