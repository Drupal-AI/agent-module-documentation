<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: update:correct-field-config-storage

The module's entire surface. A classic annotated Drush commandfile
(`Drupal\update_config_entity\Commands\UpdateCommands`, extends `Drush\Commands\DrushCommands`),
registered in `drush.services.yml` as service `update.commands` with tag `drush.command`, injecting
the `@keyvalue` factory (`Drupal\Core\KeyValueStore\KeyValueFactoryInterface`).

## Command

| Command | Arguments | Aliases | Options | Description |
| --- | --- | --- | --- | --- |
| `update:correct-field-config-storage` | `entity_type` `bundle` `field_name` (all required, positional) | none | none | Removes one field→bundle listing from the bundle field map for the given entity type. |

Method: `correctFieldStorageConfig($entity_type, $bundle, $field_name)`.

## What it does at runtime

The four-line body:

```php
$field_map_kv_store = $this->keyValueStore->get('entity.definitions.bundle_field_map');
$map = $field_map_kv_store->get($entity_type);
unset($map[$field_name]['bundles'][$bundle]);
$field_map_kv_store->set($entity_type, $map);
```

1. Gets the key-value collection `entity.definitions.bundle_field_map` (via the injected factory — the property named `keyValueStore` actually holds the *factory*, `KeyValueFactoryInterface`).
2. Loads that entity type's field map: an array keyed by field name, each entry carrying a `bundles` sub-array of the bundles that use the field.
3. Unsets `[$field_name]['bundles'][$bundle]` — dropping just that one field-on-that-bundle listing.
4. Writes the modified map back for the entity type.

No return value, no output, no confirmation prompt, no dry-run, and no validation that the entity type / bundle / field actually exist in the map.

## Usage

```bash
# The getBundles() error names the entity type and bundle. Real-world example:
# remove comment_body from the stale "comment_node_site" bundle of the "comment" entity type.
drush update:correct-field-config-storage comment comment_node_site comment_body
drush cr
```

Argument order is entity type, bundle, field name — matching the method signature.

Inspect the map before/after:

```bash
drush php:eval '
$map = \Drupal::keyValue("entity.definitions.bundle_field_map")->get("comment");
print_r(array_map(fn($f) => array_keys($f["bundles"] ?? []), $map));'
```

## Notes / cautions

- Enable the module first (`drush en update_config_entity`); there is no config to set up afterward.
- `entity.definitions.bundle_field_map` is a derived, cache-like store, not config. If the underlying cause persists (a field storage still referencing the bundle), the entry can be rebuilt on the next cache / entity-definition rebuild — fix the root cause too.
- No confirmation and no argument validation: pass exactly the entity type / bundle / field the error reports. Back up the store with the `php:eval` snippet above if you want a record.
- Requires Drush; depending on environment invoke as `vendor/bin/drush` or `ddev drush`.
- Single-purpose repair tool — uninstall once the site is repaired.
