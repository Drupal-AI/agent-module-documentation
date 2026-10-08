# Permissions

Defined in `pdfa11y.permissions.yml`.

| Permission | Grants | Restricted |
|---|---|:---:|
| `administer pdf accessibility` | The settings + help form (`pdfa11y.settings` route); which checks run, blocking, size caps. | **yes** |
| `run pdf accessibility checks` | Manually trigger a re-check: shows the "Run accessibility check" button and gates the `pdfa11y.media_recheck` route. | no |
| `view pdf accessibility reports` | See per-media results: gates the `pdfa11y.media_report` route (`/media/{media}/accessibility` tab). | no |
| `view pdf accessibility help` | The guidance page `pdfa11y.help` (`/admin/config/media/pdf-accessibility/help`). | no |
| `bypass blocked pdf uploads` | Save a PDF that fails checks even when `block_failed_uploads` is on. Checks still run and results are recorded; the editor sees a warning instead of a hard block. | **yes** |

Separation: an editor granted `view pdf accessibility reports` + `run pdf accessibility checks`
can see results and re-check without the ability to weaken the ruleset (`administer …`).

The report and recheck routes additionally require core `_entity_access: media.view` and a custom
`_pdf_media_access` check (`Drupal\pdfa11y\Access\PdfMediaAccessCheck`) that returns forbidden
unless the media type's source field lists `pdf` among its `file_extensions`. `pdfa11y.media_recheck`
also requires `_csrf_token: TRUE`.
