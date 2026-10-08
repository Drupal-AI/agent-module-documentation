<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Knowledge — deprecations tool, ledger & served facts

## Enable
```bash
drush en droost_knowledge -y   # depends only on droost; the droost_cms recipe enables it by default
```

## `droost_deprecations` (read-only) — `src/Plugin/Tool/Deprecations.php`
Gated by mcp_server `access mcp server`; returns `{success, message, data}`. Inputs:
- `symbol` — exact lookup (FQCN, `FQCN::member`, function/hook name). Hit -> `{match: {deprecated_in, removed_in,
  replacement, change-record URL, ...}}`; miss -> a success envelope saying nothing is recorded, with `stats`.
- `search` — substring match over symbols (used when `symbol` is empty), capped at 25 rows.
- neither -> ledger `stats` (`major`, `rows`, `schema`, `core_version`).

## The ledger (`DeprecationLedger`, service `droost_knowledge.ledger`)
Lazy-loads `data/deprecations/<major>.json`, where `<major>` is derived from `\Drupal::VERSION` via
`GuidelineProvider::deriveMajor()`. Reads the file with `file_get_contents` on a path built from the module's own
install path + the derived numeric major (no caller-supplied path). Any miss — `''` major, missing file, malformed
JSON — yields an empty index whose `stats()` reports `rows: 0`; it never throws. Fully offline (zero network).

## Site-planning topic
`guidelines/topics/site-planning.md` (construct vocabulary, field-storage reuse, ships-disabled components) is
discovered by the base module's `GuidelineProvider` and served via the base **`droost_guidelines`** tool
(`topic: site-planning`).

## Brain seed
`data/brain-seed/<major>.yml` bootstraps `droost_brain` before its first build: `droost_knowledge_install()` calls
`BrainSeeder::seedOnly()` only when droost_brain is installed and **not** already harvested
(`BrainStaleness::builtTime()` guard), so a real brain build is never clobbered.

## Maintainer ETL (adopters never run this)
`drush droost:knowledge:etl` (alias `dket`, `KnowledgeCommands::etl()`) uses `CoreDeprecationExtractor`
(+ `DeprecationParser`/`DeprecationVisitor`, `nikic/php-parser` — a dev dependency) to walk the installed core tree
and regenerate the ledger. It writes **only** under `droost_knowledge/data/`, is deterministic (re-running yields an
identical file), and is meant to run per core major at release time.
