<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Default Content Deploy connects Default Content Deploy's exporter to Search API's change-tracking pipeline, so content is exported to JSON files incrementally -- only the entities that were created, updated, or deleted are re-exported, instead of dumping everything on every run.

---

Default Content Deploy exports content to files, but a full site export re-writes every entity each time. This submodule turns exporting into a Search API index: you add a Search API server backed by the Default Content Deploy backend, an index that uses the DCD Entity datasource for the entity types you care about, and configure per-index options (target folder, whether to include references, link domain, and how deletions are handled). From then on Search API's own tracking -- fired by entity insert/update/delete hooks -- marks changed items, and indexing them writes or removes the matching JSON files. Multiple indexes let you define several independent "continuous export streams" with different folders and rules. It reuses the parent's services and events, so exported files stay compatible with `drush dcdi` on the receiving side. Requires the Search API module.

---

- Export content incrementally instead of in full each run.
- Track content changes with Search API's tracker.
- Re-export only entities that changed.
- Configure a continuous content export stream per index.
- Define multiple export streams with different rules.
- Export a subset of entity types via a datasource.
- Include referenced entities in an export stream.
- Set a HAL link domain for cross-site exports.
- Remove export files when entities are deleted.
- Move deleted entities into a _deleted folder for replay.
- Recursively clear an export folder on index deletion.
- Speed up large-site content deployment.
- Reduce export churn in version control.
- Drive exports from cron or a Search API batch.
- Feed the receiving side's `drush dcdi` with only deltas.
- Skip selected referenced entity types per stream.
