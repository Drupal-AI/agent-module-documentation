<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BackFillQuery plugins

Plugin type `BackFillQuery` (annotation `Drupal\backfill_formatter\Annotation\BackFillQuery`, manager `plugin.manager.backfill_formatter_query`, base `BackFillQueryPluginBase`). Handlers under `src/Plugin/BackFillQuery/`: `NodeHandler`, `MediaHandler`, `CommentHandler`, `TermHandler`, `UserHandler`, `DefaultHandler`, `PermissionStatusHandler`. The type is derived per entity type via `BackFillQueryEntityTypeDeriver`.

The `BackFillTerms` service (`findMatchingEntitiesByTerms` / `queryMatchingEntities`) builds a `database->select('taxonomy_entity_index', 'tei')` query, counts matching `tid`s per candidate `entity_id`, orders by match count DESC, applies bundle/exclude conditions and an optional `$query_callback`/alter hook, and returns the top matches. All conditions use the parametrized query API (values passed as `IN`/`NOT IN` arrays) — no string concatenation. Rendering enforces per-entity access via cached access checks in the formatter.

To customise selection, add a handler plugin for your entity type or pass a query callback that mutates the select query before execution.
