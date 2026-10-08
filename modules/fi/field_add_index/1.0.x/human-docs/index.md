# Field Add Index — manual setup guide

**Field Add Index** (`field_add_index`) solves a quiet performance problem: Drupal
custom fields do **not** get a database index on their value columns by default.
That is fine until you expose such a field as a filter or search in Views — then
every query does a full table scan, which gets slow as the table grows. This
module lets a site builder add a **database index** to a custom field's column(s)
straight from the field's edit form, so those queries can use the index instead.

It supports indexing these field types: `text`, `text_long`, `text_with_summary`,
`string`, and `string_long`. It is a performance/developer tool — it changes the
field's database schema only, and has no effect on content or access.

> **Heads‑up:** adding an index rewrites the field's database table. On large
> tables this can be resource‑intensive and lock the table for a while, so run it
> during a maintenance window.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — you add an index per field, as described in
"How to use it" below.

## How to use it

1. Go to the field listing for the bundle you want, e.g. **Structure → Content
   types → (your type) → Manage fields**
   (`/admin/structure/types/manage/your-type/fields`).
2. **Edit** the field you want to index (it must be one of the supported types:
   `text`, `text_long`, `text_with_summary`, `string`, `string_long`).
3. Tick the **Add Index** option, then **Save**.
4. Apply the schema change so the index is actually created in the database. The
   change is a field storage update, which you can run with the entity‑update
   tooling, for example:

   ```bash
   drush entity-updates
   ```

   (The `drush entity-updates` command is provided by the
   [Devel Entity Updates](https://www.drupal.org/project/devel_entity_updates)
   module on modern Drupal — install that if the command is not available.)

After the update runs, the index exists on the field's column(s). You can confirm
with an `EXPLAIN` on a query against that field — instead of scanning the whole
table, MySQL/MariaDB should now use the new index.
