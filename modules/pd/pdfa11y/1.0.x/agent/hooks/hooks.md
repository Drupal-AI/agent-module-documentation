# Hooks & integration points

## Upload blocking (validation constraint)

`hook_entity_type_alter()` adds the `Pdfa11y` constraint to the **file** entity
(`Pdfa11yConstraint`, validator `Pdfa11yConstraintValidator`, service-tagged
`validation.constraint_validator`). On validation of a `.pdf` file:

- If `check_on_upload` is false → no-op.
- If `block_failed_uploads` is false **or** the user has `bypass blocked pdf uploads` → run checks
  and add a warning message listing failures (no violation, save allowed).
- Otherwise → run checks and add one constraint violation per failure, so the form widget renders
  each as a bullet and the save is blocked.

## Media triggers (`pdfa11y.entity_hooks` = `Pdfa11yEntityHooks`)

- `hook_media_insert()` / `hook_media_update()` → analyze the source PDF and store results (update
  only re-runs when the source fid changed). Skipped unless `check_on_upload` is on and the media
  type's source field lists `pdf`. If the media `isSyncing()` (migrations), the item is enqueued to
  the `pdfa11y_check` queue instead of analyzed inline.
- `hook_entity_extra_field_info()` → adds a `pdfa11y_status` display component to every PDF-capable
  media type.
- `hook_ENTITY_TYPE_view()` (media) → renders that component: "Not checked" / "All N checks passed"
  / "X of Y issue(s)" plus the editor instructions on failure.
- `hook_element_info_alter()` → attaches the `pdfa11y/modal-scroll` library to `managed_file`
  elements so warnings scroll into view inside upload dialogs.

## Queue worker

`#[QueueWorker(id: 'pdfa11y_check', cron: ['time' => 60])]` = `Pdfa11yCheckWorker`. Items are
`['mid' => int]`. Applies the `max_filesize` and `max_image_bytes` preflight guards, then calls
`Pdfa11yAnalyzer::analyzeIsolated()`. A run of `max_consecutive_io_failures` consecutive `_io_error`
items throws `SuspendQueueException` (backend-health circuit breaker). Drain with
`drush queue:run pdfa11y_check` (or via cron).

## Extending checks

`hook_pdfa11y_check_info(&$definitions)` alters the discovered AccessibilityCheck plugin
definitions — see [../plugins/accessibility-check.md](../plugins/accessibility-check.md).

## Views / schema

`hook_views_data()` exposes the `pdfa11y_results` base table with joins/relationships to
`media_field_data` and `file_managed` and several custom field/filter plugins — see
[../views/views.md](../views/views.md). `hook_schema()` defines `pdfa11y_results`;
`hook_uninstall()` drops it. A breadcrumb builder (`Pdfa11yBreadcrumbBuilder`, priority 100) applies
to the report/recheck routes.
