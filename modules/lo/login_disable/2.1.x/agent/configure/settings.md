# Settings & enforcement

## Settings form

Route `login_disable.settings_form` → `/admin/config/people/login-disable`, permission
`administer permissions`. Config object `login_disable.settings`:

| Key | Default | Meaning |
|---|---|---|
| `login_disable_is_active` | `false` | Master switch — when off the module does nothing |
| `login_disable_key` | `admin` | Secret word required as a URL query arg to reveal the login form (optional; empty = no key gate) |
| `login_disable_message` | "Member access has been temporarily disabled…" | Warning shown to blocked users |
| `login_disable_force_logout` | `false` | On save, if active, delete all sessions except uid 1 and current user |

Drush/config example:
```
drush cset login_disable.settings login_disable_is_active true -y
drush cset login_disable.settings login_disable_key 's3cr3t-word' -y
```

## Enforcement — three layers

1. **Form alter** (`login_disable_form_user_login_form_alter` /
   `_login_disable_form_user_login_block_alter`): only runs when active. If `login_disable_key` is set
   and *not* present in `$_GET`, it disables the name/pass fields and unsets `#validate`/`#submit`/
   `#actions`, and registers an IP flood event (`login_disable.failed_key_ip`, using `user.flood`
   `ip_limit`/`ip_window`). If the IP is already flooded, the form is disabled with a "too many attempts"
   error. If the key is empty, this whole gate is skipped (form stays usable). This layer is UI-level
   obscurity only.
2. **`hook_user_login`** (`login_disable_user_login`): the real boundary. After a successful
   authentication, if `\Drupal::currentUser()->hasPermission('bypass disabled login')` is FALSE, it shows
   the message and calls `->getSession()->clear()`, so the just-authenticated user is immediately logged
   out. User 1 bypasses (uid 1 passes all permission checks). This runs regardless of the key.
3. **REST route access check** (`LoginDisableAccessCheck`, service tag `_login_disable_access`, added to
   `user.login.http` via `LoginDisableRouteSubscriber`): when active and a key is set, denies the REST
   login route unless the key is in the query; allowed when inactive or no key configured.

## Permission

`bypass disabled login` (`restrict access: TRUE`, description "Always allowed to log in."). Grant it to
the roles that should still be able to log in while login is disabled. Any role without it is logged out
by layer 2 even if it knows the key.

## Force logout

`LoginDisableSettingsForm::submitForm()` — when both active and force-logout are set, runs
`DELETE FROM sessions WHERE uid NOT IN (1, <current_uid>)`, ending everyone else's sessions.
