# The `qa_accounts.create_delete` service

Service id `qa_accounts.create_delete` → `\Drupal\qa_accounts\QaAccountsCreateDelete`
(interface `QaAccountsCreateDeleteInterface`). Constructor args: `@entity_type.manager`,
`@logger.factory`. This is the single place that creates/deletes QA accounts; the install hook,
role-insert/delete hooks, and Drush commands all call it.

## Methods

| Method | Does |
|---|---|
| `createQaAccounts()` | Loops all `user_role` entities except `anonymous`, calling `createQaAccountForRole()` for each. |
| `createQaAccountForRole(string $role_name)` | Creates account `qa_<role_name>` (email `qa_<role_name>@example.com`, password `qa_<role_name>`, activated); adds the role unless it is `authenticated`. Skips (logs a notice) if the username already exists. |
| `deleteQaAccounts()` | Loops all roles except `anonymous`, calling `deleteQaAccountForRole()`. |
| `deleteQaAccountForRole(string $role_name)` | Loads user `qa_<role_name>` by name and deletes it; logs if absent. |

Account lookup uses an entity query with `accessCheck(FALSE)`.

## Call it programmatically

```php
$svc = \Drupal::service('qa_accounts.create_delete');

// Create the full set (all roles).
$svc->createQaAccounts();

// Create / delete just one role's account.
$svc->createQaAccountForRole('editor');   // -> user "qa_editor", pass "qa_editor"
$svc->deleteQaAccountForRole('editor');
```

Notes:
- The account password equals the username string — these are known credentials by design.
- `createQaAccountForRole('authenticated')` creates a `qa_authenticated` user with no additional role.
- There is no environment/`kill-switch` check; the caller (or operator) is responsible for only running
  this on development sites.
