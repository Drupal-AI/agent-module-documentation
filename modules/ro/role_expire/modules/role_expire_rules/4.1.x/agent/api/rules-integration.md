# Role Expire Rules — actions & event

## Rules actions

### `role_expire_set_expire_time` — "Set expire time for user roles"
Category "User". Context:

| Context | Type | Notes |
|---|---|---|
| `user` | `entity:user` | The user to act on. |
| `roles` | `string` (multiple) | One or more role IDs. |
| `date` | `string` | Absolute `YYYY-MM-DD HH:MM:SS` or relative strtotime (`1 day`, `2 months`, `1 year`). |

Behaviour (`doExecute`): for each role, **only if the user actually has that role**, it computes
`strtotime($date)` and calls `role_expire.api`→`writeRecord($uid, $role, $time)`. An empty/invalid
date throws `InvalidArgumentException`.

### `role_expire_remove_expire_time` — "Remove expire time for user roles"
Category "User". Context: `user` (`entity:user`), `roles` (`string`, multiple). Removes the expiry
records for those roles via `role_expire.api`→`deleteRecord()`, making them permanent again.

## Rules event

`role_expire_event_role_expires` — "When a role expires" (category "User"), declared in
`role_expire_rules.rules.events.yml`. It surfaces the parent module's `RoleExpiresEvent` (dispatched
from `role_expire_cron()` when a role is removed). Context:

- `account` — `entity:user`, the affected user.
- `ridBefore` — `string`, the role id that just expired.

Use it as the trigger of a reaction rule (e.g. email the user, add a replacement flag).

## Building a reaction rule programmatically

```php
use Drupal\rules\Context\ContextConfig;
$em = \Drupal::service('plugin.manager.rules_expression');
$rule = $em->createRule();
$rule->addExpressionObject($em->createAction('role_expire_set_expire_time',
  ContextConfig::create()
    ->map('user', 'user')
    ->setValue('roles', ['editor'])
    ->setValue('date', '1 year')));
\Drupal::entityTypeManager()->getStorage('rules_reaction_rule')->create([
  'id' => 'set_editor_expiry',
  'label' => 'Set editor expiry on login',
  'events' => [['event_name' => 'rules_user_login']],
  'expression' => $rule->getConfiguration(),
])->save();
```

The stored config is at `rules.reaction.<id>`; the action appears in its `expression` with
`action_id: role_expire_set_expire_time` and your `context_values` (`date`, `roles`). Read it with
`drush cget rules.reaction.<id> expression`.
