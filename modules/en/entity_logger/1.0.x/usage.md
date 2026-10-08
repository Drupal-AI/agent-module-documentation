Entity Logger records log messages against specific entities, giving each entity its own activity log shown on a "Log" tab.

---

Entity Logger lets code and integrations record log messages associated with specific entities, so instead of only a single global watchdog each entity can have its own log of events (for example "synced to CRM", "payment processed", "imported from feed"). It defines an internal `entity_log_entry` content entity whose target is a Dynamic Entity Reference, so an entry can point at any entity type. Messages are written in code through the `entity_logger` service or the per-entity `entity_logger.instance` helper (which offers `addLog`, `addInfoLog`, `addNoticeLog`, `addWarningLog`, `addErrorLog`) using PSR-3 placeholder style, and are only stored for the entity types an administrator has enabled on the settings form. A Views embed renders each entity's log on a "Log" local task, an admin collection lists all entries, and `hook_cron` prunes entries older than a configurable retention period in batches. It depends on Dynamic Entity Reference and Views.

---

- Give any entity type its own per-entity activity log.
- Record integration events ("synced to CRM", "pushed to ERP") against the entity they affected.
- Log import/feed processing results on the imported entity.
- Attach payment or order processing notes to a commerce order entity.
- Show editors a per-entity history on a "Log" tab next to View/Edit.
- Persist log messages alongside content rather than only in watchdog.
- Write structured messages with PSR-3 placeholders and a context array.
- Log at different severities (info, notice, warning, error) via the instance helper.
- Mirror an entity log message to a standard Drupal logger channel at the same time.
- Enable logging only for chosen entity types via the settings form.
- Automatically prune old log entries on cron using a retention period.
- Tune bulk-deletion memory use with a configurable cleanup batch size.
- Automatically remove an entity's log entries when that entity is deleted.
- Provide an admin collection listing all log entries at /admin/structure/entity_logger.
- Configure the module at /admin/config/system/entity_logger.
- Reference any entity type through Dynamic Entity Reference target fields.
- Aid debugging of long-running or scheduled processes that act on entities.
- Add ad-hoc log entries to an entity through the "Add log entry" form.
- Expose an entity's log to specific roles using the module's own permissions.
- Extend the set of loggable entity types with the AvailableEntityTypes event.
- Display severity as a human-readable label in Views via the provided field plugin.
- Build custom reports of entity log entries with Views (base table entity_logger).
- Track lifecycle events for custom or contrib entity types.
- Keep an audit-style trail of automated actions taken on content.
