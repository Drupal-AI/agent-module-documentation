<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Procedural API (helper functions)

Forum Access exposes no services beyond `forum_access.route_subscriber`. Its reusable logic is
procedural, split across include files that you must load before calling (the module
lazy-loads them itself):

```php
\Drupal::moduleHandler()->loadInclude('forum_access', 'inc', 'includes/forum_access.common');
\Drupal::moduleHandler()->loadInclude('forum_access', 'inc', 'includes/forum_access.acl');
\Drupal::moduleHandler()->loadInclude('forum_access', 'inc', 'includes/forum_access.admin');
```

## Access checks — `includes/forum_access.common.inc`

| Function | Signature | Returns / behavior |
|----------|-----------|--------------------|
| `forum_access_access` | `($op, $tid, $account = NULL)` | `TRUE`/`FALSE` for `view\|create\|update\|delete` on forum term `$tid`. Short-circuits TRUE for `bypass node access`, and for `edit/delete any forum content`. Falls back to moderator check. Statically cached per user/tid/op. |
| `forum_access_entity_access_by_tid` | `($op, $entity)` | Resolves the entity's forum tid then calls `forum_access_access()`. |
| `forum_access_forum_check_view` | `($account, $tid = NULL)` | Convenience wrapper = `forum_access_access('view', …)`. |
| `forum_access_get_tid` | `($entity)` | The `target_id` of the entity's first `taxonomy_forums` value, or NULL. |
| `forum_access_get_grants_by_tid` | `($tid)` | All raw `{forum_access}` rows for a tid. |
| `forum_access_get_settings_by_roles` | `($roles, $grant)` | `{forum_access}` rows matching any of `$roles` (array of rids) with the given grant (`view\|create\|update\|delete`). |

## Settings read/write — `forum_access.module`

| Function | Signature | Behavior |
|----------|-----------|----------|
| `forum_access_get_settings` | `($tid = NULL)` | Array `['view'=>[rids], 'create'=>[…], 'update'=>[…], 'delete'=>[…], 'priority'=>int]`. |
| `forum_access_set_settings` | `($tid, array $settings)` | Deletes and re-inserts `{forum_access}` rows for `$tid`. `$settings` is keyed by grant type, each a `rid => flag` map (see configure/access-control.md). Does **not** rebuild node access — call `node_access_rebuild()` yourself. |
| `forum_access_get_settings` + `node_access_rebuild(TRUE)` | — | Standard pattern after changing grants. |
| `forum_access_enabled` | `($set = NULL)` | Static flag read by ACL's `acl_node_access_records()`; toggles whether the module contributes grants. |

## ACL / moderators — `includes/forum_access.acl.inc`

| Function | Signature | Behavior |
|----------|-----------|----------|
| `forum_access_get_acl` | `($tid, $name)` | ACL id for `(module='forum_access', name, figure=$tid)`, creating it (and attaching existing topic nodes) if absent. `$name` is `'moderate'`. |
| `forum_access_is_moderator` | `($account, $tid)` | `TRUE` if the account is in the forum's `moderate` ACL. |
| `forum_access_get_settings_by_user` | `($module, $uid, $name = NULL, $figure = NULL)` | ACL rows (`acl` joined `acl_user`) for a user. |

## Example

```php
$mh = \Drupal::moduleHandler();
$mh->loadInclude('forum_access', 'inc', 'includes/forum_access.common');
$mh->loadInclude('forum_access', 'inc', 'includes/forum_access.acl');

$tid = 5;
$account = \Drupal::currentUser();
$can_post = forum_access_access('create', $tid, $account);
$is_mod   = forum_access_is_moderator($account, $tid);
$view_rids = forum_access_get_settings($tid)['view']; // roles with View on this forum
```

Note: these functions are procedural and rely on the custom `{forum_access}` table and the ACL
module; they are not covered by a formal API BC promise, so pin your usage to this branch.
