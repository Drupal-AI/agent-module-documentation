# Configure — per-index DCD options

No standalone settings form. To create an incremental export stream:

1. Create a Search API **server** whose backend is **Default Content Deploy**
   (`search_api_default_content_deploy`).
2. Create an **index** on that server, add the **DCD Entity** (`dcd_entity`)
   datasource(s) for the content entity types you want tracked.
3. On the index form, open **"Default Content Deploy specific index options"**
   (added by `hook_form_search_api_index_form_alter`) and fill in the settings below.

Settings are stored as index **third-party settings** under the
`search_api_default_content_deploy` namespace. The schema
(`search_api.index.*.third_party.search_api_default_content_deploy`) extends the
parent's `default_content_deploy.common_settings`, so it shares `content_directory`,
`text_dependencies`, `skip_export_timestamp`, `skip_entity_types`, `batch_ttl`.

| Setting | Type | Effect |
| --- | --- | --- |
| `content_directory` | string | Target export folder for this stream (shared common element; not required here). |
| `export_referenced_entities` | boolean | Also export referenced entities (of non-skipped types). |
| `text_dependencies` | boolean | Include entities embedded in processed-text fields. |
| `skip_export_timestamp` | boolean | Omit per-entity export timestamp metadata. |
| `skip_entity_types` | sequence | Referenced entity types to exclude. |
| `link_domain` | string | HAL link base URI (e.g. `https://my.site.dev`); rewritten into output on export. |
| `delete_single_file_allowed` | boolean | When an item is de-indexed, remove its JSON file. |
| `move_deleted_single_file` | boolean | Instead of deleting, move it to a `_deleted/` subfolder and stamp a `delete_timestamp` (so `drush dcdi --delete` can replay the deletion). |
| `delete_all_files_allowed` | boolean | Allow `deleteAllIndexItems()` to recursively delete the export folder (or a per-type subfolder). |

Defaults come from `search_api_default_content_deploy_default_index_third_party_settings()`.

## How it exports

- Indexing an item (`DefaultContentDeployBackend::indexItems()`) configures the parent
  exporter from the index settings and calls
  `default_content_deploy.exporter::exportEntity()` for each `dcd_entity` item, then
  clears any stale `_deleted/…` file for that entity.
- `hook_entity_insert/update/delete` and `hook_search_api_index_update` forward to the
  tracking manager, which marks items for (re)indexing through Search API's normal queue
  / tracker — so exports follow the index's indexing settings (immediate or cron/batch).
- The event subscriber tags each export with the triggering index id, rewrites the link
  domain when it differs from the current host, and suppresses rewriting a file whose
  only change is the export timestamp.

The `search()` backend method is intentionally empty — this backend never serves
queries; it only writes export files.
