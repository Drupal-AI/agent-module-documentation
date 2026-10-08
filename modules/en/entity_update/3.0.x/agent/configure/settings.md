<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & admin routes

## The only config object: `entity_update.settings`

```yaml
# config/install/entity_update.settings.yml (shipped default)
excludes:
  user: user
  user_role: user_role
```

`excludes` is a checkbox set of **entity type ids that must never be deleted and recreated** by
the safe update path. The form (`Drupal\entity_update\Form\Settings`, form id
`entity_update_settings`) lists every entity type from
`\Drupal::entityTypeManager()->getDefinitions()` labelled `"<label> (<group>)"`, and stores the
raw `checkboxes` value — i.e. checked ids map to themselves, unchecked ids map to `0`.

Read / write:

```bash
drush config:get entity_update.settings excludes
drush config:set entity_update.settings excludes.taxonomy_term taxonomy_term -y
```

```php
use Drupal\entity_update\EntityUpdateHelper;

EntityUpdateHelper::getConfigName();          // 'entity_update.settings'
EntityUpdateHelper::getConfig();              // ImmutableConfig
EntityUpdateHelper::getConfig(TRUE)           // editable
  ->set('excludes', ['user' => 'user', 'user_role' => 'user_role', 'node' => 'node'])
  ->save();
```

Schema (`config/schema/entity_update.schema.yml`) declares `excludes` as a mapping with only
`user` and `user_role` typed as strings, so adding other keys works at runtime but will be
flagged by strict config-schema checking in tests.

## Routes (all require `administer software updates`)

| Route | Path | What it is |
|---|---|---|
| `entity_update` | `/admin/config/development/entity-update` | Admin menu block landing page |
| `entity_update.settings` | `/admin/config/development/entity-update/settings` | The `excludes` form |
| `entity_update.exec` | `/admin/config/development/entity-update/exec/{action}` | Run the update (**the `configure` route**); `action` defaults to `default`, local tasks provide `basic`, `type`, `clean`, `rescue` |
| `entity_update.types` | `/admin/config/development/entity-update/types` | Entity types list (`EntityUpdateStatus::entityTypes`) |
| `entity_update.status` | `/admin/config/development/entity-update/status` | Pending schema changes (`EntityUpdateStatus::entityStatus`) |
| `entity_update.list` | `/admin/config/development/entity-update/list/{entity_type_id}/{start}/{length}` | Paged entity record list (defaults `''`, `0`, `10`) |

Menu links sit under *Configuration → Development → Entity update*; action links cross-link
Types / Status / Run / List.

## Database table

`hook_schema()` creates one table, **`entity_update`**, used as the entity backup store:

| Column | Type |
|---|---|
| `id` | serial, primary key |
| `entity_type` | varchar(64), not null |
| `entity_id` | varchar(64), not null |
| `entity_class` | varchar(255), not null |
| `status` | small int, default 0 |
| `data` | big blob (serialized entity) |

Unique key `entity` on (`entity_type`, `entity_id`). Emptied by `drush upe --clean` /
`EntityUpdate::cleanupEntityBackup()`.
