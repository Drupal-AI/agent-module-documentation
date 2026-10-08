<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dis — status-report warning & operating it

The entire module is `dis.install`. There is nothing to configure in the UI.

## Install / enable

- `composer require drupal/dis` then `drush en dis` (or via *Extend*).
- `dis_install()` adds one status message (linking to `system.status`); `dis_uninstall()` adds one
  on removal. The module writes **no config** and leaves nothing behind on uninstall.

## The requirements hook

`dis_requirements($phase)` (implements `hook_requirements()`):

- Runs only when `$phase == 'runtime'` (i.e. when `/admin/reports/status` is rendered, or
  `drush core:requirements` runs).
- Reads `$deployment_identifier = Settings::get('deployment_identifier');`.
- If it is strictly `NULL`, returns a requirement keyed `'deployment identifier'`:
  - `title` → "Deployment identifier"
  - `value` → "Not set"
  - `severity` → `REQUIREMENT_WARNING`
  - `description` → explains that the DI container is auto-invalidated on core version changes, and
    that changing this identifier lets the container be invalidated as soon as container-changing
    code is deployed.
- If the setting has any non-null value, the hook returns an empty array → **no row** on the report.

Note the check is `=== NULL`, so an empty string or `''` would count as "set" and suppress the
warning; only an unset/`NULL` value triggers it.

## Clearing the warning

Set the identifier in `sites/default/settings.php` (or a settings include), for example:

```php
$settings['deployment_identifier'] = \Drupal::VERSION;
```

or stamp a build/commit value from your deployment pipeline:

```php
$settings['deployment_identifier'] = getenv('DEPLOY_SHA') ?: 'manual';
```

Any non-null value removes the status-report warning on the next rebuild. The value's meaning:
Drupal uses `deployment_identifier` as part of the cache/container invalidation key, so changing it
on each deploy forces the service container to rebuild when container-affecting code changes.

## What it does NOT provide

No forms, routes, permissions, services, plugins, config objects, schema, Drush commands, libraries,
or submodules. It is purely a read of an existing core setting surfaced on the status report.
