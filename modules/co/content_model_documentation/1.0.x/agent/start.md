<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Model Documentation (content_model_documentation) — agent index

Surfaces a site's content model and architecture as admin reports and Mermaid diagrams,
plus a `cm_document` content entity for authored rationale (why a bundle/field/module
exists). Reports live under `/admin/reports/content-model` and `/admin/reports/system`;
documents under `/admin/structure/cm_document`. Core `^10 || ^11`.

Dependencies (all required, four contrib): `better_exposed_filters`, `config_views`,
`mermaid_diagram_field`, `views_data_export`, plus core `views` and `path_alias`.
`config_views` exposes configuration entities (bundles, fields) to Views so the model can be
listed; `mermaid_diagram_field` renders the diagrams. Settings route:
`entity.cm_document.config_form` (`/admin/config/system/cm_document`).

Provides: 9 permissions, 2 Drush commands, config schema (see caveat in configure doc), no
plugin types of its own (adds three Views field plugins + two Validation constraints).

- **Change which entity types are documentable / set export module** → [configure/settings.md](configure/settings.md)
- **Understand the report pages, CSV export, field search, ER & workflow diagrams** → [reports/routes.md](reports/routes.md)
- **Export/import cm_document entities as YAML (ride docs with code)** → [drush/commands.md](drush/commands.md)
- **cm_document entity, its fields, and the static import/export API for hook_update_N** → [api/documents.md](api/documents.md)
- **Grant access to reports/documents** → [permissions/permissions.md](permissions/permissions.md)
- **Hooks it implements that matter to integrators** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object: `content_model_documentation.settings`. Keys: `block`, `field`, `media`,
  `menu`, `modules`, `node`, `paragraph`, `taxonomy`, `view` (booleans), `export_location` (string).
- Report controller: `ReportController::display` at
  `/admin/reports/{content-model|system}/{report_name}/{alternate_format}`; `report_name`
  dashed→CamelCase maps to a class in `\Drupal\content_model_documentation\Report\*`;
  `alternate_format=csv` downloads a CSV.
- Services: `content_model_documentation.cm_document_manager`,
  `content_model_documentation.related_entities`, `content_model_documentation.fields_report`,
  `content_model_documentation.documentable.entity.provider`,
  `content_model_documentation.documentable.modules`,
  `content_model_documentation.documentation_renderer`.
- Views (config_views): `content_model_documents` (base `cm_document`, at
  `admin/structure/cm_document`), `content_model_fields` (base `config_field_field`, at
  `admin/reports/content-model/fields`).
- Drush: `content-model-documentation:export` (alias `cm-doc-export`),
  `content-model-documentation:import` (alias `cm-doc-import`).
- Permission gate on every report/diagram route: `view content model documentation` OR
  `view content model documentation reports`; settings route needs
  `administer content model documentation`.
- composer.json declares `conflict: drush/drush <9.0`.
