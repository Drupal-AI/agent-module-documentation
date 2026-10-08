<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ban enforcement & CasUserBanManager

## Install / enable
`drush en cas_user_ban`. Requires the `cas` module. Installing creates the `cas_user_ban` table
(`cas_user_ban_schema()` in `cas_user_ban.install`): columns `cas_username` (varchar 128, primary key) and
`timestamp` (int). Uninstalling drops it. No configuration objects or settings form.

## The manager service
`Drupal\cas_user_ban\CasUserBanManagerInterface` (autowired to `CasUserBanManager`), constructed with the DB
`Connection`, `TimeInterface`, and the `logger.channel.cas_user_ban` channel. Methods:
- `add(string $username): void` — throws `InvalidCasUsernameException` on empty string, `ExistingBanException`
  if already banned; otherwise inserts a row and logs a notice. (Insert uses the query builder `->fields([...])`,
  parameterized.)
- `isBanned(string $username): bool` — parameterized `SELECT ... WHERE cas_username = :x` limited to 1 row.
- `remove(string $username): void` — throws `BanNotFoundException` if not present; else deletes the row and logs.

Exceptions live in `src/Exception/` and all implement `CasUserBanExceptionInterface`.

## How the ban is enforced
`EventSubscriber\CasPreRegisterSubscriber::onPreRegister` subscribes to `\Drupal\cas\Event\CasPreRegisterEvent`.
On the event it reads `$event->getDrupalUsername()`, and if `isBanned()` is true it calls
`$event->cancelAutomaticRegistration(...)` with a generic "problem logging in" message and logs a warning.

Enforcement scope (important operational nuance, by design and documented in the module README): the
`CasPreRegisterEvent` fires only during CAS *automatic account creation*. A banned username therefore cannot get a
**new** Drupal account, but if an account with that CAS username **already exists**, this subscriber never runs and
the user can still log in. To fully block such a user, delete the existing account (optionally with the ban option)
so it cannot be recreated. The `BanUsersForm` batch and `UserCancelFormsTrait::banUser` surface a warning when a
banned username still has a linked account.

## Programmatic use
```php
$mgr = \Drupal::service(\Drupal\cas_user_ban\CasUserBanManagerInterface::class);
if (!$mgr->isBanned('jdoe')) { $mgr->add('jdoe'); }
$mgr->remove('jdoe');
```
