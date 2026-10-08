# Policies & condition plugins

Besides the global settings form, Purge Users supports **policies** — `purge_users_policy` config
entities that compose one or more **condition plugins**. Manage them at
`/admin/config/people/purge-users/policies` (routes require `administer site configuration`).

## Policy config entity

- `@ConfigEntityType(id = "purge_users_policy")`, `config_prefix: purge_users_policy` →
  `purge_users.purge_users_policy.<id>`.
- A policy holds a set of condition-plugin instances (added via
  `/admin/config/people/purge_users/condition/add/{policy_id}/{plugin_id}`, edited/deleted via the sibling
  routes).
- `PurgeUsersPolicyService::purgeAllUsers()` / `notifyAllUsers()` evaluate every policy's conditions,
  building a user-table query, and enqueue matching uids. `hook_cron()` calls both.
- Per-policy manual purge: `/admin/config/people/purge-users/policies/confirm/{policy_id}`
  (`PolicyConfirmationForm`, permission `access purge confirmation form`).

## Condition plugins (`@Condition`, `src/Plugin/Condition/`)

These are core Condition plugins (base `PurgeUsersConditionBase`); each adds a WHERE/JOIN against the
`users_field_data`/`users` tables via `PolicyConditionTrait`.

| Plugin id | Selects users… |
|---|---|
| `purge_users:never_logged_in` | who have never logged in (older than the configured age). |
| `purge_users:not_logged_in` | whose last login is older than the configured age. |
| `purge_users:inactive` | who are inactive / never activated for the configured period. |
| `purge_users:blocked` | who have been blocked for the configured period. |
| `purge_users:included_roles` | who hold one of the selected roles (left join `user__roles`). |
| `purge_users:excluded_roles` | who do NOT hold the selected roles (excludes them from the purge). |
| `purge_users:author_commenter` | filters out users who authored nodes / posted comments (join `node_field_data` / `comment_field_data`). |
| `purge_users:notification_required` | who are due a pre-deletion notification (join `purge_users_notifications`). |

## Implementing a custom condition

Create a `@Condition`-annotated plugin extending `\Drupal\purge_users\PurgeUsersConditionBase` (implements
`PurgeUsersConditionInterface`), and use `PolicyConditionTrait` to contribute your query condition. It is
then selectable when adding a condition to a policy. To adjust uid selection without a plugin, prefer the
`hook_purge_*_user_ids_alter()` hooks — see [../hooks/alter.md](../hooks/alter.md).
