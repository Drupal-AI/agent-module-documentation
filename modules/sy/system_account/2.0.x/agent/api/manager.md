<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# System Account — manager service & config

## Service
`Drupal\system_account\SystemAccountManager` (id: autowired, alias `SystemAccountManagerInterface`).

```php
$manager = \Drupal::service(\Drupal\system_account\SystemAccountManagerInterface::class);
$manager->createAccount('system_account', ['mail' => 'sys@example.org']);
$manager->exists('system_account');      // bool
$user = $manager->get('system_account'); // ?UserInterface
```

### createAccount(string $name = 'system_account', array $params = []): bool
- Defaults: random password (`PasswordGenerator`), `status = TRUE`, `mail = $name.'@example.org'` if not given, `system_account = TRUE`.
- If a user with `$name` already exists **and** is flagged `system_account` → returns FALSE, never modifies it (logs a warning if the call tried to change mail/status).
- If a same-named **non-system** user exists and `preserve_existing_accounts` is TRUE (default) → returns FALSE and logs; if FALSE → converts it (sets mail/password/status/flag) and logs.
- Otherwise creates a new user. Requires the `system_account` base field (throws `\RuntimeException` if missing).

## Config: `system_account.settings`
| Key | Default | Meaning |
|---|---|---|
| `display_name` | `System Account` | Name rendered for the default system account |
| `preserve_existing_accounts` | `true` | Do not convert same-named existing accounts |

## Shipping an account from your module
Provide config `system_account.account.<module>.<id>.yml` with `name`, `mail`, `status`. On install the module validates name/email and creates the account only if no user matches the name **or** email.

## Base field
`system_account` (boolean, default FALSE) is added to every user entity; query it to enumerate system accounts.
