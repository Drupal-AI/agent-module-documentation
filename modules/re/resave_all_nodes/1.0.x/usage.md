<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Resave All Nodes re-saves every node, or every node of chosen content types, through Batch API — the standard way to make presave logic that was added after content already existed actually take effect on that content.

---

A great deal of Drupal behaviour hangs off `hook_ENTITY_TYPE_presave()`, `hook_ENTITY_TYPE_update()` and friends: Pathauto generates aliases, Search API queues items for indexing, computed and denormalised fields populate, Metatag defaults resolve, media usage is recorded. All of it runs on save, so content created before the logic existed simply does not have it. The fix is to touch every node, and a naive loop times out on any real site. This module supplies the batched version twice: a form at `/admin/config/development/resave-all-nodes` with a content-type checklist and a chunk-size field, and a Drush command `resave-all-nodes` (alias `ran`) for CI or long runs. Both share one batch class (`ResaveAllNodesBatch`) that loads nodes in chunks, calls `$node->save()`, and additionally saves each non-default translation. It is a heavy, wide-reaching operation — every save re-fires update hooks, may create a revision, and re-populates queues — so on a large site the Drush path is the one to prefer.

---

- Generate path aliases for content created before Pathauto was installed.
- Re-index existing content into Search API after a configuration change.
- Populate a computed field added to a content type later.
- Apply new Metatag defaults to existing nodes.
- Re-run custom presave logic after deploying a new hook.
- Refresh denormalised or derived field values across all content.
- Trigger media usage tracking retroactively.
- Rebuild derived data for one content type only, via the type checklist.
- Run the resave from Drush inside a CI or deployment pipeline.
- Avoid PHP timeouts that a manual resave loop would hit.
- Backfill a field default onto content missing it.
- Re-fire workflow or state transitions that run on save.
- Recalculate a rating, score, or aggregate field.
- Regenerate rendered summaries after a text-format change.
- Reprocess content after a migration import.
- Refresh entity-reference denormalisation after data cleanup.
- Warm entity and render caches by touching every node.
- Resave translations along with their default-language node.
- Tune batch size with the chunk-size option on constrained hosts.
- Limit a resave to a small set of bundles with `--bundles`.
