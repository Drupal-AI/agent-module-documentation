<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes & permissions

## Permission
`advancedqueue.permissions.yml` defines one permission:
- `administer advancedqueue` — title "Administer queues", `restrict access: true`. This is the
  entity `admin_permission` for `advancedqueue_queue` and gates every admin route below.

## Entity routes
Provided by the entity's `DefaultHtmlRouteProvider` (links in `src/Entity/Queue.php`), all under
`admin/config/system/queues` and gated by `administer advancedqueue`:
- `entity.advancedqueue_queue.collection` — list builder `QueueListBuilder` (also the `configure`
  route and the "Queues" menu link under System config).
- `entity.advancedqueue_queue.add_form` / `edit_form` — `Form/QueueForm.php`.
- `entity.advancedqueue_queue.delete_form` — core `EntityDeleteForm`.

## Explicit routes (`advancedqueue.routing.yml`)
All require `_permission: 'administer advancedqueue'`:
- `advancedqueue.job.release` — `/…/queues/{advancedqueue_queue}/jobs/{job_id}/release`
  (`Form/ReleaseJob.php`).
- `advancedqueue.job.delete` — `/…/jobs/{job_id}/delete` (`Form/DeleteJob.php`).
- `advancedqueue.job.retry` — `/…/jobs/{job_id}/retry` (`Form/RetryJob.php`).
- `advancedqueue.bulk_action_confirm` — `/…/queues/bulk_action/{action}` where `action` is
  constrained to `delete|release|retry` (`Form/BulkActionConfirmForm.php`).

These are all Drupal form routes, so submissions carry the standard form CSRF token.

## Access control handler
`QueueAccessControlHandler::checkAccess()` (`src/QueueAccessControlHandler.php`):
- For the `delete` operation, a **locked** queue (`isLocked()`) is `forbidden` regardless of
  permission; otherwise access follows `administer advancedqueue`.
- All other operations: allowed only with `administer advancedqueue`.

## Views bulk actions
`Plugin/views/field/AdvancedQueueBulkForm.php` plus the `QueueAction/` actions (`Delete`,
`Release`, `Retry`) drive the bulk operations, funnelled through `BulkActionConfirmForm`. The
jobs listing itself is the optional view `views.view.advancedqueue_jobs`.
