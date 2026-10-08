# Activate splits & override status in code

## Per-environment activation in `settings.php`

Force a split on/off for a specific environment by overriding its config entity's `status`:

```php
// Only on this environment, activate the "dev" split.
$config['config_split.config_split.dev']['status'] = TRUE;
// ...and make sure a "production" split is off locally.
$config['config_split.config_split.production']['status'] = FALSE;
```

Because the split entity is config, this is a standard config override and is the recommended
way to vary which splits apply between dev/stage/prod.

## Runtime status override (state)

`StatusOverride` (service `config_split.status_override`) stores a per-split active/inactive
flag in `state`, letting you toggle a split without changing the entity or `settings.php`:

```php
/** @var \Drupal\config_split\Config\StatusOverride $override */
$override = \Drupal::service('config_split.status_override');
$override->setSplitOverride('dev', TRUE);   // TRUE=active, FALSE=inactive, NULL=clear
$state = $override->getSplitOverride('dev'); // TRUE|FALSE|NULL
```

Equivalent to `drush config-split:status-override`.

## Key services

- `config_split.manager` (`ConfigSplitManager`) — core split/merge logic: build the filtered
  export, split a config subset off, merge a split back in.
- `config_split.cli` (`ConfigSplitCliService`) — the operations behind the Drush commands
  (export/import/activate/deactivate a split).
- `config_split.status_override` — runtime status flags (above).
- `SplitImportExportSubscriber` — event subscriber that applies active splits during the normal
  core config import/export.
