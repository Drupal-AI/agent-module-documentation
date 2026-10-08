<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Brain (droost_brain) — agent index

Per-project knowledge base of the modules installed on THIS site and the patterns each exposes, served
to AI agents as **read-only MCP tools**. Optional Droost submodule. Depends on `droost` (and thus
`mcp_server`). Version **1.0.0-rc1** (dir 1.0.x). Core `^10.3 || ^11 || ^12`. **Local development only.**

## What it provides
- **3 MCP tools** (all `readOnly`, gated by mcp_server's `access mcp server` permission, `{success, message, data}` envelope):
  `droost_architecture`, `droost_capabilities`, `droost_module_patterns`. See [tools/brain-tools.md](tools/brain-tools.md).
- **1 Drush command**: `droost:brain:build` (alias `dbb`) — `BrainCommands`.
- **Services** (`droost_brain.services.yml`): `droost_brain.storage` (`BrainStorage`), `droost_brain.builder`
  (`BrainBuilder`), `droost_brain.harvester` (`RuntimeHarvester`), `droost_brain.staleness` (`BrainStaleness`),
  `droost_brain.seeder`/`droost_brain.seed_reader`, `droost_brain.service_yml_reader`.
- **3 tables** (created lazily on first build, dropped on uninstall): `droost_brain_module`, `droost_brain_pattern`,
  `droost_brain_capability`.
- **No permissions, no routes, no config schema.** hook_install seeds the brain when a seed dataset is present.

## Mechanism (source)
- `RuntimeHarvester` introspects the live container (module list, entity types, services, routes, events, typed config,
  Droost's api/hook scanner) → `BrainBuilder->build()` writes rows via `BrainStorage`.
- `BrainStaleness` fingerprints the module set + git HEAD and reports staleness; tools append its note.
- `BrainSeeder`/`SeedReader` bootstrap from a shipped brain-seed (droost_knowledge) so tools answer before the first build.

## Docs
- The three tools, `drush dbb`, staleness and seeding → [tools/brain-tools.md](tools/brain-tools.md).
