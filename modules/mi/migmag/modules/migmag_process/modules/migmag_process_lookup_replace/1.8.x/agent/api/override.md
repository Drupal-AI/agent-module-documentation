<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_process_lookup_replace — the override

Entire module logic (`migmag_process_lookup_replace.module`):

```php
function migmag_process_lookup_replace_migrate_process_info_alter(&$definitions) {
  if (!empty($definitions['migration_lookup'])) {
    $definitions['migration_lookup']['class'] = MigMagLookup::class;
  }
}
```

`MigMagLookup` = `Drupal\migmag_process\Plugin\migrate\process\MigMagLookup` (provided by the
parent `migmag_process` module). So every `plugin: migration_lookup` in every migration now
instantiates `MigMagLookup` instead of core `MigrationLookup` — no YAML edits needed.

## Enable / disable

```bash
drush en migmag_process_lookup_replace -y     # override on (pulls in migmag_process)
drush pmu migmag_process_lookup_replace -y    # override off
```

Process plugin definitions are cached — after toggling, a cache rebuild (`drush cr`) ensures
the altered definition is picked up.

## Verify

```php
\Drupal::service('plugin.manager.migrate.process')
  ->getDefinition('migration_lookup')['class'];
// enabled  -> Drupal\migmag_process\Plugin\migrate\process\MigMagLookup
// disabled -> Drupal\migrate\Plugin\migrate\process\MigrationLookup
```

No configuration exists. To override only some migrations instead of globally, don't enable
this module — reference `plugin: migmag_lookup` directly in those migrations.
