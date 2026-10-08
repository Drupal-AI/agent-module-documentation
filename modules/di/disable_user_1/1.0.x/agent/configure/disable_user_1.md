<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Disable User 1

There is **no admin UI, no configuration form, and no `config/install` default**. The module is
controlled entirely by one boolean config value that you set as a `$config` override in `settings.php`.
Until you set it, the module does nothing even when enabled.

## The one setting

- Config object: `disable_user_1.settings`
- Key: `disable_user_1` (boolean)
- Read at runtime by the event subscriber:
  `\Drupal::config('disable_user_1.settings')->get('disable_user_1')`

The key is not stored by the module (there is no schema and no default), so `drush cget
disable_user_1.settings disable_user_1` reports *does not exist* until an override provides it. That is
by design — activation is meant to be an environment-level decision in `settings.php`, not exported site
config.

## Activate

Add to `settings.php` (or an environment-specific include such as `settings.local.php`):

```php
$config['disable_user_1.settings']['disable_user_1'] = TRUE;
```

Then rebuild the cache (`drush cr`). From that point, any request whose current user is uid 1 triggers
`user_logout()` + a redirect to `/`, so uid 1 cannot keep a browser session.

Per-environment activation is the common pattern: leave it out of shared `settings.php` and set it only
in the production include, so uid 1 stays usable in local/dev builds.

## Deactivate / recover

1. Remove (or set to `FALSE`) the `$config['disable_user_1.settings']['disable_user_1']` line in
   `settings.php`.
2. Rebuild the cache: `drush cr`.

uid 1 can then log in through the browser again. Uninstalling the module (`drush pmu disable_user_1`)
has the same effect. Because Drush runs outside the HTTP kernel the subscriber listens on, command-line
administration remains available while the feature is active — including turning it off.

## Behaviour notes

- The check is per request (kernel `REQUEST` event), not a login-form alter, so it applies uniformly to
  the login form, one-time login links (`user/reset/…`) and password-reset flows: uid 1 is signed out
  on the next page load after any of them.
- The subscriber acts only when the current user id equals 1; no other account is affected.
