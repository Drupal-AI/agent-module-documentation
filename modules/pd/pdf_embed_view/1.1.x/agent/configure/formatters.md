<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Displaying PDFs (formatters + Views field)

No global settings page (`configure: null`). You wire up one of three display plugins on a
display and pick a **display mode**. All three emit the same `#theme => 'pdf_embed_view'`
render element and attach the `pdf_embed_view/viewer` library.

## The one shared setting: `display_mode`

Every plugin exposes a single select, default `'inline'`:

| Value | Rendered markup |
|---|---|
| `inline` | lazy-loaded `<iframe src="{file_url}">` embedded on the page |
| `modal` | a "View PDF" link (`data-pdf-open="{modal_id}"`) that opens the iframe in a `core/drupal.dialog` modal (90% viewport) |
| `new_tab` | a plain `target="_blank" rel="noopener noreferrer"` "Open PDF in new tab" link |

`file_url` is always the absolute string from `file_url_generator->generateAbsoluteString($file->getFileUri())`.

## 1. File field formatter — `pdf_embed_view_formatter`

- Class `PdfEmbedFormatter`, label **"PDF Embed Viewer"**, `field_types = {file}`.
- Set it on any **File** field under *Manage display* (or `drush` / config: formatter
  `type: pdf_embed_view_formatter`, `settings: { display_mode: inline|modal|new_tab }`).
- Checks `$file->access('view')` per item. **Does not** check MIME type — it will iframe any
  file the field holds, so only point it at PDF fields.

## 2. Media reference formatter — `pdf_embed_view_media_formatter`

- Class `PdfEmbedMediaFormatter`, label **"PDF Embed Viewer (Media)"**, `field_types = {entity_reference}`.
- `isApplicable()` returns TRUE only when the reference's `target_type === 'media'`; it will
  not appear on non-media entity_reference fields.
- Resolves the media type's **source field**, loads the referenced `File`, and skips the item
  unless the file exists, passes `access('view')`, **and** `getMimeType() === 'application/pdf'`.
- Use for an *Entity reference → Media* field pointing at a Document-style media type.

## 3. Views field — `pdf_embed_view_field`

- `@ViewsField("pdf_embed_view_field")` (class `PdfEmbedViewField`, in
  `src/Plugin/views/field/PdfEmbedView.php`).
- Adds the same `display_mode` select via `buildOptionsForm` (option default `inline`).
- `render()` takes the row entity, reads `$this->field`, grabs `$items->entity` (the file),
  and themes it. Note: it does **not** re-check `access('view')` or MIME type, and reads the
  first referenced entity only.

## Behavior notes (so you don't read src/)

- Multiple embeds per page get unique ids: `pdf-modal-{fid}-{delta}` (file),
  `pdf-media-modal-{mid}-{delta}` (media), `pdf-modal-view-{fid}-{viewId}` (Views).
- `settingsSummary()` shows `Display mode: {Mode}`.
- The attached JS (`js/pdf_embed_view.js`) binds the modal on `[data-pdf-open]` and also has
  responsive/hide-on-mobile logic keyed to a `.pdf-embed-wrapper` element — the shipped Twig
  template emits `.pdf-embed-view`, not `.pdf-embed-wrapper`, so that responsive branch is
  inert; the modal, inline, and new-tab modes work.
