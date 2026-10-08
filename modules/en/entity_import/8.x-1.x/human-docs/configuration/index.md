# Configuration

Entity Import is configured by building **importers** in the admin UI. Each
importer is a reusable definition that describes where the data comes from and how
it maps onto Drupal entities. You need the module's administer permission to reach
these screens.

> **Before you start:** importing writes content — it can create *and overwrite*
> entities. Work on a non‑production copy or take a backup first, restrict importer
> access to trusted roles, and review your mappings and source file before running
> against a live site.

## Build an importer

Creating an importer walks through, roughly, these decisions:

1. **Choose the target.** Pick the entity type (and bundle) you are importing into
   — for example nodes of a given content type, taxonomy terms, or users.
2. **Choose the source.** Out of the box the source is a **CSV file**; with the
   `entity_import_plus` submodule enabled, additional source types are available.
   Point the importer at your source and tell it about the columns it contains.
3. **Map source fields to entity fields.** For each destination field, choose which
   source column supplies its value. This is the heart of the importer and mirrors
   the process mappings you would otherwise write in a migration YAML file.
4. **Add processing and transformations.** Where a value needs adjusting on the way
   in, apply Migrate‑style processors — migration lookups, entity lookups, string
   replacement and similar — so imported values land in the right shape and link to
   the right existing entities.
5. **Declare dependencies (optional).** If one import must run before another (for
   example, importing categories before the content that references them), express
   that dependency so the related imports are managed and run together in one
   interface.

## Run the import

Once an importer is defined, run it from the same interface. Because Entity Import
sits on the Migrate API, a run behaves like a migration — it creates new entities
and updates matching existing ones according to your mappings.

## After importing

Review the imported content and check that field mappings produced the values you
expected, especially for lookups and references. If something is off, adjust the
mapping or the source file and re‑run. Keep the backup you took until you are
satisfied the import is correct.
