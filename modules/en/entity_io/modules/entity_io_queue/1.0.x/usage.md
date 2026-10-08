Adds queue-based background processing for Entity IO exports and imports, ideal for large-scale data operations.

---

Entity IO Queue defines two Drupal core queues — `entity_io_queue_export` and
`entity_io_queue_import` — each with a cron worker plugin, plus an admin interface to list queued
items, execute a single item, or process an entire queue through the Batch API. Export items carry
the entity type/id and export options; import items carry a JSON payload that is fed to Entity IO's
importer. A logged-in, Basic-Auth-authenticated POST endpoint lets external systems enqueue import
jobs programmatically.

---

- Defer exporting a large number of entities to cron instead of a blocking request.
- Queue a bulk import and process it in the background.
- Add an entity to the export queue from code via `EntityIoQueueService::addToExportQueue()`.
- Process all queued export items at once through a batch run.
- Process all queued import items at once through a batch run.
- Execute a single queued item manually from the admin list.
- Let cron drain the export/import queues automatically (60s per run).
- Enqueue an import job from an external script via the authenticated add-item endpoint.
- Monitor pending export items and their metadata in the admin table.
- Monitor pending import items in the admin table.
- Retry a failed item by re-executing it from the queue list.
- Integrate queued exports into a scheduled content-sync workflow.
- Offload webhook/push payload generation to the background.
- Keep request latency low by not exporting synchronously on save.
- Batch-migrate an entire site's content type by type via the queue.
