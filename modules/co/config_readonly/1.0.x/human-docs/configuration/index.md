# Configuration

Configuration Read-only has **no settings form** — it is configured entirely from your
site's `settings.php` (typically `web/sites/default/settings.php`). This page covers the
three things you will do there: turn the lock on, whitelist config that must stay editable,
and confirm the lock is active.

## Turn the lock on

The single switch is:

```php
$settings['config_readonly'] = TRUE;
```

That one line activates both guards — the storage guard (config writes throw an exception)
and the form guard (Save buttons are disabled). Rebuild caches (`drush cr`) after changing
it.

### Lock only production

You almost always want the lock on production but *off* in development, so wrap it in a
condition. A few common patterns:

```php
// Lock only on a specific hosting environment (Acquia example).
if (isset($_ENV['AH_SITE_ENVIRONMENT']) && $_ENV['AH_SITE_ENVIRONMENT'] === 'prod') {
  $settings['config_readonly'] = TRUE;
}

// "Break glass": the lock is off whenever a named file exists outside the docroot.
if (!file_exists('/home/myuser/disable-readonly.txt')) {
  $settings['config_readonly'] = TRUE;
}
```

There is also a `PHP_SAPI !== 'cli'` pattern that leaves Drush/CLI writable, but it is
discouraged — anyone with shell access then bypasses the lock entirely.

## Whitelist config that must stay editable

Sometimes one or two config objects need to stay changeable even on a locked site — for
example so an administrator can still toggle maintenance mode. List glob-style patterns:

```php
$settings['config_readonly_whitelist_patterns'] = [
  'system.maintenance',   // exact config name
  'webform.webform.*',    // every webform config object
];
```

Pattern rules to keep in mind:

- **`*` is the only wildcard**, and the pattern must match the *whole* config name. So
  `system.site` matches only `system.site`, not `system.site.foo` — use `system.site*` if
  you mean the latter.
- Patterns are matched against **config object names**, not routes or form ids.
- To unlock a config-entity *list* page (like the Views listing), whitelist the prefix form,
  e.g. `views.view.*`.
- A settings form is only unlocked when *every* config name it edits is whitelisted.

A custom module can supply the same patterns from
`hook_config_readonly_whitelist_patterns()` instead of hard-coding them in `settings.php` —
both sources are merged.

## Check whether the lock is active

The site **Status report** at `/admin/reports/status` has a *Config Read-only mode* line:
it reads *"Config is readonly"* when the lock is on and *"Config is writable"* when the
module is enabled but the setting is off.

## What a locked site looks like

- Every configuration form shows the warning *"This form will not be saved because the
  configuration active store is read-only,"* lists the config names you would need to
  whitelist, and has its Save button disabled.
- The modules install/uninstall screens, the permissions screen, and the single-config
  import form are all blocked.
- **`drush config:import` still works** — the importer bypasses the lock — and `update.php`
  still runs, so deployments and database updates are unaffected.

## Lifting the lock

Remove or comment out `$settings['config_readonly']` (and adjust any surrounding condition),
then rebuild caches with `drush cr`.
