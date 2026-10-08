# Configuration

Setting up Denormalizer has two halves: describing *what* to flatten (in code),
and *building* it (in the admin UI). This page is more technical than most,
because defining the data set is a developer task.

> ## ⚠️ Destructive operations
>
> Denormalizer creates databases and performs destructive operations on tables
> and views. There are sanity checks to prevent overwriting your own tables, but
> back up first, prefer a dedicated destination database, and always review the
> **Export** tab's SQL before running **Create**.

## 1. Describe the data in code

In a custom module, implement **`hook_denormalizer_info()`** to list the tables
and entities you want denormalized. Each item can be a plain Drupal table, a
Drupal entity (with bundles and a "changed" key for incremental updates), or an
external table:

```php
/**
 * Implements hook_denormalizer_info().
 */
function mymodule_denormalizer_info() {
  return [
    // A plain Drupal table.
    'location' => [
      'base table' => 'location',
    ],
    // A typical entity, limited to certain bundles.
    'denormalized_table' => [
      'entity_type' => 'node',
      'bundles' => ['page', 'story'],
      'changed_key' => 'changed',
    ],
    // An external table.
    'ScormActivity' => [
      'base table' => 'ScormActivity',
      'external' => TRUE,
      'changed_key' => 'update_dt',
    ],
  ];
}
```

The `changed_key` is what lets table mode update incrementally on later runs
rather than rebuilding everything.

## 2. Configure and build in the admin UI

Go to **Configuration → Development → Denormalizer**
(`/admin/config/development/denormalizer`) and set:

- **Prefixes** — the naming prefix applied to the views or tables Denormalizer
  creates.
- **View mode vs. Table mode:**
  - **View mode** creates database **views** — a live, read‑only projection of
    your data.
  - **Table mode** creates real **tables** and `SELECT`s the data into them; on
    later runs it updates incrementally based on the primary key and the
    "changed" field.
- **DB (destination)** — where the views or tables should live. Pointing this at
  a **separate database** is useful if you want to expose only the denormalized
  data to a BI or ETL tool and keep it away from the main Drupal database.

Then use the tabs:

- The **Create** tab builds or updates the views/tables from your
  `hook_denormalizer_info()` definitions.
- The **Export** tab shows the exact SQL that will be used — review this before
  running Create, both to understand and to sanity‑check the operation.

## Related modules

- [Views Fast Field](https://www.drupal.org/project/views_fast_field) — build
  Views without `entity_load()`.
- [Singer](https://www.drupal.org/project/singer) — export Denormalizer info as a
  Singer catalog file.
