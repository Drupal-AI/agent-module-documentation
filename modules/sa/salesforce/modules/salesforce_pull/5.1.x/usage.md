Salesforce Pull imports Salesforce records into Drupal: it queries mapped Salesforce objects and creates/updates/deletes the corresponding Drupal entities according to each mapping's pull sync-triggers.

---

For every `salesforce_mapping` whose `sync_triggers` include `pull_create` / `pull_update` / `pull_delete`, the module queries Salesforce for changed records and enqueues them. A `QueueHandler` service builds the pull queue (respecting `salesforce.settings.pull_max_queue_size`), and `CronPull` / `SalesforcePullQueueWorker` queue workers process items on cron (`salesforce_pull_cron`); a `DeleteHandler` handles Salesforce-side deletions. Pull scope per mapping is controlled by `pull_trigger_date` (the SF date field to watch), `pull_where_clause` (an extra SOQL filter) and `pull_record_type_filter`. When `salesforce.settings.standalone` is enabled, pull can be triggered via endpoints (`/salesforce_pull/endpoint/{key}`, per-mapping, or single-record). Records are matched to Drupal entities via mapped objects and the mapping's upsert key. Actual querying needs a working Salesforce authorization; the mappings, triggers and queue size that decide *what* to pull are all local config. No permissions or Drush of its own.

---

- Import Salesforce Contacts into Drupal users.
- Create Drupal entities when new Salesforce records appear (pull_create).
- Update Drupal entities when the Salesforce record changes (pull_update).
- Delete/unlink Drupal entities when the Salesforce record is deleted (pull_delete).
- Scope pulls with an extra SOQL where clause per mapping.
- Watch a specific Salesforce date field to detect changes (pull_trigger_date).
- Filter pulled records by Salesforce record type.
- Process the pull queue on cron.
- Trigger pulls via a standalone endpoint for external scheduling.
- Pull a single Salesforce record on demand via the single-record endpoint.
- Cap the pull queue size to protect the site (pull_max_queue_size).
- Keep Drupal in sync with Salesforce as the system of record.
- Match incoming records to existing Drupal entities via the mapping key.
- Handle Salesforce deletions safely with the delete handler.
- Combine with push for bidirectional sync (choose triggers per direction).
- Import only specific bundles by scoping the mapping.
- Backfill Drupal content from Salesforce.
- Throttle imports under high volume via queue size and cron frequency.
- Log pull activity with Salesforce Logger.
- Base pulls on record type for multi-type Salesforce objects.
