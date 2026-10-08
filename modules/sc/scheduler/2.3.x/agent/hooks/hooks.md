# Hooks (`scheduler.api.php`)

Every hook has a **general** form and an entity-type-specific variant with `_TYPE_` in the name
(e.g. `hook_scheduler_node_list_alter`, `hook_scheduler_media_publishing_allowed`), where TYPE is
the entity type id. All are invoked during cron processing unless noted.

## Manipulate the list of ids to process
- `hook_scheduler_list($process, $entityTypeId)` — return extra ids to add (legacy; prefer the
  alter hook). `$process` is `'publish'` or `'unpublish'`.
- `hook_scheduler_list_alter(array &$ids, $process, $entityTypeId)` — add or remove ids from the
  batch being processed this run.

## Allow / deny an action
- `hook_scheduler_publishing_allowed(EntityInterface $entity)` — return FALSE to block
  publication (e.g. until an approval field is set). Attempts continue each cron run until allowed.
- `hook_scheduler_unpublishing_allowed(EntityInterface $entity)` — same for unpublishing.

## Customise the action
- `hook_scheduler_publish_process(EntityInterface $entity)` — return `1` if you performed the
  publish yourself (skip default), `0` to let Scheduler do it, `-1` to abandon this entity.
  Used by Content Moderation integration to change a moderation state instead of `status`.
- `hook_scheduler_unpublish_process(EntityInterface $entity)` — same for unpublishing.

## Hide the date fields (called from form alter, not cron)
- `hook_scheduler_hide_publish_date($form, $form_state, $entity)` — return TRUE to hide the
  publish_on input for this entity/user.
- `hook_scheduler_hide_unpublish_date(...)` — same for unpublish_on.

## Query tags
The two select queries carry tags `scheduler`, `scheduler_publish`, `scheduler_unpublish`
(plus `scheduler_TYPE_publish` / `scheduler_TYPE_unpublish`), so you can implement
`hook_query_TAG_alter()` — e.g. `hook_query_scheduler_alter($query)` reads
`$query->getMetaData('entity_type')`.
