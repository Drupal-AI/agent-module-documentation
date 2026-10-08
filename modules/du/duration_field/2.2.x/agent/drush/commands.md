<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

One command, registered via `drush.services.yml`
(`Drupal\duration_field\Commands\DurationFieldCommand`).

## `duration_field:prepare_uninstall`

- **Alias:** `df-pu`
- **Purpose:** Prepare the module for uninstall by **deleting every `duration` field** in the
  system (both the `FieldConfig` instances and their `FieldStorageConfig`). Drupal refuses to
  uninstall a module while fields of its type still exist, so this clears them.
- **Behaviour:** prompts for confirmation ("This will delete all duration field in the
  database, with no means to retrieve it."), then lists and deletes each
  `entity_type:bundle:field_name`. Answering no aborts.
- **Data loss:** irreversible — it drops the field data, not just the config.

```bash
drush duration_field:prepare_uninstall     # or: drush df-pu
# then:
drush pmu duration_field -y
```

It discovers fields with `duration_field_get_duration_fields()`, which scans every entity
type/bundle for fields of type `duration`.
