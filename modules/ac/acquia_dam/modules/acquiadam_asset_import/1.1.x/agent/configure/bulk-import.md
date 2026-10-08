<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure bulk import

## The config object

**`acquiadam_asset_import.settings`** — two maps (install default: both empty `{}`):

| Key | Shape | Meaning |
|---|---|---|
| `categories` | `{ "<widen-category-uuid>": ["<media_type_id>", …], … }` | For each Widen **category** UUID, the local DAM media type(s) its assets import as. |
| `asset_groups` | `{ "<widen-asset-group-uuid>": ["<media_type_id>", …], … }` | Same, for Widen **asset groups**. |

The media type ids must be existing DAM-related media types on the site (e.g.
`acquia_dam_image_asset`, `acquia_dam_video_asset`); the schema validates them with
`NotBlank` + `ConfigExists`.

```bash
drush cget acquiadam_asset_import.settings
drush cget acquiadam_asset_import.settings categories
```

```php
// map a category UUID to the Image media type
\Drupal::configFactory()->getEditable('acquiadam_asset_import.settings')
  ->set('categories', ['b1c2...uuid' => ['acquia_dam_image_asset']])
  ->save();
```

## The config form

Route `acquiadam_asset_import.configuration` → `/admin/config/acquia-dam/bulk-import`
(`BulkImportConfigForm`). It appears under the parent's Acquia DAM config menu
(*Bulk import*). Access needs:

- the parent permission `administer acquia_dam`, **and**
- a DAM-authenticated site (`AuthenticationController::checkAccess`) — so the form only fully
  works once the site is connected, because it fetches the available categories/asset groups
  from the DAM to choose from.

## How import uses the mapping

1. The queue service reads `categories` / `asset_groups`, asks the DAM for the assets in each,
   and enqueues them into the `acquia_dam_asset_import` queue (optionally filtered to the
   mapped media types).
2. The `AssetImporter` QueueWorker creates one media entity per asset, of the mapped type.

Trigger it with the Drush commands — see [../drush/commands.md](../drush/commands.md).

## Migration from the contributed module

Update hooks migrate config from the old contributed `acquiadam_asset_import`: run
`drush updb -y` (site must be DAM-authenticated), which converts old category config to this
format (with subcategory support), removes the old `dam_worker` queue, and creates the
`acquia_dam_asset_import` queue.
