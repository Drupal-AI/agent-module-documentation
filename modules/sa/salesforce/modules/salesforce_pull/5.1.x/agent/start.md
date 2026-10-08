# Salesforce Pull — agent index

Imports Salesforce records into Drupal per each `salesforce_mapping`'s pull sync-triggers. A
queue handler + cron queue workers create/update/delete Drupal entities from queried SF
records. Depends on `salesforce_mapping`. No configure route of its own (driven by mappings +
`salesforce.settings`).

- **How pull works (triggers, queue, cron, endpoints, scoping)** →
  [api/pull.md](api/pull.md)

Key facts:
- Fires on `pull_create` / `pull_update` / `pull_delete` in a mapping's `sync_triggers`.
- `QueueHandler` builds the pull queue (max `salesforce.settings.pull_max_queue_size`);
  `CronPull` / `SalesforcePullQueueWorker` process it on cron (`salesforce_pull_cron`);
  `DeleteHandler` handles SF deletions.
- Per-mapping scope: `pull_trigger_date`, `pull_where_clause`, `pull_record_type_filter`.
- Standalone endpoints: `/salesforce_pull/endpoint/{key}` (+ per-mapping, single-record) when
  `salesforce.settings.standalone` is on.
- Querying needs a live Salesforce auth; the trigger/scope/queue config is local.
