# Salesforce Mapping UI — agent index

Admin UI for managing `salesforce_mapping` config entities and `salesforce_mapped_object`
records — list/add/edit/field-map/enable/disable/delete forms. No config, plugins, or Drush of
its own; it is the UI layer on `salesforce_mapping`. Depends on `salesforce_mapping`.

- **Routes & the permissions that gate them** →
  [configure/ui.md](configure/ui.md)

Key facts:
- Mappings list: `entity.salesforce_mapping.list` → `/admin/structure/salesforce/mappings`
  (permission `administer salesforce mapping`).
- Add: `.../mappings/add`; edit: `.../mappings/manage/{mapping}`; field mapping:
  `.../mappings/manage/{mapping}/fields`; enable/disable/delete forms too.
- Mapped objects: `entity.salesforce_mapped_object.list` → `/admin/content/salesforce`
  (permission `administer salesforce mapped objects`).
- Permissions come from `salesforce_mapping`: `administer salesforce mapping`,
  `view salesforce mapping`, `administer salesforce mapped objects` (top list also checks
  `administer salesforce`).
- The entity it manages is documented under `salesforce_mapping` (`configure/mapping.md`).
