# Settings & enforcement

## Settings form

Route `login_disable.settings_form` → `/admin/config/people/login-disable`, permission
`administer permissions`. Built with `ConfigFormBase` (CSRF token automatic). Config object
`login_disable.settings`:

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
   `login_disable_form_user_login_block_alter`, both delegating to
   `_login_disable_form_user_login_alter`): only runs when active. If `login_disable_key` is set and
   *not* present in `$_GET`, it disables the name/pass fields and unsets `#validate`/`#submit`/`actions`,
   so the form cannot be submitted. It also shows `login_disable_message` as a warning. If the key is
   empty, this gate is skipped (form stays usable). This layer is UI-level obscurity only.
2. **`hook_user_login`** (`LoginDisableHooks::userLogin`): the real boundary. After a successful
   authentication, if `$currentUser->hasPermission('bypass disabled login')` is FALSE, it shows the
   message and calls `$requestStack->getCurrentRequest()->getSession()->clear()`, so the just-authenticated
   user is immediately logged out. uid 1 bypasses (passes all permission checks). This runs regardless of
   the key, and covers the form login, the login block, the REST login, and one-time-login / password-reset
   links — every path that calls `user_login_finalize()`.
3. **REST route access check** (`LoginDisableAccessCheck`, service tagged `access_check` with
   `applies_to: _login_disable_access`, attached to `user.login.http` by `LoginDisableRouteSubscriber`):
   when active and a key is set, denies the REST login route (`403 "Access key required."`) unless the
   key is in the query; allowed when inactive or when no key is configured.

## Permission

`bypass disabled login` (`restrict access: TRUE`, description "Always allowed to log in."). Grant it to
the roles that should still be able to log in while login is disabled. Any role without it is logged out
by layer 2 even if it knows the key.

## Force logout

`LoginDisableSettingsForm::submitForm()` — when both active and force-logout are set, runs
`DELETE FROM sessions WHERE uid NOT IN (1, <current_uid>)`, ending everyone else's sessions.

## Hook wiring

Hooks live in `src/Hook/LoginDisableHooks.php` as an OOP `#[Hook]` class registered as the service
`Drupal\login_disable\Hook\LoginDisableHooks` (constructor-injected `config.factory`, `current_user`,
`messenger`, `module_handler`, `request_stack`, optional `plugin.manager.filter`). `login_disable.module`
keeps thin `#[LegacyHook]` wrappers (`_help`, `form_user_login_form_alter`, `user_login`) that delegate to
the service; `form_user_login_block_alter` remains a plain procedural hook. `hook_help` renders the README
through the Markdown filter when available.

## Diff 2.1.x → 2.2.x

Real changes observed against the 2.1.x docs and the 2.2.x source:

- **Core requirement narrowed**: `^8.8 || ^9 || ^10 || ^11` → `^11.3 || ^12`. Drupal 8/9/10 are dropped;
  2.2.x needs 11.3+.
- **Hooks refactored to the OOP hook pattern**: implementations moved into `src/Hook/LoginDisableHooks.php`
  with `#[Hook]` attributes and a service registration in `login_disable.services.yml`; `.module` now holds
  `#[LegacyHook]` procedural shims that call the service.
- **No flood-control logic in 2.2.x**: the form-alter path contains no IP/flood throttling of wrong-key
  attempts (the 2.1.x docs described a `user.flood`-based throttle; nothing of the kind is present in the
  2.2.x code). Normal core login flood on the authentication itself still applies.
- **`hook_help` rewritten** to render the README via the Markdown filter plugin (`@?plugin.manager.filter`,
  optional).
- Config keys (all four), the `bypass disabled login` permission, the settings route/permission, the
  force-logout SQL, and the REST access-check + route subscriber are unchanged from 2.1.x.
