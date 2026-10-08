# Devel Schema Change Helper — manual setup guide

**Devel Schema Change Helper** (`devel_schema_change_helper`) is a Drush-only
developer utility that takes the pain out of renaming an existing entity field.
Drupal fixes a field's machine name at creation, so a "rename" normally means
creating a brand-new field, moving all the stored data across, and manually
re-adding the field to every form and view display. This module packages that
whole job into a single command.

Its command, `devel_schema_change_helper:rename-existing-field` (alias
`dsch-rename-field`), takes an entity type id, the old field name and the new one.
It copies the field storage config, copies each bundle's field config, replicates
the field across all view and form displays, and moves the underlying data rows to
the new field's tables. An optional flag controls whether the old field and its
data are removed afterward.

There is no web-facing surface — no routes, permissions, blocks or UI. It runs only
from a trusted shell, during migrations or refactors. Treat it like any destructive
schema operation: **back up the database first, run in a maintenance window, and
verify your displays afterward.** It supports Drupal 10 and 11 and is covered by
Drupal's security advisory policy.

> **Known limitations from the maintainers:** the module does **not** currently
> support migrating `entity_reference` fields. The rename also moves the English
> translation to the original field config (even when English is not the original
> language) and deletes existing translations, and some field config keys such as
> `third_party_settings` may still reference the old field name. Review the results
> carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no configuration page or admin UI — this module is driven entirely from
Drush, as shown below.

## How to use it

Run the rename command from a trusted shell on the environment you're changing:

```bash
# Rename node.field_old to node.field_new (keeps the old field and data)
drush dsch-rename-field node field_old field_new

# Full form, with the option to delete the old field and its data afterward
drush devel_schema_change_helper:rename-existing-field <entityTypeId> <oldFieldName> <newFieldName> [--deleteOldFieldData]
```

Arguments:

- **`entityTypeId`** — the entity type, e.g. `node`, `taxonomy_term`.
- **`oldFieldName`** / **`newFieldName`** — the field machine names.
- **`--deleteOldFieldData`** — optional boolean (default off); removes the old
  field and its data after the copy.

**Always back up the database before running**, prefer a maintenance window, and
check every affected form and view display once it completes.
