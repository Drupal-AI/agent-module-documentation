# single_content_sync — permissions

Defined in `single_content_sync.permissions.yml` (plus dynamic ones from
`\Drupal\single_content_sync\ContentSyncPermissions`).

| Permission | Gates |
|---|---|
| `import single content` | The Import page (`/admin/content/import`, route `single_content_sync.import`). |
| `administer single content sync` | The settings form (`single_content_sync.config_settings`). |
| `export {entity_type} content` | Per-entity-type export. Generated dynamically for every entity type that has the `single-content:export` link template — e.g. `export node content`, `export media content`, `export taxonomy_term content`, `export block_content content`, `export menu_link_content content`. |

Notes:
- The static file also declares `export single content` / `import single content` titles; the
  effective per-type export permissions come from the `permission_callbacks` →
  `ContentSyncPermissions::permissions`.
- The per-entity Export form additionally checks entity access
  (`_entity_access: {type}.single-content:export`) via `hook_entity_access`, and the module's own
  `ContentExportForm::access` / helper access check.
- The bulk export form uses a custom access check (`ContentBulkExportForm::access`).
