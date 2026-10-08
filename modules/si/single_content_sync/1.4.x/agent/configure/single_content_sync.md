# single_content_sync — configure

## Per-entity Export UI

`hook_entity_type_build` adds a `single-content:export` link template to fieldable entity types
that are enabled (default: node, media, taxonomy_term, block_content, menu_link_content). This
produces:
- An **Export** entity operation / local task on each entity (e.g. `/node/{node}/export`,
  `/media/{media}/export`), served by `ContentExportForm` (routes are generated dynamically by
  `\Drupal\single_content_sync\Routing\ContentExportRoutes`).
- The form shows the entity serialized as YAML (editable preview), an **Include all translations?**
  checkbox (ajax-refreshes the preview), and two submit buttons:
  - **Download as a file** → streams a `.yml` (YAML only, no assets).
  - **Download as a zip with all assets** → streams a `.zip` bundling referenced files/images.

## Import UI

Route `single_content_sync.import` at `/admin/content/import` (`ContentImportForm`) — paste YAML or
upload a `.yml` / `.zip`. Appears as an **Import** action on the content overview and as a menu link.

## Settings form

Route `single_content_sync.config_settings` at `/admin/config/content/single-content-sync`
(`ContentSyncConfigForm`), permission `administer single content sync`. Config object:
`single_content_sync.settings`. Keys (defaults from `config/install`):

| Key | Default | Meaning |
|---|---|---|
| `allowed_entity_types` | node, media, taxonomy_term, block_content, menu_link_content (all bundles) | Map of entity type → allowed bundles (empty array = all bundles). Only listed types get the Export tab and are exportable. |
| `site_uuid_check` | `true` | If on, refuses to import content whose source site UUID differs from this site's. |
| `embedded_entities_export_mode` | `stub` | How entities embedded in formatted-text / link fields are exported: `none`, `stub` (base fields, matched by UUID on import), or `full`. |
| `menu_link_export_mode` | `stub` | Same choices for a content's menu link. |
| `import_directory_schema` | `temporary` | Stream wrapper used for the import working directory. |
| `export_directory_schema` | `temporary` | Stream wrapper used for the export working directory. |

Saving the form runs `drupal_flush_all_caches()` (allowed-types changes affect operation forms).

Drush equivalents, e.g.:
```
drush cset single_content_sync.settings site_uuid_check 0
drush cset single_content_sync.settings embedded_entities_export_mode full
```

## Bulk export UI

Route `single_content_sync.bulk_export` at `/admin/config/content/single-content-sync/export`
(`ContentBulkExportForm`), plus a `content_bulk_export` system action (VBO-style) with `assets` /
`translation` options, exposed on entity collection routes (see the plugins doc / `BulkExportRoutesEvent`).
