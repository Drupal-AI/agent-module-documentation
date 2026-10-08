# Permissions

One permission (`migrate_tools.permissions.yml`), and it is `restrict access: TRUE` in
effect — grant only to trusted migration builders/administrators.

- **`administer migrations`** — Create, edit, and manage migration processes. Gates the
  entire admin UI (groups list, migration overview/source/process/destination, execute,
  messages, edit, delete) and is set as the `admin_permission` on core's `migration` and
  `migration_group` config entities by `migrate_tools_entity_type_build()`.

Drush commands are governed by CLI access (bootstrap), not this permission.
