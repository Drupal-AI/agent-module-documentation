<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Devel Schema Change Helper (devel_schema_change_helper) — agent index

**Drush-only helper for entity field schema changes (rename an existing field, migrating data/config/displays).**

- **Version:** 1.0.x (1.0.0-alpha2)
- **Core:** ^10 || ^11
- **Package:** Development
- **No routes / permissions / UI** — CLI only.
- **Drush command:** `devel_schema_change_helper:rename-existing-field` (alias `dsch-rename-field`) — args: `entityTypeId`, `oldFieldName`, `newFieldName`, optional `deleteOldFieldData` bool.
- **Uses:** `EntityDefinitionUpdateManager`, `entity_type.manager`, database `Connection` (direct data-table copy).

**Security:** No web-facing surface; runs only from a trusted shell. The command performs destructive schema/data changes — back up the database and run in a maintenance window. No security-sensitive request handling.

See [drush/commands.md](drush/commands.md)