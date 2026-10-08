# Reports, field search & diagrams

Two report sections plus a field browser and two diagram builders. Every route below is gated
by permission `view content model documentation` **OR** `view content model documentation
reports` (routing uses the `+` OR form). All are under `/admin/reports/...` (admin-only paths).

## Tabular reports

Route `entity.content_model_documentation.content_model_reports`
(`/admin/reports/content-model/{report_name}/{alternate_format}`) and
`entity.content_model_documentation.system_reports`
(`/admin/reports/system/{report_name}/{alternate_format}`) both dispatch to
`ReportController::display()`. It converts `report_name` (dashes to CamelCase) to a class
`\Drupal\content_model_documentation\Report\{Name}`, checks `class_exists`, then calls
`{class}::create($container)->buildPage($type, $report_name)`. Unknown name gives a 404.
Passing `alternate_format=csv` returns a `Content-Disposition: attachment` CSV `Response`
instead of the HTML table.

| report_name | Section | Report class | Shows |
| --- | --- | --- | --- |
| `node-count` | content-model | `NodeCount` | Node content types + row counts |
| `block-content-count` | content-model | `BlockContentCount` | Block content types + counts |
| `paragraph-count` | content-model | `ParagraphCount` | Paragraph types + counts |
| `vocabulary-count` | content-model | `VocabularyCount` | Vocabularies + term counts |
| `fields-count` | content-model | `FieldsCount` | Field usage across entities |
| `user-roles` | system | `UserRoles` | User counts by role |
| `enabled-modules` | system | `EnabledModules` | Enabled modules, links to project/help/docs |

The section landing pages (`entity.content_model_documentation.base` at
`/admin/reports/content-model`, `.system_base` at `/admin/reports/system`) are core
`SystemController::systemAdminMenuBlockPage` menu blocks; child links come from
`content_model_documentation.links.menu.yml`.

### Report framework (to add one)
Reports extend `Report\ReportBase` (implements `ContainerInjectionInterface`) and implement
`ReportInterface` + one of `ReportTableInterface` / `ReportDiagramInterface`. `buildPage()`
switches on type: `table`, `csv`, `htmlblob`, `diagram`. Table reports must provide
`getHeaderRow()`, `getTableBodyRows()`, `getCsvBodyRows()`, `getCaption()`;
`validateHeaderBodyParity()` throws if column counts mismatch and `validateCaption()` requires
a non-empty caption. `ReportBase::addDocumentationColumn()` appends a column linking each row
to its cm_document. Tables attach the `content_model_documentation/sortable-init` JS library.
See `src/Report/README.md`.

## Field search & details

- `content_model_documentation.fields.search` — form `SearchFieldsForm`
  (`/admin/reports/content-model/field-search`). Lists every field definition grouped by
  entity type, with faceted filters built from the field-definition values (query params filter
  the list). Uses the `content_model_documentation.fields_report` service
  (`FieldsReportManager::getFieldDefinitions()`).
- `content_model_documentation.fields.details` —
  `FieldsController::fieldDetails($entity_type, $field)`
  (`/admin/reports/content-model/field-search/{entity_type}/{field}`), opened in an off-canvas
  dialog. Dumps the field definition's `toArray()` as a key/value table plus a list of bundles
  the field is active on.

## Content Model Fields view

A `config_views` View `content_model_fields` (base table `config_field_field`) is installed at
`/admin/reports/content-model/fields` — a filterable list of every field (label, description,
entity type, bundle, cardinality, reference targets). Editable in Views UI. Extra Views field
plugins added by this module: `non_delete_operations`, `configuration_field_cardinality`,
`configuration_field_entity_reference_targets` (see hooks doc).

## Entity Relationship diagrams

`EntityDiagramController` renders Mermaid `flowchart` diagrams of entity references.

| Route | Path | Method |
| --- | --- | --- |
| `entity.content_model_documentation.diagram` | `/admin/reports/content-model/entity-diagram/{entity}/{bundle}` | `display` |
| `entity.node_type.diagram` | `/admin/reports/content-model/entity-diagram/{entity}/{node_type}` (entity defaults `node`) | `displayNodeDiagrams` |
| `entity.taxonomy_vocabulary.diagram` | `/admin/reports/content-model/entity-diagram/taxonomy_vocabulary/{taxonomy_vocabulary}` | `displayTaxonomyDiagrams` |

Depth is controlled by `?max_depth=N` (default 2). Relations come from the
`content_model_documentation.related_entities` service (`RelatedEntities::getRelations()`);
nodes with further relations become clickable links to their own diagram. An `EntityDiagramForm`
preface lets the user pick entity/bundle/depth.

## Workflow diagrams

`entity.content_model_documentation.workflow_diagram`
(`/admin/reports/system/workflow/{workflow_type}/{workflow}/{transition}`) →
`WorkflowDiagramController::display()`. Draws states and transitions of a Content Moderation /
Workflows workflow as a Mermaid flowchart (all transitions, or a before/after view for a single
transition). If the `workflows` module is not enabled it renders an "unavailable" message
instead. State shapes are chosen by reading each state's `published`/`defaultRevision` flags.
