<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route and access gating

## Route

`drush_endpoint.routing.yml` defines one route, `drush_endpoint.execute`:

- Path: `/api/drush/{command}` — `{command}` is a single path segment.
- `_controller: Drupal\drush_endpoint\Controller\DrushController::executeCommand`
- `_title: 'Execute Drush Command'`
- `methods: [POST]` — POST only.
- `requirements._custom_access: 'drush_endpoint.access_checker:access'`
- `options._auth: ['basic_auth']` — makes the basic_auth provider available on this route.

## Enabling the endpoint (settings flags)

The endpoint is inert on a fresh install. It is switched on entirely through `$settings` in a settings
file (the maintainer documents this as `settings.local.php`, for dev/CI only — not production):

```php
$settings['drush_endpoint_enabled'] = TRUE;   // required for any command
$settings['drush_endpoint_allow_uli'] = TRUE; // additionally required for the `uli` command
```

Both default to `FALSE`. There is no admin form and no config object; these flags are the only switches.

## Access checker

`Drupal\drush_endpoint\Access\DrushEndpointAccessChecker::access(AccountInterface $account, ?string $command)`
(`src/Access/DrushEndpointAccessChecker.php`) is the `_custom_access` callback. It returns an
`AccessResultInterface` after three checks, in order:

1. `Settings::get('drush_endpoint_enabled', false)` — if not `TRUE`, returns
   `AccessResult::forbidden('Drush endpoint is not enabled in settings.php')`.
2. If `$command === 'uli'`, requires `Settings::get('drush_endpoint_allow_uli', false)`, else
   `AccessResult::forbidden('ULI is not allowed in settings.php')`.
3. `in_array($command, self::ALLOWED_COMMANDS, true)` — if the command is not an exact match for an
   allowlist entry, returns `AccessResult::forbidden('Command not in allowed list')`. Otherwise
   `AccessResult::allowed()`.

`ALLOWED_COMMANDS` (a private const on the class): `cr`, `cron`, `uli`, `mim`, `mr`, `sapi-i`, `sapi-r`.
The comparison is strict (`true` third arg) and matches the whole `{command}` string, so only the exact
bare command names are accepted (no extra arguments).

## Notes for operators

- The module ships **no permissions** and no admin UI — by design, as a testing tool. Access is controlled
  solely by the two settings flags plus the command allowlist described above.
- The maintainer's README/help are explicit that this must be used only in isolated dev/CI environments and
  never enabled on production, and that the `/api/drush/*` path should be restricted at the environment level.
