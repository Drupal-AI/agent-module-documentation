<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Blocks (audit_blocks) — agent index

Analyzes block types, block instances, their placement and cache configuration.

Submodule of the **audit** framework. Depends on: `audit`, `block`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `blocks` — `BlocksAnalyzer` (`src/Plugin/AuditAnalyzer/BlocksAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 2 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `cache_issues` (Cache Configuration), `disabled_blocks` (Disabled Blocks), `block_types` (Custom Block Types), `block_inventory` (Block Inventory).

## Configuration

- No settings of its own.

## Run it

- UI: Reports > Audit > `Audit Blocks` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run blocks` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters blocks`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
