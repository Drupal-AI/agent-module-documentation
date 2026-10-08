# Migrate File To Media — Drush commands

Registered via `drush.services.yml` (`MediaMigrateCommands`). Drush 12/13 discovers them through
the module's `composer.json` `extra.drush.services`.

## `migrate:file-media-fields` (alias `mf2m`)

```bash
drush migrate:file-media-fields <entity_type> <bundle> <source_field_type> <target_media_bundle>
# example: create media fields for all image fields on Article, targeting the 'image' media type
drush migrate:file-media-fields node article image image
```

For every field on `<entity_type>.<bundle>` whose type is `<source_field_type>` (e.g. `image` or
`file`), it creates a **new** entity-reference field named `<field>_media` pointing at the
`<target_media_bundle>` media type, and adds it to the bundle's form/view displays. Run this
first — it builds the destination fields the step-2 migration writes into.

Note: the bundle must already have default form/view displays (the command calls `setComponent()`
on them); brand-new bundles created without displays will error.

## `migrate:duplicate-file-detection` (alias `migrate-duplicate`)

```bash
drush migrate:duplicate-file-detection <migration_name>
drush migrate:duplicate-file-detection <migration_name> --check-existing-media
```

Calculates a binary hash for every file referenced by the migration's `media_entity_generator`
source and stores it in the `migrate_file_to_media_mapping` table, so duplicate binaries collapse
to one media entity. **Must be run before importing step 1.** `--check-existing-media` also
matches against already-existing media (see the next command).

## `migrate:duplicate-media-detection` (alias `migrate-duplicate-media`)

```bash
drush migrate:duplicate-media-detection <media_bundle> [<field>] [--all]
# example:
drush migrate:duplicate-media-detection image --all
```

Hashes existing media entities into `migrate_file_to_media_mapping_media` so an import can reuse
them instead of creating duplicates. Optional step, run before duplicate-file-detection with
`--check-existing-media`.

## Generator: `mf2m_media` (`drush generate mf2m_media`)

```bash
drush migrate_file_to_media:media_migration_generator   # long name
drush generate mf2m_media                                # alias
```

Interactive generator (Drush generator services `…generator.v1` / `…generator.v2`) that scaffolds
the step-1/step-2 migrate_plus migration YAML files into a module of your choice, asking for the
module machine name, source bundle and target media entity. Enable that module (or use
`config_devel`) so `drush migrate:status` lists the migrations.

## Typical order

```bash
drush migrate:file-media-fields node article image image        # 1. build <field>_media fields
drush migrate:duplicate-file-detection <step1_migration>         # 2. hash files (dedupe)
drush migrate:import <step1_migration>                           # 3. create media entities
drush migrate:import <step2_migration>                           # 4. link media onto entities
```
