<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Synchronizer — agent index

Exports content entities to a portable `tar.gz` and imports them into another Drupal site.
Two content entity types (**Export entity**, **Import entity**), a central manager service, two
plugin types (entity/type processors), bulk actions, a dashboard and Drush commands. Depends on
core `file` + the `cocur/slugify` library. No `configure` route; the UI is the dashboard at
`/admin/content_synchronizer`.

- **Dashboard, Export/Import entities, publish & update strategies, doing it in the UI** →
  [configure/entities.md](configure/entities.md)
- **Drush commands (export, import, clean temp files) with aliases & options** →
  [drush/commands.md](drush/commands.md)
- **The `content_synchronizer.manager` service + other services and their methods** →
  [api/services.md](api/services.md)
- **The `entity_processor` and `type_processor` plugin types — how to add one** →
  [plugins/processors.md](plugins/processors.md)
- **Import/Export entity permissions** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: manager service id `content_synchronizer.manager`
(`ContentSynchronizerManagerInterface`). Publish strategies `publication_publish` (default),
`publication_unpublish`, `publication_revision`; update strategies `update_if_recent` (default),
`update_systematic`, `update_no_update` (constants on `Processors\ImportProcessor`). Entity types
`export_entity` (base table `export_entity`, links under `/admin/structure/export_entity`) and
`import_entity` (`/admin/structure/import_entity`). Plugin managers
`plugin.manager.content_synchronizer.entity_processor` and `…type_processor`.
