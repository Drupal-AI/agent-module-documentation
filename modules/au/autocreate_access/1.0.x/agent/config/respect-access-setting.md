<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Respect access setting (per-field opt-in)

There is **no global config object and no settings route**. Behavior is controlled per field via a
third-party setting on the `field.field.*` config entity.

## Enable
1. `drush en autocreate_access -y` (no dependencies).
2. Edit an `entity_reference` field whose selection handler is the **default** core handler and has
   "Create referenced entities if they don't already exist" (`handler_settings.auto_create`) ticked.
3. A "**Respect access**" checkbox appears just below it (`#weight -2`). Tick it and save.

The checkbox is added by `autocreate_access_form_field_config_edit_form_alter()`
(`autocreate_access.module`). It is only rendered when:
- `$entity->get('field_type') === 'entity_reference'`, and
- `$form['settings']['handler']['handler_settings']['auto_create']` is non-empty (autocreate available).

Its `#states` hide it unless the `auto_create` checkbox is checked. Default value is the field's existing
`autocreate_access.enabled` third-party setting (`FALSE` if unset).

## Storage
The checkbox writes to `#parents = ['third_party_settings', 'autocreate_access', 'enabled']`, so the value is
saved as the field's third-party setting `autocreate_access.enabled` (boolean).

Schema (`config/schema/autocreate_access.schema.yml`):
```
field.field.*.*.*.third_party.autocreate_access:
  type: mapping
  mapping:
    enabled:
      type: boolean
```

## Unticking / cleanup
`autocreate_access_field_config_presave()` runs on field save:
- Returns early if `$entity->isSyncing()` (no changes during config import/sync).
- If `enabled` is falsy, it **unsets** the third-party setting entirely (avoids storing `FALSE`) and removes
  `autocreate_access` from the field's calculated `dependencies.module` (removing the whole `module` key if it
  becomes empty). This keeps exported config clean and dependency-free when the feature is off.
