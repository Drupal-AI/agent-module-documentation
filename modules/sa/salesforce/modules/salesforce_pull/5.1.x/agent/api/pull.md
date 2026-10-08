# How pull works

## Trigger & scope

For each `salesforce_mapping` with `pull_create` / `pull_update` / `pull_delete` in its
`sync_triggers`, the module queries Salesforce for matching records. Per-mapping scoping:
- `pull_trigger_date` — the Salesforce date field used to detect changes.
- `pull_where_clause` — extra SOQL filter appended to the pull query.
- `pull_record_type_filter` — restrict to record type(s).

## Queue & processing

- `salesforce_pull.queue_handler` (`QueueHandler`) builds the pull queue, honouring
  `salesforce.settings.pull_max_queue_size`.
- Queue workers `CronPull` and `SalesforcePullQueueWorker` (base `PullBase`) process items.
- `salesforce_pull_cron()` runs the pull on cron.
- `salesforce_pull.delete_handler` (`DeleteHandler`) processes Salesforce deletions.

## Standalone endpoints

When `salesforce.settings.standalone` is enabled:
- `/salesforce_pull/endpoint/{key}` — process all mappings.
- `/salesforce_pull/{salesforce_mapping}/endpoint/{key}` — one mapping.
- `/salesforce_pull/{salesforce_mapping}/endpoint/{key}/record/{id}` — a single record.

## Matching

Incoming records are matched to Drupal entities via mapped objects
(`salesforce_mapped_object`) and the mapping's upsert `key`.

## Read/verify config

```bash
drush cget salesforce.mapping.<id>            # pull_* sync_triggers, pull_where_clause, pull_trigger_date
drush cget salesforce.settings pull_max_queue_size
```

Actual querying requires a working Salesforce authorization; the trigger/scope/queue-size
config is local and needs no connection.
