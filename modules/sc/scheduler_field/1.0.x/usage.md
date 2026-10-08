Scheduler Field adds a `scheduler_field` field type (a date-range field with a "scheduler type" selector) that runs a pluggable scheduled action on the host entity when cron reaches the configured start/end dates — out of the box, publishing/unpublishing the entity.

---

The field type `scheduler_field` extends core `datetime_range`'s `DateRangeItem`, adding a `scheduler_type` column that names which **SchedulerFieldType plugin** governs the schedule. Two plugins ship: `scheduler_field_type_disabled` (no action, default) and `scheduler_field_type_publication` (publishes the entity once `start_date` passes and unpublishes it once `end_date` passes, via `EntityPublishedInterface`). On each `hook_cron`, `scheduler_field.cron` asks every cron-enabled plugin for the entity IDs it needs to act on (each plugin adds its own SQL conditions through `processSchedulerQuery()`), chunks them into the `scheduler_field_process` queue, and the queue worker loads each entity and calls the plugin's `process()`. Because scheduling data lives on the field table (not the entity), one entity can carry several scheduler fields. The default widget (`scheduler_field_default`, extending `DateRangeDefaultWidget`) shows start/optional-end date inputs plus a scheduler-type `<select>`, both toggleable via widget settings `show_end_date` and `show_type_selector`; the default formatter renders the range like a normal date-range. Views integration adds a `scheduler_type` field/filter/argument so you can list or filter entities by their scheduler type. Requires core `datetime_range`; `scheduler_field.plugin_type.yml` optionally integrates with the contrib `plugin` (Plugin API) module. There is no admin settings page and no permissions; you extend it by writing your own SchedulerFieldType plugin.

---

- Schedule a node to publish automatically at a future date/time.
- Schedule a node to unpublish automatically at an end date/time.
- Publish content for a fixed window (start + end date) then auto-unpublish.
- Schedule publication of any entity implementing `EntityPublishedInterface` (nodes, custom entities, etc.), not just nodes.
- Add multiple independent schedules to one entity by adding several scheduler fields.
- Let editors pick per-item whether a schedule is active or "Disabled".
- Hide the schedule-type selector from editors and force a single behavior via `show_type_selector`.
- Hide the end-date input for open-ended (publish-only) schedules via `show_end_date`.
- Auto-fill the start date with "now" when only an end date is entered.
- Write a custom SchedulerFieldType plugin to change a moderation/workflow state on a date.
- Write a plugin to change arbitrary field values on a schedule.
- Write a plugin to send an email or notification when a date is reached.
- Write a plugin that performs any custom action in `process()`.
- Run scheduled actions purely from cron (no external scheduler service needed).
- Offload processing to Drupal's queue so large batches don't block cron.
- List entities in a View with a column showing their scheduler type (machine name or label).
- Filter a View to only entities using a given scheduler type.
- Use a contextual argument to page by scheduler type.
- Restrict a scheduler plugin to specific entity types with `isAvailableForEntityType()`.
- Restrict a scheduler plugin per-entity with `isAvailableForEntity()`.
- Mark a plugin as non-cron (`process_during_cron = FALSE`) so it only stores intent without acting.
- Schedule campaign or promotional content to appear and disappear automatically.
- Time-box embargoed articles that must go live at a precise moment.
