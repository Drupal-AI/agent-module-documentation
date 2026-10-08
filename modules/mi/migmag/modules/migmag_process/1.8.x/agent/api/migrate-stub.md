<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `migmag_process.lookup.stub` service

`migmag_process` registers a public service **`migmag_process.lookup.stub`**
(`Drupal\migmag_process\MigMagMigrateStub`, extends core `MigrateStub`). It is registered by
`MigmagProcessServiceProvider::register()` **only when** `plugin.manager.migration` exists in
the container.

## Why it exists

Core's stub service can't stub a *partial* entity ID. When an entity reference points at
node 17, and node 17 is the French translation of node 13, a stub for node 13 is needed —
references identify an entity only by its `id` key, not revision or langcode.
`MigMagMigrateStub` handles this, and guards re-entrancy with a static
`$mainStubProcessHasStarted` flag so it does not create nested "sub-stubs".

## Using it

`migmag_lookup` uses this service internally, so normally you just use the plugin. To call it
directly from custom code:

```php
$stub = \Drupal::service('migmag_process.lookup.stub');
$ids = $stub->createStub($migration_id, $source_ids, $default_values = [], $key_by_destination_ids = NULL);
```

Check availability first: `\Drupal::hasService('migmag_process.lookup.stub')`.

No configuration. No routes/permissions/Drush.
