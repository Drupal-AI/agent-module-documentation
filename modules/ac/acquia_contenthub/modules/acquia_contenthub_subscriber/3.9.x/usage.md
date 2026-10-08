The subscriber submodule turns a site into a Content Hub destination: it receives webhooks, queues incoming CDF for import, unserializes entities with their dependencies, and tracks what has been imported.

---

When the Content Hub service notifies the site of new or changed content (via the base module's HMAC-validated webhook), the subscriber enqueues the referenced entities into an import queue. Processing the queue — through cron or `acquia:contenthub-import-queue-run` — pulls each CDF document, resolves and creates its dependencies (stubs first, then real entities), and saves the local entities, recording each in the subscriber tracker (which also stores per-entity auto-update status used by the `unsubscribe` submodule). Which content a site receives is governed by **webhook interests** and **syndication filters**: commands let you enqueue everything matching a filter, add/remove interests, or purge them. Syndication can be enabled or disabled globally, entities can be imported from a local CDF file for testing, and audit/upgrade Drush commands reconcile or migrate tracker data. An Import Queue admin form and a purge-queue confirmation form let administrators inspect and clear the queue from the UI. It depends only on the base `acquia_contenthub` module.

---

- Receive syndicated content from one or more publisher sites.
- Import incoming entities with all dependencies (fields, references, files) resolved.
- Process the import queue automatically on cron.
- Run the import queue on demand with `acquia:contenthub-import-queue-run`.
- Inspect the import queue from the Import Queue admin form.
- Purge the import queue via the purge-queue confirmation form.
- Track every imported entity and its origin/auto-update status.
- Enqueue all entities matching a syndication filter (`acquia:contenthub-enqueue-by-filters`).
- Enable syndication for the site (`acquia:contenthub:enable-syndication`).
- Temporarily disable syndication during maintenance (`acquia:contenthub:disable-syndication`).
- Scan entities against a filter (`acquia:contenthub:entity-scan:filter`).
- Import a CDF document from a local file for testing (`acquia:contenthub-import-local-cdf`).
- Purge stale webhook interests (`acquia:contenthub-webhook-interests-purge`).
- Audit subscriber tracking against actual imported entities.
- Upgrade subscriber tracker data between module versions.
- Create stub entities on import failure and reconcile them later.
- Combine with the moderation submodule to land imports in a chosen workflow state.
- Combine with the translations submodule to import only selected languages.
- Let the unsubscribe submodule stop pushed updates for chosen entities.
- Build delivery sites in a hub-and-spoke content architecture.
