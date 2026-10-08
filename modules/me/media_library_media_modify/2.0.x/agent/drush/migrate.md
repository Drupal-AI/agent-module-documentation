<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: migrate an entity_reference field to contextual overrides

One command (via `drush.services.yml` → `MigrateCommands`).

## Command

```
drush media_library_media_modify:migrate <entity_type_id> <field_name>
```

Arguments (both required, positional):

- `entity_type_id` — e.g. `node`, `taxonomy_term`, `paragraph`.
- `field_name` — the machine name of an existing **`entity_reference`** field on that entity
  type, e.g. `field_media`.

## What it does

Delegates to `EntityReferenceOverrideService::migrateEntityReferenceField()`, which:

1. Verifies the field storage type is `entity_reference` (errors otherwise).
2. Adds the `<field_name>_overwritten_property_map` column (`text`, `big`) to
   `<entity_type>__<field>` (and `<entity_type>_revision__<field>` if revisionable).
3. Updates the last-installed field storage definitions and stored SQL schema data.
4. Sets the field **storage** and each bundle **field config** type to
   `entity_reference_entity_modify`, recalculating dependencies.
5. Switches each affected bundle form-display component to the modify widget (default
   settings).

On success prints "Migration complete." Errors (e.g. wrong field type) are printed via
`io()->error()`.

## Example

```bash
# Convert node.field_media (an entity_reference field) to support contextual overrides:
drush media_library_media_modify:migrate node field_media
# Verify:
drush php:eval 'print \Drupal::config("field.storage.node.field_media")->get("type");'
# -> entity_reference_entity_modify
```

There is no built-in reverse command; migrating back would mean the same steps in reverse
(change the type and drop the column).
