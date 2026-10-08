<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: context contributors and filters

Both are attribute-discovered plugins the `AuditTrail::event()` pipeline runs per chain. Managers are sealed (`parent: default_plugin_manager`, no alterInfo — the operator surface is the chain edit form, not a hook).

## Context contributors — enrich a row's buckets
- Attribute: `#[ContextContributor(id, label, description, weight)]` (`src/Attribute/ContextContributor.php`).
- Discovered under `<module>/src/Plugin/ContextContributor/`. Manager: `plugin.manager.audit_trail.context_contributor` (`ContextContributorManager`).
- Interface `ContextContributorInterface` / base `ContextContributorBase` (`src/ContextContributor/`). Implement:
  - `applies($channel, $action, AuditTrailSubject $subject, array $context, int $severity): bool` — cheap gate.
  - `contribute(AuditTrailSubject $subject, string $action, array $context): array` — return `['permanent' => [...], 'transient' => [...]]`.
- The orchestrator merges each contributor's output per tier, last-write-wins (higher weight overwrites key-by-key). A throw is caught, reported with `chain: FALSE`, and stamped as `_contributor_errors` in transient — the row still lands minus that contribution.
- Enable per chain via the chain entity's `contributors[]` (ordered `{plugin_id, weight, settings}`). Configurable contributors implement the plugin form methods (e.g. `ParagraphAncestryContributor` exposes `depth_cap`) and declare `audit_trail.context_contributor.<id>` schema.

Snapshot helper: `Drupal\audit_trail\Snapshot\SnapshotDelta` folds `before`/`after` maps into the canonical `_v`/`state`/`delta`/`key_order` shape the detail-page diff renders. `AuditTrail::event()` also auto-folds top-level `before`/`after` bucket keys.

## Filters — drop events before they become rows
- Attribute: `#[AuditTrailFilter(id, label, description, weight)]` (`src/Attribute/AuditTrailFilter.php`).
- Discovered under `<module>/src/Plugin/AuditTrailFilter/`. Manager: `plugin.manager.audit_trail.filter` (`AuditTrailFilterManager`).
- Interface `AuditTrailFilterInterface` / base `AuditTrailFilterBase` (`src/Filter/`). Implement:
  - `shouldEmit($channel, $action, AuditTrailSubject $subject, array $context, int $severity): bool` — FALSE drops.
  - `rejectsSilently(): bool` — when TRUE a rejection also suppresses the non-audit loggers; when FALSE (default) rejected events still reach dblog on a non-`chain_only` chain.
- Filters run before contributors; the first FALSE vote short-circuits (no contributors, no row). A throwing filter fails open (event not suppressed) and is reported.
- Enable per chain via `filters[]`.

### Bundled filters (`src/Plugin/AuditTrailFilter/`)
- `request_method` (`RequestMethodFilter`) — allow/disallow by HTTP method, optionally scoped to `channels[]` / `actions[]`. (Used by `audit_trail_file` to restrict `file_downloaded` to GET/HEAD.)
- `severity` (`SeverityFilter`) — drop events less urgent than a RFC-5424 floor.
