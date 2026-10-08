The publisher submodule turns a site into a Content Hub source: it detects entity changes, queues them for export, serializes them to CDF, and pushes them to the Content Hub service.

---

When enabled, entity create/update/delete operations enqueue the affected entity into a Drupal export queue (`acquia_contenthub_publish_export`). Processing the queue — via cron or the `acquia:contenthub-export-queue-run` Drush command — calculates the full dependency graph (through `depcalc`), serializes each entity to CDF, and sends it to the service where subscribers can pull it. It tracks what has been published and its export status, exposes an **Exclude settings** form so administrators can keep specific entity types or bundles out of the queue, and adds an action link plus a CSRF-protected controller route to push a single entity into the export queue on demand. It provides Drush audit tooling (`acquia:contenthub-audit-publisher`, `-audit-entity`) to reconcile tracked vs actual state, a `reoriginate` command to reassign the origin, and an upgrade command for schema/data migrations between versions. It depends on the base `acquia_contenthub` module and Views. Requeue and export-queue inspector services let other code and Drush commands drive republishing.

---

- Automatically queue content for export whenever it is created or updated.
- Publish nodes from an authoring site to many subscriber sites.
- Process the export queue on cron for hands-off syndication.
- Run the export queue on demand with `acquia:contenthub-export-queue-run`.
- Push a single entity to the service via its "Export to Content Hub" action link.
- Exclude specific entity types from the export queue via the Exclude settings form.
- Exclude specific bundles (e.g. a "draft" content type) from export.
- Track which entities have been published and their export status.
- Audit publisher tracking against actual entities (`acquia:contenthub-audit-publisher`).
- Audit a single entity's export state (`acquia:contenthub-audit-entity`).
- Requeue previously published entities after a mapping or filter change.
- Reoriginate content to a new origin UUID (`acquia:contenthub:reoriginate`).
- Upgrade publisher tracking data between module versions.
- Delete a remote entity when its local counterpart is removed.
- Republish an entity after editing to propagate the change to subscribers.
- Serialize an entity's full dependency graph (fields, references, files) to CDF.
- Feed a hub-and-spoke architecture where one site publishes to a fleet.
- Inspect the export queue depth for monitoring syndication backlog.
- Combine with syndication filters so only relevant content reaches each subscriber.
- Keep large binary/private files out of export by excluding their entity types.
