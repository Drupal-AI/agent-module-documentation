<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Wiki — tools, provenance/status model & Drush generators

The wiki is an **OKF markdown bundle** at a project-relative path (`droost_wiki.settings.path`, default
`docs/wiki`), resolved to an absolute path by `WikiSettings` + `ProjectRoot` (the composer root, not
the web-accessible docroot). Each page carries a **provenance manifest** (frontmatter) recording the
source files it covers and their content hashes.

## Read-only MCP tools (`src/Plugin/Tool/`, extend `DroostToolBase`, ungated)

- **`droost_wiki_factsheet`** (`WikiFactsheet.php`) — the generation packet for one module: what an
  agent needs to write or refresh that module's page. Built by `FactsheetBuilder`
  (`droost_wiki.factsheet`).
- **`droost_wiki_pages`** (`WikiPages.php`) — no args: list pages (capped); `page` (a bundle-relative
  `.md` path): read one; `query`: search page content. Reads go through `BundleReader`, which
  **sanitizes the path** (rejects empty, `..`, and non-`.md`) and resolves it with
  **`PathGuard::resolve(bundlePath, file)`** (realpath + containment), then caps content at 16 KB
  (`mb_strcut` + `…(truncated)`). So a `page` argument cannot traverse outside the bundle or read a
  non-markdown file.
- **`droost_wiki_status`** (`WikiStatusTool.php`) — per-page freshness: **fresh** (hashes match),
  **stale** (a covered file changed), **orphaned** (a covered file was deleted), **invalid**
  (malformed provenance block), **unmanaged** (no provenance), plus custom modules no page covers.
  This is the wiki work list. Backed by `WikiStatus` + `FileHasher` + `Okf\FrontmatterParser` /
  `Okf\Provenance` / `Okf\PageMeta`.

## Generation (Drush-driven, not MCP)

- **`drush droost:wiki:status`** — the staleness report (same data as `droost_wiki_status`).
- **`drush droost:wiki:generate`** — composes/generates pages via `PageComposer` + `WikiGenerator`
  (optionally AI-assisted; `WikiGenerator` writes files atomically under the operator-configured bundle
  path, which `ProjectRoot` keeps out of the docroot). Writing is intentionally a CLI operation; the
  MCP surface stays read-only.

## Config, routing, permission

- Config `droost_wiki.settings` (`config/install`, schema `config/schema`): `enabled: true`,
  `path: 'docs/wiki'`.
- Settings form `Form\SettingsForm` at `/admin/config/development/droost-wiki`, permission
  **`administer droost wiki`** (`restrict access: true`); menu link under *Configuration → Development*.
