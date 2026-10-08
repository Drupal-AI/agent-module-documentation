# Media PDF Thumbnail — configuration & admin

## Requirements

- PHP extension **imagick** (>= ImageMagick 6.3.7, enforced by `hook_requirements`).
- Composer library **spatie/pdf-to-image ^3.0** (>= 3.0.0 enforced).
- Depends on core **media**.

## Admin section

The `configure` route is the **PDF image entities** list view
`view.pdf_image_entity.list` at *Configuration → Media → Media PDF thumbnail*
(`/admin/media-pdf-thumbnail/settings/list`). Local tasks (tabs):

| Task | Route | Path | Purpose |
|---|---|---|---|
| PDF image entities | `view.pdf_image_entity.list` | `/admin/media-pdf-thumbnail/settings/list` | list all generated `pdf_image_entity` rows. |
| Settings | `media_pdf_thumbnail.settings.global` | `/admin/media-pdf-thumbnail/settings/global` | destination URIs. |
| Queue | `media_pdf_thumbnail.settings.queue` | `/admin/media-pdf-thumbnail/settings/queue` | manage the generation queue. |
| Clean | `media_pdf_thumbnail.settings.purge` | `/admin/media-pdf-thumbnail/settings/purge` | purge stored PDF-image entities/files. |

All three form routes require the `administer_media_pdf_thumbnail` permission.

## Config object: `media_pdf_thumbnail.settings`

Schema-less config, written by `MediaPdfThumbnailSettingsForm`
(`media_pdf_thumbnail.settings.global`). Keys:

| Key | Meaning | Example |
|---|---|---|
| `destination_uri_public` | where public generated images are stored (overrides "next to the source PDF"). | `public://pdf-thumbnails` |
| `destination_uri_private` | where private generated images are stored. | `private://pdf-thumbnails` |

Validation: each value, if set, must start with `public://` or `private://`. By default (both
empty) images are generated **next to the source PDF file**.

```bash
drush config:get media_pdf_thumbnail.settings
drush config:set media_pdf_thumbnail.settings destination_uri_public 'public://pdf-thumbnails' -y
drush config:set media_pdf_thumbnail.settings destination_uri_private 'private://pdf-thumbnails' -y
```

## The `pdf_image_entity` content entity

A generated image is cached as a `pdf_image_entity` (fields incl. `image_file_id`,
`image_file_uri`, `image_format`, source PDF reference, page). The formatter/token looks one up
before regenerating, so each (PDF, page, format) is rendered once. Deleting a `pdf_image_entity`
also deletes its generated file (`hook_entity_delete`). The original media thumbnail value is
never changed — it is only replaced on display.

## Permissions (`media_pdf_thumbnail.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer_media_pdf_thumbnail` | the Settings/Queue/Purge forms. |
| `administer pdf image entity entities` | admin of the generated entities. |
| `add` / `edit` / `delete pdf image entity entities` | CRUD on `pdf_image_entity`. |
| `view published` / `view unpublished pdf image entity entities` | viewing the entities. |
| `view private pdf thumbnails` | lets generated thumbnails be viewed when the source is a **private** file (checked in `hook_file_download`). Granted to the authenticated role by update 8005. |

## Generation modes

- **Inline** (default): the formatter/manager generates the image when the field renders.
- **Cron queue**: enable "Use cron" on the formatter → items are pushed to the
  `PdfImageEntityGenerateQueue` queue worker and generated on cron. Clear caches after config
  changes to rebuild renders.
