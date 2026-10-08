# Hooks: alter selected user IDs

Source: `purge_users.api.php`. These `_alter` hooks let you add or remove user IDs from each selection
set before they are queued for purge. All receive `array &$uids` by reference.

| Hook | Alters the uids selected by… |
|---|---|
| `hook_purge_never_loggedin_user_ids_alter(array &$uids)` | the "never logged in" rule. |
| `hook_purge_not_loggedin_user_ids_alter(array &$uids)` | the "last login older than" rule. |
| `hook_purge_inactive_user_ids_alter(array &$uids)` | the "inactive / never activated" rule. |
| `hook_purge_blocked_user_ids_alter(array &$uids)` | the "blocked" rule. |
| `hook_purge_policy_user_ids_alter(array &$uids, \Drupal\purge_users\Entity\PurgeUsersPolicy $policy)` | a policy evaluation (also passes the `$policy` entity). |

## Example

```php
/**
 * Implements hook_purge_blocked_user_ids_alter().
 */
function mymodule_purge_blocked_user_ids_alter(array &$uids) {
  // Never purge uid 1 and a protected service account.
  $uids = array_diff($uids, [1, 42]);
}

/**
 * Implements hook_purge_policy_user_ids_alter().
 */
function mymodule_purge_policy_user_ids_alter(array &$uids, \Drupal\purge_users\Entity\PurgeUsersPolicy $policy) {
  if ($policy->id() === 'dormant_customers') {
    // Add extra uids resolved elsewhere.
    $uids = array_unique(array_merge($uids, mymodule_extra_dormant_uids()));
  }
}
```

These hooks are the safe extension point for tuning who gets purged without writing a condition plugin.
Removing a uid here reliably protects that account across the cron/Drush/UI purge paths.
