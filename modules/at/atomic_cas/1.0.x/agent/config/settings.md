<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: blob roots, acceleration, requirements, admin report

All configuration lives in **settings.php** (read via `Drupal\Core\Site\Settings`), not in a config
entity or a settings form. `configure` is null; `provides_config_schema` is false. The value object
is `Drupal\atomic_cas\CasSettings` (`src/CasSettings.php`), built by the factory
`CasSettings::fromDrupalSettings()` (service `atomic_cas.settings`).

## Install / enable

```bash
composer require drupal/atomic_cas
drush en atomic_cas
```

`hook_install()` prints a status message reminding you to add the blob roots. The module installs
**without** roots configured (intentional, for CI/dev); missing roots become a runtime
`REQUIREMENT_ERROR`, not an install blocker.

## Required settings.php keys (constants in CasSettings)

```php
// Absolute paths, writable by the web server, OUTSIDE the document root.
$settings['atomic_cas_public_root']  = '/var/cas-storage/public';   // KEY_PUBLIC_ROOT
$settings['atomic_cas_private_root'] = '/var/cas-storage/private';  // KEY_PRIVATE_ROOT
```

`getBlobRoot($scheme)` maps `cas-public`→public root, `cas-private`→private root (unknown scheme →
`InvalidArgumentException`); an empty root throws `RuntimeException` at ingest/serve time. Trailing
slashes are stripped on load.

## Optional server acceleration (choose AT MOST one)

```php
// Nginx: internal location prefix mapping to the blob root.
$settings['atomic_cas_x_accel_redirect'] = '/internal/cas';   // KEY_X_ACCEL_REDIRECT
// Apache mod_xsendfile:
$settings['atomic_cas_x_sendfile'] = TRUE;                     // KEY_X_SENDFILE
```

`getXaccelRedirectPrefix()` returns the prefix or NULL; `isXsendfileEnabled()` returns the bool;
`hasAcceleration()` is true if either is set. The serve controller checks X-Accel first, then
X-Sendfile, then falls back to PHP `readfile()`. Enabling both is a config error (see validate()).

## Validation → Status Report (hook_requirements)

`CasSettings::validate()` returns a map keyed by settings key, checking, per scheme: root configured,
`is_dir`, `is_writable`; plus the "both acceleration methods enabled" conflict. `atomic_cas_requirements('runtime')`
(`atomic_cas.install`) renders each problem as `REQUIREMENT_ERROR` on `/admin/reports/status`, or a
single `REQUIREMENT_OK` "Blob roots configured and accessible" when clean.

## Admin dashboard

- Route **`atomic_cas.admin`** → `/admin/reports/atomic-cas` → `CasAdminController::overview()`.
- Permission **`administer atomic cas`** (`restrict access: true`). Menu link `atomic_cas.admin`
  under `system.admin_reports` (weight 10).
- Shows `AtomicCasManager::getStats()` (managed file count, unique blobs, actual vs. virtual bytes,
  space saved, dedup ratio, orphan count, per-scheme breakdown) and `getLargestBlobs(25)`. Warns and
  links to `drush atomic-cas:gc` when orphans exist.

## Uninstall

`hook_uninstall()` warns that the `atomic_cas_blob`/`atomic_cas_map` tables are dropped by Drupal but
**physical blobs are NOT deleted** — remove them manually (run `drush atomic-cas:gc --dry-run` first).
