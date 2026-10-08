<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reports documents a site's own content model: for every fieldable entity type it lists the bundles, their fields, types and settings, plus per-bundle instance counts, and can export the whole picture as JSON, XML or CSV.

---

Answering "what does this site's data model actually look like?" normally means clicking through Field UI bundle by bundle or writing a throwaway script. This module answers it in one place under `/admin/reports/entity`. `src/ReportGenerator.php` walks the entity type definitions and produces, per bundle, a structure table (field label, machine name, description, data type, required, translatable, target, cardinality) and a statistics table (instance counts, including per language). `src/Routing/EntityReportsRoutes.php` generates the routes dynamically — one page per fieldable entity type, plus one export route per entity type per format, plus site-wide statistics exports. Export formats are extensible: the `EntityReportsExportFormats` event lets other modules register a format, and the `entity_reports_csv` submodule is the worked example, adding CSV on top of the built-in JSON and XML. A settings form at `/admin/config/development/entity-reports` limits which entity types are reported and lets you reorder or hide report columns. Two permissions are declared, `view entity reports` (gates all report pages and exports) and `administer entity reports` (gates the settings form); all report routes are admin routes.

---

- Document a site's content model in one place.
- Export the field structure as CSV for a spreadsheet.
- Hand a data model to a new developer.
- Audit which bundles use a given field.
- Produce documentation for a client handover.
- Compare the model between two environments.
- Feed a migration plan with real field data.
- Find unused or misconfigured fields before a cleanup.
- Report on media and paragraph structures too.
- Limit reporting to selected entity types.
- Export as JSON for further processing by another tool.
- Register a custom export format via an event subscriber.
- Support an information-architecture review.
- Check field settings without opening Field UI.
- See per-bundle entity counts, broken down by language.
- Inspect entity-reference targets and cardinality at a glance.
- Provide evidence for a data or compliance audit.
- Track model growth over time by diffing exports.
- Share the structure with a non-Drupal team.
- Reorder or hide report columns to match a reporting template.
