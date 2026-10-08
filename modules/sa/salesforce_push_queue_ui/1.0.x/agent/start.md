<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Salesforce Push Queue UI — agent index

Views integration + admin screen for the Salesforce Suite's `salesforce_push_queue` table.
No config form (`configure` is unset), no permissions of its own — everything is gated by the
Salesforce Suite's `administer salesforce` permission. Requires `salesforce_push` and `views`.

- **The view, the routes that reset failures/expiration, and how to rebuild the screen** →
  [configure/queue-view.md](configure/queue-view.md)
- **The Views data definition and the four Views plugins (fields/filter) it adds** →
  [plugins/views-plugins.md](plugins/views-plugins.md)

Key facts:
- Base table `salesforce_push_queue`, base field `item_id`; columns exposed as Views
  field/sort/filter/argument: `item_id`, `name` (mapping id), `entity_id`, `mapped_object_id`,
  `op`, `failures`, `last_failure_message`, `expire`, `created`, `updated`.
- Relationship `mapped_object_id` → base table `salesforce_mapped_object`.
- Two operation routes, both `_permission: administer salesforce` + `_csrf_token: TRUE`:
  - `salesforce_push_queue_ui.reset_failures` — `/admin/content/salesforce-push-queue/reset-failures/{item_id}`
    sets `failures = 0`, `last_failure_message = NULL`, `updated = time()`.
  - `salesforce_push_queue_ui.reset_expiration` — `/admin/content/salesforce-push-queue/reset-expiration/{item_id}`
    sets `expire = 0`, `updated = time()` (item becomes immediately claimable).
  Both redirect to `?destination` or `/admin/content/salesforce-push-queue`; they answer with an
  `AjaxResponse` + `RedirectCommand` for XHR requests.
- The shipped view `views.view.salesforce_push_queue` declares a **config dependency on
  `view_custom_table`**, which is *not* declared in `salesforce_push_queue_ui.info.yml` or its
  composer.json. Verified on a site where `view_custom_table` **is** enabled: the view installs
  and `drush cget views.view.salesforce_push_queue` returns it. On a site without that module
  Drupal drops config whose dependencies are unmet, so expect the view to be missing —
  check after enabling and either install `view_custom_table` or rebuild the view by hand.
- `hook_views_pre_render()` rewrites `last_failure_message` on the `salesforce_push_queue` view
  only, stripping the `Queue item %item failed %fail times. Exception while pushing entity …`
  prefix so only the Salesforce-side error text remains.
- No `hook_cron`, no queue worker: draining the queue is still `salesforce_push`'s job.
