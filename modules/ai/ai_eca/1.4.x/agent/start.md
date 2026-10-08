<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI ECA integration (ai_eca) — agent index

**DEPRECATED** submodule of the **`ai`** project. Version **1.4.x** (installed 1.4.8). Core
`^10.3 || ^11`. License GPL-2.0-or-later. `lifecycle: deprecated`, removed in **AI 2.0.0**
(issue [3503947](https://www.drupal.org/project/ai/issues/3503947)).

The ECA AI action/condition plugins this module used to provide were extracted to the standalone
contributed module **`drupal/ai_integration_eca`** in AI 1.2.0. The installed 1.4.x code is a
**migration shim only** — no plugins, routes, services, permissions or config schema.

## What is actually on disk

Only two files:

- `ai_eca.info.yml` — `lifecycle: deprecated`; deps `ai:ai`, `drupal:file`, `eca:eca`,
  `eca_content:eca_content`; `package: AI`; core `^10.3 || ^11`.
- `ai_eca.install` — one update hook, `ai_eca_update_11001()`. See
  [migration/deprecation.md](migration/deprecation.md).

There is **no `src/`**, no `*.routing.yml`, no `*.services.yml`, no `*.permissions.yml`, no
`config/`. It provides no runtime behaviour of its own.

## The update hook (the only code)

`ai_eca_update_11001()` in `ai_eca.install` (admin-run, via `drush updatedb` / update.php):

1. Iterates all `eca` config entities; for each, rewrites `dependencies.module`
   `ai_eca` -> `ai_integration_eca` (and `ai_eca_agents` -> `ai_integration_eca_agents`) and each
   action `plugin` id `ai_eca_*` -> `ai_integration_eca_*`. If the new plugin id has no definition,
   it logs a warning and drops that action.
2. Installs `ai_integration_eca` if present but not enabled; if the module is **not** on disk it
   throws, telling the operator to `composer require drupal/ai_integration_eca` and retry.
3. Uninstalls `ai_eca` once `ai_integration_eca` is active.

## Migration

For current AI-driven ECA automation use **`drupal/ai_integration_eca`** instead. Full detail:
[migration/deprecation.md](migration/deprecation.md).
