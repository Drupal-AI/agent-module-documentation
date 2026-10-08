<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plans and then bulk-deletes old node, paragraph, and Layout Builder revisions in resumable chunks to reclaim database space.

---

Fast Revision Purge (package Administration, depends on core `node`) is a database-maintenance tool that shrinks bloated revision tables with a safe two-step flow: a dry-run **Planner** computes KEEP/DELETE sets for node and paragraph revisions from a retention policy, and a chunked **Purger** then deletes the staged revisions. Retention is controlled by keeping the latest N non-default node revisions (optionally partitioned per language), keeping revisions since a date, protecting the latest published revision per node, and keeping the last M paragraph revisions per paragraph entity. Revision tables and entity_reference_revisions edges are discovered at runtime from entity/field-storage definitions and `information_schema` (supporting both D10 and D11 Paragraphs schemas), and paragraphs still referenced by kept node revisions are found via a bounded breadth-first traversal of the ERR graph. It runs from an admin settings form at `/admin/config/development/fast-revision-purge` (permission `administer site configuration`) using the Batch API, or from Drush (`fastrev:report`, `fastrev:purge`, `fastrev:reindex`). A singleton stats row records cumulative deletions, estimated bytes freed, potential reclaimable space, and the last dry-run / purge timestamps. Deletions are permanent, so the module always offers a dry run, a Danger-zone confirmation, and post-purge ANALYZE/OPTIMIZE SQL to reclaim on-disk space.

---

- Reclaim database space on a site whose `node_revision` / `node_revision__*` tables have grown very large.
- Preview exactly how many node, paragraph, and Layout Builder revisions a policy would delete with a dry run before deleting anything.
- Keep only the latest N non-default revisions per node and purge the rest.
- Partition the "keep latest N" rule per language on multilingual sites (per `(nid, langcode)`).
- Keep every revision created since a specific `YYYY-MM-DD` date and purge older ones.
- Always protect the latest published revision of each node while purging older drafts.
- Keep the last M revisions of each Paragraph entity and delete the rest safely.
- Purge non-current Paragraph revisions (meta + all field-revision tables) without breaking current references.
- Purge stale `node_revision__layout_builder__layout` rows while keeping each node's current layout.
- Delete revisions in configurable chunks with an optional sleep between chunks to reduce lock pressure on busy sites.
- Run large purges as resumable Batch API jobs so they complete without PHP timeouts.
- Automate revision cleanup from the CLI or CI with `drush fastrev:purge --chunk=5000 --sleep-ms=50`.
- Generate a plan report from the CLI with `drush fastrev:report --keep-last=5 --protect-published --keep-paragraph-last=1`.
- Create helpful DB indexes for planning/purging with `drush fastrev:reindex` (or the "Ensure indexes" checkbox).
- See current database size and the top biggest tables from the admin overview panel.
- Track cumulative node/paragraph/Layout Builder revisions deleted and estimated bytes freed over time.
- See "Last Dry Run" and "Last Purged" as relative times, plus the potential reclaimable space from the latest plan.
- Copy ready-made sanity-check SQL and Drush snippets (pre-filled with your table names) to independently verify the delete set.
- Copy post-purge `ANALYZE TABLE` / `OPTIMIZE TABLE` SQL to reclaim on-disk space after large deletes on MySQL/MariaDB.
- Schedule periodic revision cleanup by running the Drush purge command from cron.
- Safely maintain revision growth on sites using Paragraphs and/or Layout Builder without custom scripts.
- Estimate reclaimable space before committing to a maintenance window.
