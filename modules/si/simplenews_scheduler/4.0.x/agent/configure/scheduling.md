# Scheduling newsletters

No global settings page (`configure` null). Scheduling is configured **per newsletter node** on its
Simplenews **Newsletter** send tab.

## The schedule form (on the Simplenews node tab)

`simplenews_scheduler_form_simplenews_node_tab_alter` injects a **Scheduled Newsletter** `details`
group into `simplenews_node_tab`, but only when:
- the current user has the **`send scheduled newsletters`** permission, and
- the node is a template (not itself an edition) and has not already been sent.

Fields (persisted to the `simplenews_scheduler` DB table, keyed by `nid`): an **activated** toggle, a
**start date**, a **frequency/interval** (send every N units), and a **stop condition** (fixed number
of editions, an end date, or run indefinitely). A `#validate` handler
(`simplenews_scheduler_validate`) and `simplenews_scheduler_submit` save the record.

## Storage

- Custom table **`simplenews_scheduler`** (not config): one row per scheduled template node with
  activation, timing, interval, and last/next run bookkeeping. Loaded onto nodes in
  `simplenews_scheduler_node_storage_load` and cleaned up in `simplenews_scheduler_node_delete`.
- Config object `simplenews_scheduler.settings` — single key **`default_send_action`** (integer,
  default `5` = `SIMPLENEWS_COMMAND_SEND_NONE`), the initial send action for a new schedule.

## Cron send flow (`simplenews_scheduler_cron`)

1. `simplenews_scheduler_get_newsletters_due($timestamp)` selects activated schedules whose next run
   time has passed.
2. For each, `simplenews_scheduler_calculate_edition_time` / `_calculate_next_run_time` (helper
   `_simplenews_scheduler_make_time_offset`) work out the edition timestamp and reschedule.
3. `simplenews_scheduler_clone_node($node)` clones the template node into a new **edition** node
   (`_simplenews_scheduler_new_edition`), firing `hook_simplenews_scheduler_edition_node_alter` before
   save (see [hooks/edition.md](../hooks/edition.md)).
4. `_simplenews_scheduler_send_new_edition` hands the edition to Simplenews to send.

So actual sending is driven entirely by Drupal cron — there is no immediate "send now" button in this
module; ensure cron runs frequently enough for your interval.

## Editions overview

- Route `simplenews_scheduler.node_page` → `/node/{node}/editions` (local task "Newsletter Editions"
  on the node), controller `EditionsController::nodeEditionsPage`.
- Access: custom check `EditionsController::checkAccess` requiring the **`overview scheduled
  newsletters`** permission (and the node being a scheduler template). Lists generated/upcoming
  editions with dates.

## Permissions

| Permission | Gates |
|---|---|
| `send scheduled newsletters` | Seeing/using the schedule form on the Simplenews send tab. |
| `overview scheduled newsletters` | Viewing the `/node/{node}/editions` overview page. |
