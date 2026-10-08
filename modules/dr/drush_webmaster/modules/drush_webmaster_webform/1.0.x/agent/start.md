<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Webmaster: Webform (drush_webmaster_webform) — agent index

Submodule of **Drush Webmaster** adding `wm:webform:*` + `wm:webform:submission:*` Drush commands.
CLI-only: no routes, no permissions of its own, no config. Release **1.0.0-beta1** (beta).

- Deps (`drush_webmaster_webform.info.yml`): **`drush_webmaster`** + contributed **`webform`**.
- Command class `WebformCommands` (extends `DrushCommands` directly — does **not** use the base
  module's admin-switch base class) → service `drush_webmaster_webform.webform_manager`
  (`WebformManager`, arg `@entity_type.manager`).
- Output: YAML (`Yaml::dump`) and `RowsOfFields` for lists.

## What it adds → [drush/webform.md](drush/webform.md)

Forms: `wm:webform:list` (`wm-wfl`), `:get` (`wm-wfg`), `:export` (`wm-wfe`), `:duplicate`
(`wm-wfdup`), `:delete` (`wm-wfd`, `--force`). Submissions: `wm:webform:submission:list` (`wm-wfsl`),
`:get` (`wm-wfsg`), `:delete` (`wm-wfsd`), `:purge` (`wm-wfsp`). Mutating commands take `--dry-run`.

## Parent

Base module docs: [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md)
