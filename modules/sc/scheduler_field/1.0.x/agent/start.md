# Scheduler Field — agent index

A `scheduler_field` field type (a `datetime_range` field + a "scheduler type" selector) that runs a
pluggable scheduled action on its host entity when cron reaches the start/end dates. Ships a
publish/unpublish plugin. No config page (`configure` null), no permissions, no Drush. Depends on core
`datetime_range`. Provides config schema and a `scheduler_field_type` plugin type.

- **Field type / widget / formatter settings, Views integration, adding the field** →
  [configure/field.md](configure/field.md)
- **The `SchedulerFieldType` plugin type, the two shipped plugins, and the cron→queue→process flow;
  how to write your own plugin** → [plugins/scheduler-field-type.md](plugins/scheduler-field-type.md)

Key facts:
- Field type `scheduler_field` extends `DateRangeItem`; adds a `scheduler_type` varchar column (indexed).
  Storage setting `scheduler_type` = default plugin.
- Shipped plugins (in `src/Plugin/SchedulerField/Type/`): `scheduler_field_type_disabled` (no-op,
  `process_during_cron = FALSE`), `scheduler_field_type_publication` (publish at start, unpublish at end).
- `hook_cron` → `scheduler_field.cron` (`src/Cron.php`) collects entity IDs from each plugin's
  `processScheduler()` → `scheduler_field_process` queue → `SchedulerFieldProcess` worker calls
  `plugin->process($entity, $field_item)`.
- Views: `scheduler_type` field + filter (`InOperator`) + `string_list_field` argument.
- Manager service `plugin.manager.scheduler_field_type`; annotation `@SchedulerFieldType`.
