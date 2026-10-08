# Admin UI

The UI requires `migrate_plus` (it supplies the `migration` and `migration_group` config
entities). Configure route: `entity.migration_group.list`.

- **Migration groups** list — `/admin/structure/migrate` (also linked under Structure →
  Migrations when migrate_plus is on). Add/edit/delete groups.
- **Migrations** in a group — `/admin/structure/migrate/manage/{group}/migrations`.
- **Migration overview** — `/admin/structure/migrate/manage/{group}/migrations/{migration}`
  with tabs: Overview, **Source**, **Process**, **Destination** (the plugin mappings),
  **Messages**, **Execute**, Edit, Delete.
- **Execute** tab (`migrate_tools.execute`) — run import/rollback from the browser via
  `MigrationExecuteForm`.
- **Messages** tab (`migrate_tools.messages`) — read the migration's logged messages.

`migrate_tools_entity_type_build()` injects the list builders, edit/delete forms, and
`administer migrations` admin permission onto core's migration entity types. All routes
require the `administer migrations` permission. There is no dedicated settings form — this
module configures nothing globally; the entities themselves (defined by migrate_plus) hold
the migration configuration.
