<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost (droost) — agent index

Local-development toolkit that exposes Drupal application/codebase introspection plus a tiered, gated
write/exec surface to AI coding agents over **MCP**. The Drupal analog of Laravel Boost. Built on
`drupal/mcp_server` (its runtime + `#[Tool]` plugin system); Droost supplies the tools. Version
**1.0.0-rc1** (version-dir `1.0.x`). Core `^10.3 || ^11 || ^12`, PHP `^8.3`. License GPL-2.0-or-later.

**Local development only.** Install with `composer require --dev`; enable only on local/trusted
environments. State-changing tools are off by default and are not a security boundary against an
untrusted caller — never enable on production or an internet-reachable site.

## Depends on

- `mcp_server` (module dependency) — supplies the MCP transport and the `Tool` plugin type/attribute.
- `drush/drush` `^12 || ^13` (composer) — the CLI/STDIO transport and the `droost:*` commands.

## What it provides

- **~40 base MCP tools** (`Drupal\droost\Plugin\Tool\*`), each an `#[Tool]` plugin returning a
  `{success, message, data}` envelope. Read tools extend `DroostToolBase`; write/exec tools extend
  `DestructiveToolBase`.
- **1 config object**: `droost.settings` (seven boolean gate flags; schema in `config/schema/`).
- **Settings form** at `/admin/config/development/droost` (route `droost.settings`, permission
  `administer droost`); menu link under *Configuration → Development*.
- **Permissions**: `administer droost`, `use droost destructive tools`, `use droost eval`
  (`droost.permissions.yml`).
- **Drush commands** (`src/Drush/Commands/`): `droost:install`, `droost:uninstall`, `droost:doctor`,
  `droost:scaffold`, `droost:skills:emit`.
- **hook_requirements** (`droost.install`): knowledge freshness, a config-wipe canary, and a warning
  when dangerous flags are on.
- **Security-core helpers** (`src/`): `GateFlag`, `PathGuard`, `SecretRedactor`, `ProjectRoot`,
  `Sql/SqlVerb`.
- **Services** (`droost.services.yml`): project root, verify runner, guideline/skill/module-doc
  providers, service inspector, doctor + refresh queue, scaffold blueprint registry, harness registry.
- **13 submodules** — see below.

## Solution docs

- Read-only introspection tools → [tools/read-tools.md](tools/read-tools.md)
- The tier/gate model + all write & PHP-eval tools → [tools/write-tools.md](tools/write-tools.md)
- Scaffold blueprints, structure authoring, verify loop → [tools/scaffold-verify.md](tools/scaffold-verify.md)
- Config object, schema, routing, permissions, requirements → [config/settings.md](config/settings.md)
- Drush `droost:install` + harness installers + skills → [harness/install.md](harness/install.md)

## Submodules (each documented under `modules/<name>/1.0.x/`)

`droost_ai`, `droost_brain`, `droost_canvas`, `droost_devel`, `droost_display`, `droost_examples`,
`droost_help`, `droost_knowledge`, `droost_playbook`, `droost_profiler`, `droost_search`,
`droost_views`, `droost_wiki`. (Documented here: `droost_ai`, `droost_search`, `droost_devel`,
`droost_canvas`, `droost_views`, `droost_wiki`.)
