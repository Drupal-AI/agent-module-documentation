<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Review base fields, auto-stamp & Mark as Reviewed

## Base fields (`hook_entity_base_field_info`)

Defined in `content_reviewed_date.module` on the `node` entity type only:

- `content_reviewed_date` — `datetime` field, `datetime_type = date`, label *Last Reviewed*.
  Revisionable, not translatable, not required. Default view display: `datetime_default` (medium
  format), weight 50, view + form display configurable.
- `content_reviewed_uid` — `entity_reference` → `user` (default handler), label *Reviewed By*.
  Revisionable, not translatable, not required. Default view display: `author` formatter, weight
  51, view display configurable.

Both fields exist on every node bundle; only bundles enabled in settings are actually populated —
others store NULL. Columns are dropped on uninstall (see [../config/settings.md](../config/settings.md)).

## Auto-stamp (`hook_node_presave`)

On saving an existing node (`isNew()` returns early — new nodes start "never reviewed"):

1. Skips anonymous / CLI saves (`!$account->isAuthenticated()`) so cron and migrations don't
   stamp.
2. Skips bundles where `ReviewedDateManager::isEnabled()` is FALSE.
3. Compares `$node->original`'s review date to the current value; if they already differ (an
   explicit change earlier in the request, e.g. the Mark as Reviewed form), it leaves that value
   alone.
4. Otherwise calls `markAsReviewed($node, currentUser id, today Y-m-d)`.

## Mark as Reviewed form — `MarkAsReviewedForm`

Route `content_reviewed_date.mark_reviewed` → `/node/{node}/mark-reviewed` (node param upcast,
`\d+`). Rendered as a local-task tab (`links.task.yml`, base route `entity.node.canonical`, weight
50). `FormBase` with deps `content_reviewed_date.manager` + `current_user`.

- If the bundle is not tracked, shows a message linking to settings instead of the form.
- `date` element: HTML5 `date`, default today, `#max` today, required.
- `validateForm()`: rejects a non-`Y-m-d` value (strict round-trip) and any future date.
- `submitForm()`: re-checks `$node->access('update', currentUser)` and throws
  `AccessDeniedHttpException` if denied, then `markAsReviewed()` + `$node->save()`, a status
  message, and redirects to the node. (Standard Drupal form-token CSRF protection applies.)

## Access check — `MarkAsReviewedAccessCheck`

Service `content_reviewed_date.access.mark_reviewed`, tagged `access_check` with
`applies_to: _mark_reviewed_access` (used by the route requirement `_mark_reviewed_access: 'TRUE'`).
`access()` returns forbidden unless **all** hold:

1. account has permission **`mark content as reviewed`**;
2. the node's bundle is tracked (`manager->isEnabled()`);
3. the account has `update` access to the node (`$node->access('update')`).

Results carry the right cache metadata (`cachePerPermissions`, `cachePerUser`, the node as a
cacheable dependency, and cache tag `config:content_reviewed_date.settings`), so the tab
auto-hides on untracked bundles and on nodes the user cannot edit.
