# Flipbook entity & settings

## The `flipbook` content entity

Defined in `src/Entity/Flipbook.php` (`@ContentEntityType id = "flipbook"`, base table `flipbook`,
`admin_permission = "administer flipbook entity"`, `fieldable = TRUE`, Views data via
`EntityViewsData`). Base fields:

| Field | Type | Required | Notes |
|---|---|---|---|
| `id` / `uuid` | integer / uuid | — | Read-only keys. |
| `name` | string(255) | yes | Entity label. |
| `flipbook_cover` | image | yes | Cover shown before opening. `file_directory: flipbook`, extensions `png jpg jpeg`. `preSave()` backfills width/height/alt/title so the NOT NULL image columns are satisfied. |
| `flipbook` | file | yes | The PDF. Upload validators: `FileExtension` = `pdf`, `FileSizeLimit` = PHP `Environment::getUploadMaxSize()`. |
| `user_id` | entity_reference (user) | — | Author; defaults to current user. |
| `langcode` | language | — | Per-entity language. |
| `created` / `changed` | created / changed | — | Timestamps. |

Forms: `add`/`edit` = `FlipbookForm` (adds a language select), `delete` = `FlipbookDeleteForm`.
Access handler = `FlipbookAccessControlHandler` (see permissions doc).

### Routes (`flipbook.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `entity.flipbook.collection` | `/admin/structure/flipbook/list` | perm `administer flipbook entity` |
| `flipbook.add` | `/admin/structure/flipbook/add` | `_entity_create_access: flipbook` |
| `entity.flipbook.edit_form` | `/admin/structure/flipbook/{flipbook}/edit` | `_entity_access: flipbook.edit` |
| `entity.flipbook.delete_form` | `/admin/structure/contact/{flipbook}/delete` | `_entity_access: flipbook.delete` |
| `entity.flipbook.canonical` | `/flipbook/{flipbook}` | `_entity_access: flipbook.view` |
| `flipbook.settings` | `/admin/structure/flipbook_settings` | perm `administer flipbook entity` |
| `flipbook.chooseform` | `/admin/config/choosepdfstyle` | perm `administer flipbook entity` |

Note the delete path is under `/admin/structure/contact/...` and the entity `delete-form` link is
`/contact/{flipbook}/delete` — leftover paths copied from an example "contact" entity, but they
resolve correctly. `flipbook.settings` (`FlipbookSettingsForm`) is just an informational
`field_ui_base_route` page ("Manage field settings here") with no stored settings.

## Create a flipbook

UI: *Structure → Flipbook Listing → Add flipbook*, enter a name, upload a cover image and a PDF.

```php
// drush php:eval — create a flipbook programmatically (file ids must already exist).
\Drupal::entityTypeManager()->getStorage('flipbook')->create([
  'name' => 'Spring Catalog',
  'flipbook_cover' => ['target_id' => $coverFid],
  'flipbook' => ['target_id' => $pdfFid],
])->save();
```

## The one settings toggle (`flipbook.chooseform`)

`ChoosePdfStyleForm` (a `ConfigFormBase`) at `/admin/config/choosepdfstyle` edits config object
`config.flipbook_chooseconfig`, key **`pdf.choice`** (radios, schema `flipbook.schema.yml`):

| `pdf.choice` | Meaning | Library attached |
|---|---|---|
| `1` (Yes) | Popup PDF viewer | `flipbook/flipbook` (uses `css/style.css`) |
| `0` (No, default) | Inline viewer | `flipbook/flipbook_nopopup` (uses `css/style1.css`) |

```bash
ddev drush config:set config.flipbook_chooseconfig pdf.choice 1 -y   # enable popup mode
```

The preprocess reads `pdf.choice`; `1` → popup library, anything else → inline library. This is a
**site-wide** switch, not per-entity.
