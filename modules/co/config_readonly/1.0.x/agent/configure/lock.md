<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Turning the lock on, whitelisting, and checking state

`config_readonly` has **`configure: null`** — no settings form, no config object of its own.
Everything is driven from `settings.php` (`web/sites/default/settings.php`).

## Enable the lock

```php
// settings.php
$settings['config_readonly'] = TRUE;
```

That single line activates both guards (storage + forms). Enabling the *module* without this
line does nothing except swap the storage class; `/admin/reports/status` then shows
**"Config is writable — The Config Read-only module is enabled but not active."**

Common conditional variants (all from the project README):

```php
// Lock only production (Acquia example).
if (isset($_ENV['AH_SITE_ENVIRONMENT']) && $_ENV['AH_SITE_ENVIRONMENT'] === 'prod') {
  $settings['config_readonly'] = TRUE;
}

// Lock the UI but let drush/CLI through (discouraged — anyone with shell bypasses it).
if (PHP_SAPI !== 'cli') {
  $settings['config_readonly'] = TRUE;
}

// Break-glass: a file outside the docroot disables the lock.
if (!file_exists('/home/myuser/disable-readonly.txt')) {
  $settings['config_readonly'] = TRUE;
}
```

## Whitelist config that stays editable

Two equivalent sources, merged by `hook_config_readonly_whitelist_patterns()`:

```php
// settings.php — read by config_readonly's own hook implementation.
$settings['config_readonly_whitelist_patterns'] = [
  'system.maintenance',
  'webform.webform.*',
];
```

or from a module (see [hooks/extension-points.md](../hooks/extension-points.md)).

Pattern rules (`ConfigReadonlyWhitelistTrait::matchesWhitelistPattern()`):
- The pattern is `preg_quote`d, then `\*` is turned back into `.*` — **`*` is the only
  wildcard**, everything else is literal.
- The match is anchored: `'/^' . $escaped . '$/'`. `system.site` does **not** match
  `system.site.foo`; use `system.site*` for that.
- A `ConfigEntityListBuilder` form is checked against `<config_prefix>.*`
  (e.g. `views.view.*`), an entity form against the entity's config dependency name
  (e.g. `views.view.frontpage`).
- A `ConfigFormBase` is only unlocked when **every** name in its
  `getEditableConfigNames()` plus every `#config_target` in the form matches the whitelist.

## Check whether the lock is active

```bash
# Is the setting on?
drush php:eval 'var_dump(\Drupal\Core\Site\Settings::get("config_readonly"));'

# Which storage class is in use? (always ConfigReadonlyStorage when the module is enabled)
drush php:eval 'print get_class(\Drupal::service("config.storage"));'

# What are the effective whitelist patterns (settings.php + all hook implementations)?
drush php:eval 'print_r(\Drupal::moduleHandler()->invokeAll("config_readonly_whitelist_patterns"));'

# Status report line ("Config is readonly" / "Config is writable").
drush core:requirements --filter=title~=/Read-only/
```

Probe the lock without changing anything permanent:

```bash
drush php:eval '
try { \Drupal::configFactory()->getEditable("system.site")->set("slogan","x")->save(); print "WRITABLE\n"; }
catch (\Drupal\config_readonly\Exception\ConfigReadonlyStorageException $e) { print "LOCKED\n"; }'
```

## What a locked site looks like

- Every `ConfigFormBase` / config-entity form shows the warning *"This form will not be
  saved because the configuration active store is read-only."* plus a list of the config
  names you would need to whitelist; the submit buttons are `#disabled`, and a validate
  handler (`_config_readonly_validate_failure`) fails the form anyway.
- `/admin/modules` and `/admin/modules/uninstall` are blocked (`system_modules`,
  `system_modules_uninstall`), as are `/admin/people/permissions`
  (`user_admin_permissions`) and the single-config import form.
- `drush config:import` **still works** — the importer holds the `config_importer` lock and
  `checkLock()` returns early. `update.php` also still works.
- Direct `$config->save()` from code throws `ConfigReadonlyStorageException`.

## Uninstalling / temporarily lifting the lock

Remove or comment out `$settings['config_readonly']` and rebuild caches (`drush cr`).
Uninstalling the module while the lock is on is itself blocked through the UI; do it from
the CLI (`drush pmu config_readonly -y`) after clearing the setting.
