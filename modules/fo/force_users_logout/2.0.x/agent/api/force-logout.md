<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forcing a logout from code / drush

The module exposes **no service and no API of its own**. Every form does exactly this:

```php
\Drupal::currentUser()->setAccount($account);
if (\Drupal::currentUser()->isAuthenticated()) {
  \Drupal::service('session_manager')->delete(\Drupal::currentUser()->id());
}
```

`\Drupal\Core\Session\SessionManager::delete($uid)` deletes every row of the core `sessions`
table for that uid (and clears the session if it is the current one). That is the whole effect —
the account is untouched, only its sessions die.

## Equivalents you can run directly

```bash
# one user, by name
drush php:eval '$u = user_load_by_name("jane"); \Drupal::service("session_manager")->delete($u->id());'

# everyone holding a role
drush php:eval '
  $uids = \Drupal::entityQuery("user")->accessCheck(FALSE)
    ->condition("status", 1)->condition("roles", "editor")->execute();
  foreach ($uids as $uid) { \Drupal::service("session_manager")->delete($uid); }'

# everyone except the administrator role (what "All Other Users" does)
drush php:eval '
  $uids = \Drupal::entityQuery("user")->accessCheck(FALSE)
    ->condition("status", 1)
    ->condition("roles", "administrator", "<>")
    ->condition("roles", "anonymous", "<>")->execute();
  foreach ($uids as $uid) { \Drupal::service("session_manager")->delete($uid); }'
```

## Inspecting session state

```bash
drush sql:query "SELECT uid, COUNT(*) FROM sessions GROUP BY uid;"
drush php:eval 'print \Drupal::database()->select("sessions","s")->condition("uid", 5)->countQuery()->execute()->fetchField();'
```

Table `sessions` columns: `uid`, `sid` (PK), `hostname`, `timestamp`, `session`.

## Quirks worth knowing before you rely on it

- **`setAccount()` on `current_user`** — the forms mutate the global `AccountProxy` inside the
  loop instead of passing the uid straight to `session_manager->delete()`. It works, but it
  leaves the request running as the last processed account. Prefer passing the uid directly in
  your own code.
- **Blocked users are skipped.** Every query filters `status = 1`, so a user you just blocked
  still keeps their session; block *and* then delete the session, or delete first.
- **Role lists exclude `administrator`, `authenticated`, `anonymous`** on both the Role Based
  and All Other Users forms, so those roles can never be targeted through the UI.
- **The individual form parses the uid out of `name (uid)`** — programmatic/automated posts must
  include the parentheses.
- `IndividualUserLogoutForm` passes its message through
  `messenger()->addStatus('The user @user has been Logged out.', [...])` — the second argument is
  ignored by `addStatus()`, so the placeholder shows literally. Cosmetic only.
- Nothing is logged to `watchdog`/dblog by the module.
