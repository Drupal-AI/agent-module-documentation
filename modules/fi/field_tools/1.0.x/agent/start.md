# Field Tools — agent index

UI + service layer over core Field UI for **cloning fields and displays between bundles**,
exporting field config, and reporting on fields/references. Depends on `field_ui`. No configure
route (`configure: null`); no config schema of its own; no Drush; no plugin types.

- **Reports, per-bundle tabs, routes, permission** → [configure/ui-and-routes.md](configure/ui-and-routes.md)
- **Cloning/copy services to call from code (the cheap way to act)** → [api/services.md](api/services.md)
- **Permission that gates the reports** → `access field tools pages` (see configure doc); per-bundle
  clone/export actions require core `administer <entity_type> fields`.

Key facts:
- The clone/export tabs are added dynamically for **every** entity type that has a
  `field_ui_base_route` (route subscriber + local-task deriver), with route names like
  `field_tools.field_bulk_clone_<entity_type_id>`, `field_tools.displays_clone_<entity_type_id>`,
  `field_tools.export_to_yaml_<entity_type_id>`.
- Cloning a field also copies its form/view **display settings** to destination displays whose
  **view-mode name matches** the source.
- Reports live under `/admin/reports/fields/{tools,references,graph}`.
