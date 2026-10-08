# Salesforce Push — agent index

Sends Drupal entity changes to Salesforce. Entity CRUD hooks enqueue pushes per each
`salesforce_mapping`'s push sync-triggers; a push queue + processor plugins deliver them via
REST. Depends on `salesforce_mapping`. No configure route of its own (behavior is driven by
mappings + `salesforce.settings`).

- **How push works (triggers, queue, processors, endpoints, limits)** →
  [api/push.md](api/push.md)

Key facts:
- Fires on `push_create` / `push_update` / `push_delete` in a mapping's `sync_triggers`.
- Queue service `queue.salesforce_push` (`PushQueue`); processor plugin type
  `plugin.manager.salesforce_push_queue_processor` (shipped: `Rest`).
- `async` (per mapping) → queue + cron (`salesforce_push_cron`) or the standalone endpoint
  `/salesforce_push/endpoint/{key}` when `salesforce.settings.standalone` is on.
- Limits: `salesforce.settings.global_push_limit`; per-mapping `push_limit`, `push_retries`,
  `push_frequency`.
- Delivery needs a live Salesforce auth; the trigger/limit config is local.
