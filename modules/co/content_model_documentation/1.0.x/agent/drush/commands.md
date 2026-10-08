# Drush commands

Class `Drush\Commands\ContentModelDocumentationCommands` (registered via
`extra.drush.services` in composer.json; requires `drush/drush >= 9.0`). Two commands move
`cm_document` entities between the database and YAML files so documentation can travel with
code (git). Files live in `<export_location>/cm_documents/` where `export_location` is the
module machine name set on the settings form (see configure doc).

| Command | Alias | Argument | Behaviour |
| --- | --- | --- | --- |
| `content-model-documentation:export` | `cm-doc-export` | `id` (cm_document id) | Serialises the cm_document to a YAML file in the export module's `cm_documents/` dir. Requires `export_location` set and the dir writable, else throws. |
| `content-model-documentation:import` | `cm-doc-import` | `alias` (the/path/of/the/document) | Reads the matching YAML file and creates/updates the cm_document at that alias. |

Both delegate to the static movers `CmDocumentMover\CmDocumentExport::export()` /
`CmDocumentImport::import()` (see api doc). Import is keyed on the cm_document's **path alias**
(minus the domain); export is keyed on the entity **id** (visible via the edit tab). Export
guards with `CmDocumentExport::canExport()` (storage path must exist); import guards with
`CmDocumentImport::canImport()` (storage dir must exist). Exceptions are caught and returned as
a message string, not thrown to the CLI.

```bash
# 1. Set the housing module once, then export document 123.
drush cset content_model_documentation.settings export_location my_local_module -y
drush content-model-documentation:export 123      # writes my_local_module/cm_documents/<alias>.yml

# 2. On another environment, import by the exported page's alias.
drush content-model-documentation:import /admin/structure/types/manage/article/document
```

Import updates only if the incoming `changed` timestamp is newer than the existing document's;
older imports are skipped with a warning. For import during deployment prefer a `hook_update_N`
call to `CmDocumentImport::import()` (see api doc).
