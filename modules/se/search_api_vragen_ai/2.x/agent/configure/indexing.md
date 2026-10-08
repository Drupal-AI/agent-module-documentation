# Configure the index (what gets sent to Vragen.ai)

Create an Index (`/admin/config/search/search-api/add-index`) on a `vragen_ai` server. Datasources are
typically **Content** and/or **Media** (Media is how PDFs get indexed). Add the fields you want, then
choose which are semantic *content* vs *metadata* and which carry file *attachments*. Indexing logic
lives in `VragenAiBackend::indexItem()`.

## How an item becomes a Vragen.ai document

- **External reference** = the Search API item id with its trailing `:langcode` stripped
  (`stripItemId()` → `preg_replace('/:[^:]*$/', '', $id)`), optionally multisite-prefixed. This is the
  document's stable id in Vragen.ai. `firstOrCreateDocument()` looks it up by
  `filter[external_reference]` before create/update.
- **mime_type** defaults to `text/html`.
- **content** (only written on the canonical-language run or for a new document): built by
  `getIndexContentForItem()` — concatenates selected field values, wraps non-block values in `<p>…</p>`,
  and returns `<!doctype html><html><body>…</body></html>`. Rendering fields to HTML is recommended so
  the backend can read semantics. This HTML is **sent to Vragen.ai**, not rendered in Drupal.
- **meta_data**: `author` (entity owner display name), `entity_type`, `bundle`, `date`
  (`created` as `Y-m-d`), `languages` (all translation langcodes), `canonical_language`, plus every
  non-attachment field's value via `getMetadataForItem()` (single value or array).
- **attachments**: absolute URLs of `vragen_ai_attachment` fields (see below).
- After the document is filled, `PostCreateIndexDocumentEvent` is dispatched so subscribers can alter
  or veto it (see [../events/events.md](../events/events.md)). If `shouldIndex()` is FALSE an existing
  document is deleted instead of written.

`indexItems()` catches per-item `Throwable`s and logs them (`getLogger()->error`), returning only the
ids that succeeded so Search API can retry the rest.

## Semantic content processor — `vragen_ai_semantic_content`

Optional. On the index's **Processors** tab, enable "Vragen.ai semantic content" to pick *exactly*
which fields become the document `content`; unselected fields still go out as metadata. Without this
processor the backend falls back to sending all supported fields as content
(`getSemanticContentFieldIds()` returns NULL → legacy behavior).

- Supported field types for content: `text`, `string`, `integer` (`SUPPORTED_PLAIN_FIELD_TYPES`) and
  `boolean` (rendered `Label: true|false`). Config: `fields` (sequence of field ids), schema
  `plugin.plugin_configuration.search_api_processor.vragen_ai_semantic_content`.
- Validation requires at least one field selected; `preIndexSave()` follows field renames and drops
  hidden/unsupported fields. Only applies to indexes on a `vragen_ai` server (`supportsIndex()`).

## Attachments: data type + processor

To index binary files (PDFs) alongside content, set a file/media reference field's Search API type to
**Vragen.ai attachment** (`vragen_ai_attachment`, `VragenAiAttachmentType`, falls back to `string`).

- Processor **`vragen_ai_attachment_files`** (`VragenAiAttachmentFiles`) auto-populates
  `vragen_ai_attachment` fields: it walks the source entity (and referenced/nested entities, with
  cycle protection) collecting `File` entities from `file`/`entity_reference`/
  `entity_reference_revisions` fields, and emits `{url, filename}` objects using
  `file_url_generator->generateAbsoluteString()`. URLs are validated with `FILTER_VALIDATE_URL` and
  de-duplicated. Enable it on the Processors tab.
- The backend's `getAttachmentsForItem()` reads those fields and `buildAttachmentObject()` rejects any
  value that is not a valid absolute URL. Attachment URLs are sent to Vragen.ai as strings for the
  service to fetch/extract — Drupal does not download them.

## PDF media handling (event subscriber)

`IndexEventsSubscriber` (service `search_api_vragen_ai.index_events_subscriber`) subscribes to
`PostCreateIndexDocumentEvent`. For **Media** items it only indexes media whose source field is a
`file` and whose file mime type is `application/pdf`; anything else is vetoed with
`shouldIndex(FALSE)`. For a PDF it overwrites the document with `content = NULL`,
`url = file->createFileUrl(FALSE)`, `mime_type = application/pdf` so Vragen.ai extracts the PDF itself.

## Metadata-only fields

Any indexed field that is not selected as semantic content and is not an attachment is still sent under
`meta_data`. Per the README this is intended for display-only data (author, publication date). Legacy
`vragen_ai_metadata` typed fields are downgraded to `string` by `update_8005`.

## Delete & translation behavior

`deleteItems()` is translation-aware: deleting the canonical-language item deletes the whole Vragen.ai
document; deleting a non-canonical translation instead removes that langcode from the document's
`meta_data.languages` and updates it. `deleteAllIndexItems()` is a no-op ("Not supported"), so a full
clear/reindex does not purge remote documents by itself.

## Views query tuning

The `search_api_vragen_ai_display_extender` adds a **Vragen.ai → Query settings** section to Search API
Views displays exposing per-display `alpha`, `max_distance`, `distance` (each set as a query option and
overriding the server defaults at query time). See [../plugins/plugins.md](../plugins/plugins.md).
