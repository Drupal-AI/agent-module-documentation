<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Wiki (droost_wiki) — agent index

Submodule of **Droost**: substrate for an agent-maintained codebase wiki (an OKF markdown bundle with
per-page provenance). Version 1.0.0-rc1 (dir `1.0.x`). Core `^10.3 || ^11 || ^12`, PHP `^8.3`. Depends
on `droost`. Provides a settings form, config schema, a permission, and Drush commands. Local dev only.

## MCP tools (`src/Plugin/Tool/`, all read-only, ungated)

- **`droost_wiki_factsheet`** — the generation packet for one module (what an agent needs to write/
  refresh its page). Backed by `FactsheetBuilder` (`droost_wiki.factsheet`).
- **`droost_wiki_pages`** — no args: list pages; `page` (bundle-relative `.md` path like
  `modules/my_module.md`): read one; `query`: grep across pages. Every read is **PathGuard-contained**
  (via `BundleReader`, which rejects `..` and non-`.md`) and **byte-capped at 16 KB** with a
  truncation marker.
- **`droost_wiki_status`** — per-page freshness: fresh / stale / orphaned / invalid / unmanaged, plus
  custom modules no page covers. The wiki work list. Backed by `WikiStatus`.

## Drush commands (`src/Drush/Commands/WikiCommands.php`)

- **`drush droost:wiki:status`** — the staleness report.
- **`drush droost:wiki:generate`** — compose/generate pages (`PageComposer` + `WikiGenerator`,
  optionally AI-assisted; writes files under the bundle path).

## Config, routing, permissions, services

- Config `droost_wiki.settings`: `enabled: true`, `path: 'docs/wiki'` (schema in `config/schema/`).
  Resolved to an absolute path via `WikiSettings` + `ProjectRoot` (project root, not the docroot).
- Route `droost_wiki.settings` at `/admin/config/development/droost-wiki`
  (`Form\SettingsForm`, permission **`administer droost wiki`**, `restrict access: true`).
- Services: `droost_wiki.settings`, `.hasher` (`FileHasher`), `.frontmatter`
  (`Okf\FrontmatterParser`), `.bundle_reader` (`BundleReader`), `.status`, `.factsheet`, `.composer`
  (`PageComposer`), `.generator` (`WikiGenerator`).

## Solution doc

- The three tools, the provenance/status model, the Drush generators → [tools/wiki.md](tools/wiki.md)
