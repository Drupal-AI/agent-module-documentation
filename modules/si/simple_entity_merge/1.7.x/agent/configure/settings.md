<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings form & the `exclude` list

- **Route:** `simple_entity_merge.settings` → `admin/config/content/simple_entity_merge`
  (permission `administer simple_entity_merge`).
- **Form:** `Drupal\simple_entity_merge\Form\Settings` (`ConfigFormBase`, id `simple_entity_merge_settings`).
- **Config object:** `simple_entity_merge.settings` (editable name returned by `getEditableConfigNames()`).

## Config keys

| Key | Type (schema) | Default (`config/install`) | Meaning |
|-----|---------------|----------------------------|---------|
| `exclude` | `string` | `node_type,block_content_type` | Comma-delimited list of entity **type ids** for which the Merge tab/route is NOT created. |

The settings form exposes `exclude` as a single textarea ("Disable simple_entity_merge for these
entity types. Enter as entity_type_id, comma-delimited."). It is stored verbatim as a string;
`simple_entity_merge_entity_type_alter()` reads it with `array_map('trim', explode(',', $exclude))`.

## How the exclude list is applied

For every entity type NOT in `exclude`, the module adds the Merge form + link **only if** the type
also has a default/edit form class and an `edit-form` link template (see
[hooks/entity-integration.md](../hooks/entity-integration.md)). So excluding a type removes its
Merge tab and its `entity.<type>.simple_entity_merge_execute` route.

## Set it from drush / PHP

```bash
# Exclude nodes, block content types and users from merging:
ddev drush config:set simple_entity_merge.settings exclude "node_type,block_content_type,user" -y
ddev drush cr   # rebuild routes/links — the value only takes effect after a cache rebuild
```

```php
\Drupal::configFactory()
  ->getEditable('simple_entity_merge.settings')
  ->set('exclude', 'node_type,block_content_type,user')
  ->save();
drupal_flush_all_caches(); // route subscriber + entity_type_alter run on rebuild
```

Note: the value is a raw comma string, not a list — pass one string, not a YAML array.
A cache rebuild is required because the exclusion is consumed in `hook_entity_type_alter()`
(which drives route generation and the local-task deriver).
