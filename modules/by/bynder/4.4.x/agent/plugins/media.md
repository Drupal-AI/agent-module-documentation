# Bynder plugins, routes & the media pipeline

## Media source (`src/Plugin/media/Source/Bynder.php`)

`@MediaSource(id = "bynder")`, `allowed_field_types = {string, string_long}` (the source field stores the
Bynder asset ID). Key points:

- **Metadata attributes** (`getMetadataAttributes()`): `uuid` (ID), `name`, `description`, `tags`, `type`,
  `video_preview_urls`, `thumbnail_urls`, `width`, `height`, `created`, `modified`, `propertyOptions`, plus
  one attribute per Bynder **metaproperty** (fetched live). Map these to media fields on the type's Field
  mapping.
- Stores the full remote metadata JSON in the shared metadata field
  (`BynderMetadataItem::METADATA_FIELD_NAME`); `ensureMetadata()` fetches/refreshes it,
  `hasMetadataChanged()` compares local vs remote.
- On new Bynder media types, `bynder_media_type_insert()` auto-creates the metadata field and a
  `bynder_transformations` field (`TRANSFORMATIONS_FIELD_NAME`).
- `getMetadata($media,'uuid')` returns the source-field value; `bynder_media_presave()` calls
  `prepareSave()`.

## Entity Browser widgets (`src/Plugin/EntityBrowser/Widget/`)

| Widget id | Class | Purpose |
|---|---|---|
| `bynder_search` | `BynderSearch` | Search/browse existing Bynder assets and create media entities. Config: `submit_text`, `media_type`, `media_type_document`, `media_type_video`, `single_file_selection`. Query is alterable via `hook_bynder_search_query_alter()`. |
| `bynder_upload` | `BynderUpload` | Upload files to Bynder (needs OAuth + upload role + dropzonejs). Config: `submit_text`, `media_type`, `brand`, `extensions`, `dropzone_description`, `tags`, `metaproperty_options`. |

Both extend `BynderWidgetBase`. Add them to an Entity Browser and reference it from a media/media-library
field.

## Field plugins (`src/Plugin/Field/`)

| Type | id | For | Notes |
|---|---|---|---|
| FieldFormatter | `bynder` | image media source field | Renders a derivative; supports responsive sizes, alt/title fields, DAT transformations, `image_loading`. |
| FieldFormatter | `bynder_document` | document media | Optional link + title field. |
| FieldFormatter | `bynder_video` | video media | HTML5 player: `controls`, `autoplay`, `loop`, `muted`, `width`, `height`. |
| FieldFormatter | `bynder_metadata` | `bynder_metadata` field | Renders selected remote metadata. |
| FieldType | `bynder_metadata` | — | `BynderMetadataItem` stores the JSON metadata blob. |
| FieldWidget | `bynder_metadata` | `bynder_metadata` field | Edit widget for the metadata field. |

Formatter settings schema lives in `bynder.schema.yml` (`field.formatter.settings.bynder`,
`…bynder_document`, `…bynder_video`).

## Action & queue worker

- `@Action(id = "bynder_metadata")` `UpdateMetadataAction` — "Update Bynder metadata"; bulk-refresh media
  metadata (also installed as `system.action.bynder_metadata`).
- `@QueueWorker(id = "bynder_test_image_remove")` `BynderTestImageRemove` — cleanup of test images.

## Routes (`bynder.routing.yml`) & controllers

| Route | Path | Access | Controller |
|---|---|---|---|
| `bynder.configuration_form` | `/admin/config/services/bynder` | `administer bynder configuration` | `BynderConfigurationForm` |
| `bynder.oauth` | `/bynder-oauth` | custom (`BynderOAuthLogin::access`) | OAuth login/callback |
| `bynder.usage` | `/node/{node}/bynder-usage` | `view bynder media usage` | `BynderMediaUsage` — lists Bynder assets referenced by a node |
| `bynder.bynder_select2` | `/bynder/tags/search` | `_access: 'TRUE'` | `BynderTagSearchService::searchTags` — tag autocomplete proxied to the Bynder API |

## Theme / library notes

- Image display uses Bynder derivatives (`mini`/`webimage`/`thul` + custom) and the external **CompactView**
  component (`bynder/compactview`, loaded from a Bynder CDN) for responsive rendering.
- `bynder_media_url($media)` builds the "edit on Bynder" deep link; shown on the media edit form via
  `bynder_form_alter()`.
