<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Knowledge (droost_knowledge) — agent index

The version-keyed Drupal knowledge pack (Tier 0): offline served facts — a site-planning topic, a shipped
deprecation ledger, and a brain-seed. Depends only on `droost`. Version **1.0.0-rc1** (dir 1.0.x).
Core `^10.3 || ^11 || ^12`. Local development only.

## What it provides
- **1 MCP tool**: `droost_deprecations` (read-only; gated by mcp_server `access mcp server`) — offline core-deprecation
  lookup. See [tools/deprecations.md](tools/deprecations.md).
- **1 guideline topic**: `guidelines/topics/site-planning.md` — served via the base `droost_guidelines` tool.
- **Shipped datasets**: `data/deprecations/<major>.json` (the ledger), `data/brain-seed/<major>.yml` (droost_brain seed).
- **Services**: `droost_knowledge.ledger` (`DeprecationLedger`, runtime reader), `droost_knowledge.extractor`
  (`CoreDeprecationExtractor`, maintainer ETL).
- **1 Drush command** (maintainer-only): `droost:knowledge:etl` (alias `dket`) — regenerates the ledger.
- **No routes, permissions, or config schema.** `hook_install` seeds droost_brain when present (guarded).

## Mechanism (source)
- `DeprecationLedger` lazy-loads the running core major's JSON (major from `GuidelineProvider::deriveMajor()`) and
  answers `lookup()` / `search()` / `stats()`; misses yield an empty ledger, never an error.
- `Deprecations` tool wraps the ledger in the `{success, message, data}` envelope.
- `CoreDeprecationExtractor` (+ `DeprecationParser`/`DeprecationVisitor`, `nikic/php-parser`) walks core to build the
  dataset; `KnowledgeCommands::etl()` writes only under `data/`.

## Docs
- The deprecations tool, the ledger, the site-planning topic, and the ETL → [tools/deprecations.md](tools/deprecations.md).
