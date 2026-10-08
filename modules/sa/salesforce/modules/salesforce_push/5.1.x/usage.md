Salesforce Push sends Drupal entity changes to Salesforce: when a mapped Drupal entity is created, updated, or deleted, it queues and pushes the corresponding Salesforce record according to the mapping's push sync-triggers.

---

The module implements entity CRUD hooks (`salesforce_push_entity_insert/update/delete`) that, for each `salesforce_mapping` whose `sync_triggers` include the matching `push_create` / `push_update` / `push_delete`, enqueue a push to Salesforce. Pushes run through the `queue.salesforce_push` service (`PushQueue`), processed by **push-queue-processor** plugins (`plugin.manager.salesforce_push_queue_processor`; the shipped `Rest` processor uses the REST client). Synchronous vs asynchronous behavior is per mapping (`async`) — async pushes go to the queue and are processed on cron (`salesforce_push_cron`) or, when `salesforce.settings.standalone` is on, via the push endpoint (`/salesforce_push/endpoint/{key}`, optionally per mapping). The global batch size is `salesforce.settings.global_push_limit`, and each mapping can further cap with `push_limit`, `push_retries`, `push_frequency`. Actual delivery needs a working Salesforce authorization; the mapping and trigger configuration that decides *what* to push is all local. No permissions or Drush of its own.

---

- Push new Drupal users to Salesforce as Contacts on creation.
- Update the matching Salesforce record when a mapped Drupal entity changes.
- Delete (or not) the Salesforce record when the Drupal entity is deleted.
- Push asynchronously via the queue instead of blocking entity save.
- Process the push queue on cron.
- Process the push queue via a standalone endpoint under high volume.
- Limit how many records are pushed per run (global_push_limit / per-mapping push_limit).
- Retry failed pushes up to a configured number of times.
- Control push frequency per mapping.
- Choose per mapping which events push (create/update/delete) via sync_triggers.
- Add a custom push-queue processor plugin for alternate delivery.
- Push only specific bundles by scoping the mapping.
- Keep Drupal as the system of record and mirror to Salesforce.
- Enqueue pushes triggered by related-entity changes.
- Trigger a push endpoint from an external scheduler.
- Batch large pushes to respect Salesforce API limits.
- Combine with Salesforce Logger to log push params/success.
- Use mapped objects to track which Drupal entity maps to which SF record.
- Upsert instead of create/update when the mapping sets always_upsert.
- Push webform submissions to Salesforce (with salesforce_webform mappings).
