# Configure media downloads

There is **no global settings form** (`info.yml` has no `configure` key). You wire up
downloads through the route, the field formatter, the Views field, and/or Linkit.

## The download route

`media_entity_download.routing.yml` defines one route:

| Route | Path | Controller |
|---|---|---|
| `media_entity_download.download` | `/media/{media}/download` | `DownloadController::download` |

Access: `_entity_access: media.view` **and** `_permission: 'download media'`.

`DownloadController::download(MediaInterface $media)`:

- Reads the media source's configured `source_field` (`$media->getSource()->getConfiguration()['source_field']`); throws if none is configured for the bundle.
- Loads the referenced `file` entity. For multi-value fields, pass `?delta=N` to pick a specific item; otherwise the first (`target_id`) is used. Missing delta / missing file / file absent on disk → `NotFoundHttpException` (404).
- Invokes `hook_file_download($uri)`; a `-1` result → `AccessDeniedHttpException` (403). Returned headers are applied to the response.
- Returns a `BinaryFileResponse`. Content-Disposition defaults to **`attachment`** (forced "Save as…"); if the request has the `inline` query flag it uses **`inline`** instead. For non-private schemes the response is left cacheable; private-scheme responses are not.

Build a URL in code with `Url::fromRoute('media_entity_download.download', ['media' => $media_id])`.
Add `?inline` (query key `inline`) for browser-default handling, or `?delta=N` for a specific file.

## The "Download link" field formatter

Plugin id `media_entity_download_download_link` (`DownloadLinkFieldFormatter`, extends core
`LinkFormatter`). Applicable to `file` and `image` fields, and only on **media** entities
(`isApplicable()` checks target entity type is `media`).

Set it on the Manage display of a media type's file/image field (UI, or `drush cget
core.entity_view_display.media.<bundle>.<view_mode>`). It renders each file as a link to
`media_entity_download.download` for the parent media, adding MIME icon classes, filename
title, and the disposition query flag; for multi-value fields deltas > 0 get `?delta=N`.

### Setting: `disposition`

The one added setting (config schema
`field.formatter.settings.media_entity_download_download_link`, extends
`field.formatter.settings.link`). Radio labelled **"Download behavior"**:

| Value | UI label | Effect |
|---|---|---|
| `attachment` (default) | Force "Save as…" dialog | Adds `?attachment`, forcing download |
| `inline` | Browser default | Adds `?inline`; `target`/`rel` link attributes apply |

Since it is a formatter setting, it exports with the view display config
(`drush config:export`). Config schema is provided (`config/schema/media_entity_download.schema.yml`).

## Views field

`hook_views_data()` (in `media_entity_download.views.inc`) adds a `media`-table field
**`media_download_link`** ("Link to download media file"), handler `DownloadLink` (extends
`EntityLink`), default label "Download". It links to the same route by media id.

## Linkit substitutions (optional; requires the Linkit module)

Two `@Substitution` plugins generate the download URL for rich-text / Linkit link fields:

| Plugin id | Behavior |
|---|---|
| `media_download` | Direct download URL forcing a "Save as…" dialog (attachment) |
| `media_download_inline` | Inline URL (browser default) |

`composer.json` conflicts with `drupal/linkit < 6.0.1`.
