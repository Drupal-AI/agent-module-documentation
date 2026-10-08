<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters, Views link fields, media operations & templates

These are the display-layer surfaces that let a site actually open documents in Collabora. All of
them route to `ViewerController` / `ModalController` (see [../api/wopi.md](../api/wopi.md)); none
bypass the `preview in collabora` / `edit in collabora` access checks.

## Field formatters

For a **single-value** `file` field on a **media** entity (`isApplicable()` rejects non-media target
entity types and multi-value fields — Collabora supports one file per media). Each formatter checks
`media.access('preview in collabora')` before rendering anything and attaches the access result as
cache metadata, so an unauthorized user sees nothing.

| Formatter id | Class | Renders | Settings |
|--------------|-------|---------|----------|
| `collabora_preview` | `CoolPreview` | `collabora_online_preview` theme — filename + a "View" button that opens the preview in a JS dialog (`cool.previewer` library). | none |
| `collabora_preview_embed` | `CollaboraPreviewEmbed` (extends `CollaboraFileFormatterBase`) | An inline `<iframe class="cool-iframe">` pointing at `/cool/view/{media}` (`iframe` library). | `aspect_ratio` string `"w / h"` (regex-validated, default `3 / 2`). |
| `collabora_preview_modal` | `CollaboraPreviewModal` (extends base) | A "Preview" AJAX dialog link (`use-ajax`, `data-dialog-type: modal`) to `/cool/modal/{media}` (`modal_preview` + `core/drupal.dialog.ajax`). | `max_width` int px (30–3000, default 880). |

`CollaboraFileFormatterBase::viewElements()` holds the shared access check + single-item iteration;
subclasses implement `viewElement(MediaInterface $media, FileInterface $file)`. Formatter settings
schema: `field.formatter.settings.collabora_preview_embed` / `…_modal` in
`config/schema/collabora_online.schema.yml`.

Configure at a media type's *Manage display* (`/admin/structure/media/manage/{type}/display`) by
choosing one of these formats for the source file field.

## Views link fields

Two `LinkBase` view fields (both extend core's link field, so they inherit the standard link/text
settings — schema `views.field.media_collabora_preview` / `…_edit`):

| Views field id | Class | Links to | Default label |
|----------------|-------|----------|---------------|
| `media_collabora_preview` | `CollaboraPreview` | `CollaboraUrl::previewMedia()` → `/cool/view/{media}` | "View in Collabora Online" |
| `media_collabora_edit` | `CollaboraEdit` | `CollaboraUrl::editMedia()` → `/cool/edit/{media}` | "Edit in Collabora Online" |

Views integration is registered via `collabora_online.views.inc`. The group submodule's install hook
injects both fields into the `group_media` view dropbutton.

## Media entity operations (`hook_entity_operation`)

`collabora_online_entity_operation()` adds row operations on `media` entities whose source plugin is
`file`:
- **"View in Collabora Online"** — always added when `media.access('preview in collabora')` passes
  and a file is attached.
- **"Edit in Collabora Online"** — added only when `CoolUtils::canEditMimeType($mime)` is TRUE and
  `media.access('edit in collabora')` passes. `CoolUtils::READ_ONLY` marks the Apple iWork MIME types
  (keynote/pages/numbers) as view-only.

Both carry the current page as a `destination` query param.

## URL helper & templates

`CollaboraUrl` centralises route names: `previewMedia()`, `editMedia()`, `mediaModalPreview()`.

Templates (registered in `hook_theme`, `collabora_online.module`):
- `collabora-online-full.html.twig` — the full standalone HTML page for the editor iframe
  (preprocessed by `template_preprocess_collabora_online_full` in `collabora_online.theme.inc`, which
  injects `module_path`). Includes `collabora-online.html.twig`.
- `collabora-online.html.twig` — the hidden auto-submitting form (posts `access_token` /
  `access_token_ttl`) and the editor `<iframe>`; a script calls `loadDocument(wopiClient, wopiSrc)`
  from `js/cool.js`.
- `collabora-online-preview.html.twig` — filename + "View" button used by the `collabora_preview`
  formatter (`js/previewer.js`).

CSS/JS libraries are declared in `collabora_online.libraries.yml` (`cool`, `cool.frame`,
`cool.previewer`, `iframe`, `modal_preview`).
