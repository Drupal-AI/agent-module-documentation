# cm_document entity & import/export API

## The cm_document entity

`Entity\CMDocument` — a revisionable, publishable **content entity** (extends
`EditorialContentEntityBase`), one instance per documented model element.

- id `cm_document`; base table `cm_document`; `admin_permission` =
  `administer content model document entities`; `show_revision_ui = TRUE`; not translatable.
- Handlers: form `CMDocumentForm`, list `CMDocumentListBuilder`, view builder
  `CmDocumentViewBuilder`, access `CMDocumentAccessControlHandler`, route provider
  `CMDocumentHtmlRouteProvider`, views data `CMDocumentViewsData`.
- Canonical/edit/collection routes live under `/admin/structure/cm_document`; the settings form
  is the `field_ui_base_route`, so extra fields are added there via Field UI.

Base fields:

| Field | Type | Notes |
| --- | --- | --- |
| `name` | string(300) | Document title (`label`). |
| `documented_entity` | list_string (required) | What the doc is about; allowed values from `DocumentableEntityProvider::getUnDocumentedEntities`. Encoded `type.bundle[.field]` (modules/views use their own shape). |
| `notes` | text_long | Freeform rationale. |
| `status` | boolean | Published. |
| `user_id` | entity_reference→user | Author. |
| `created` / `changed` | timestamps | |

Validation constraints (custom): `DocumentNameRequiredConstraint` (name must be set) and
`OneDocumentPerEntityConstraint` (at most one document per documented entity).

Behaviour: on save the entity manages its own **path alias** (pattern from
`getAliasPattern()`, e.g. `/document/node/article`); on delete it removes those aliases.
`getStorageMap()` maps documentable entity types to their bundle config entity type
(`node`→`node_type`, `taxonomy_term`→`taxonomy_vocabulary`, etc.). Deleting a bundle/entity
triggers `hook_entity_delete` which calls
`content_model_documentation.cm_document_manager`→`deleteRelatedDocuments()` to clean up the
orphaned document.

## Static movers (usable from hook_update_N)

`CmDocumentMover\CmDocumentExport` and `CmDocumentImport` are static so they run from Drush and
from update hooks alike. Both throw/log via the `cm_document` logger channel.

```php
// Export one document by id -> writes <export_location>/cm_documents/<alias>.yml
use Drupal\content_model_documentation\CmDocumentMover\CmDocumentExport;
CmDocumentExport::export($id);

// Import during deployment. $strict = fail the update if any import is rejected.
use Drupal\content_model_documentation\CmDocumentMover\CmDocumentImport;
function mymodule_update_9017() {
  $paths = [
    '/admin/structure/types/manage/promo_banner/document',
    '/admin/structure/types/manage/full_width_banner_alert/document',
  ];
  return CmDocumentImport::import($paths, TRUE);
}
```

`import()` matches each path to an existing cm_document via its alias: existing → updated (only
if the incoming `changed` is newer, else skipped), missing → created, alias-in-use-by-non-cm
→ exception. Returns a text summary. Requires `export_location` set and the module's
`cm_documents/` dir present (`canImport()`).

## Services (public)

| Service id | Class | Purpose |
| --- | --- | --- |
| `content_model_documentation.cm_document_manager` | `CMDocumentManager` | Storage map + `deleteRelatedDocuments()`. |
| `content_model_documentation.related_entities` | `RelatedEntities` | Computes entity reference relations for ER diagrams. |
| `content_model_documentation.fields_report` | `FieldsReportManager` | Field definitions/lookup for the field reports. |
| `content_model_documentation.documentable.entity.provider` | `DocumentableEntityProvider` | Builds the `documented_entity` option list. |
| `content_model_documentation.documentable.modules` | `DocumentableModules` | Documentable module list. |
| `content_model_documentation.documentation_renderer` | `CMDocumentRenderer` | Renders document output in admin context. |
