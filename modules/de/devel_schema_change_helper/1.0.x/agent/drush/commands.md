<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: rename an existing field

```
drush devel_schema_change_helper:rename-existing-field <entityTypeId> <oldFieldName> <newFieldName> [--deleteOldFieldData]
# alias:
drush dsch-rename-field node field_old field_new
```

Positional/args:
- `entityTypeId` — e.g. `node`, `taxonomy_term`.
- `oldFieldName` / `newFieldName` — field machine names.
- `deleteOldFieldData` (bool, default FALSE) — remove the old field + data after copy.

What it does: copies `FieldStorageConfig`, per-bundle `FieldConfig`, all view/form display components, then moves the data rows to the new field's tables via a direct DB connection. Destructive — back up first and verify displays afterward.
