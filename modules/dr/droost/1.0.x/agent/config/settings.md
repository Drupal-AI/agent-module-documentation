<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost configuration, routing, permissions & requirements

## Install & enable

`composer require --dev 'drupal/droost' 'drupal/mcp_server:^2.0@alpha'` then `drush en droost -y`.
Wire it to an agent with `drush droost:install` (see [../harness/install.md](../harness/install.md)).
Depends on the `mcp_server` module; needs PHP `^8.3`, Drush `^12 || ^13`, core `^10.3 || ^11 || ^12`.

## Config object `droost.settings`

Seven boolean gate flags, all `false` by default (`config/install/droost.settings.yml`; schema
`config/schema/droost.schema.yml`, type `config_object`):

| Key | Meaning |
| --- | --- |
| `allow_destructive` | master — arms every write category below (never eval) |
| `allow_scaffold` | scaffold + structural authoring tools |
| `allow_entity_write` | entity create/update/delete (+ Canvas trees, generated content) |
| `allow_db_write` | raw SQL INSERT/UPDATE/DELETE tiers |
| `allow_config_write` | config-write tools (set config, compose displays/views) |
| `allow_module_ops` | module install/uninstall, cron run |
| `allow_eval` | the PHP eval tool |

All are read through `GateFlag::enabled()` (so the string `"false"` counts as disabled). See
[../tools/write-tools.md](../tools/write-tools.md) for how each flag gates its tools.

## Settings form

`Drupal\droost\Form\SettingsForm` (extends `ConfigFormBase`, form id `droost_settings`), a checkbox per
flag with `#default_value` computed via `GateFlag::enabled()`. Route **`droost.settings`** at
`/admin/config/development/droost`, permission **`administer droost`**; menu link under *Configuration
→ Development* (`droost.links.menu.yml`). This is the only admin UI; day-to-day operation is via Drush
and the agent harness.

## Permissions (`droost.permissions.yml`, all `restrict access: true`)

- **`administer droost`** — configure Droost (guards the settings route).
- **`use droost destructive tools`** and **`use droost eval`** — *reserved for future per-tool HTTP
  gating*. Their own descriptions state that **MCP Server does not currently check tool-level
  permissions** — only the `droost.settings` flags gate these tools at runtime, so keep the server
  STDIO-only. (The `droost_ai` submodule's AI-function-call bridge *does* enforce a permission.)

## `hook_requirements` (`droost.install`, runtime phase)

Surfaces three things on the status report: (1) **knowledge freshness** — the `droost.doctor` verdict
(warning if a store needs a rebuild); (2) a **config-wipe canary** — warns when `droost.settings` is
absent from active config (a `drush cim` from a pre-Droost sync source drops it, silently resetting
gates and usually the MCP server config too — KNOWN_LIMITATIONS #2); (3) **dangerous flags** — lists
any enabled gate flag, at **error** severity when `allow_eval` is on (RCE-class), warning otherwise.

## Services & hooks

`droost.services.yml` registers the project root, verify runner, guideline/skill/module-doc providers,
service inspector, git-head reader, refresh queue, doctor, scaffold blueprint registry (15+ blueprints)
and the harness registry. `droost.module` implements only `hook_help()`, delegating to the autowired
`Drupal\droost\Hook\DroostHooks` service (`#[LegacyHook]`, OOP hook style).
