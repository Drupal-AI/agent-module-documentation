# Configuration

No UI. Configure the `migrate_boost.settings` config object, normally via `settings.php`
overrides so it never ships in exported config. Two keys are read by the decorator
(`MigrateBoostModuleHandler`):

## `hooks` — suppress a specific hook for specific modules

```php
$config['migrate_boost.settings']['hooks'] = [
  'entity_insert'    => ['workbench_moderation', 'pathauto', 'xmlsitemap'],
  'entity_presave'   => ['xmlsitemap'],
  'entity_predelete' => ['flag'],
];
```

Each key is a hook name; the value is the list of modules whose implementation of that hook is
skipped while boost is active. Used by `isHookDisabled()` / `getDisabledModulesForHook()`.

## `modules` — suppress ALL hooks of a module

```php
$config['migrate_boost.settings']['modules'] = [
  'workbench_moderation',
  'pathauto',
  'xmlsitemap',
];
```

Every hook of every listed module is skipped while boost is active
(`getModulesAllHooksDisabled()`).

## When suppression is active

- OFF for all normal HTTP requests — `HooksEnablerSubscriber` calls `MigrateBoost::bootDrupal()`
  (→ `disable()`) on `kernel.request` (priority 20), so a stray active flag can't affect the
  site front end.
- ON only inside Drush `migrate:import` / `migrate:rollback` (see
  [../drush/commands.md](../drush/commands.md)), or when you call
  `MigrateBoost::enable()` / `drush migrate:booster:enable` yourself.

## Notes

- The shipped `config/install/migrate_boost.settings.yml` contains only
  `commands: [migrate-import, migrate-rollback]`; the `commands` key is documentation of the
  auto-boosted commands and is **not** read by the decorator (only `hooks` and `modules` are).
- There is no config schema, so set these via `settings.php` (`$config[...]`) rather than the
  config UI.
- Suppressing hooks changes migration side effects — regenerate aliases/sitemaps/indexes
  afterwards with the relevant Drush commands.
