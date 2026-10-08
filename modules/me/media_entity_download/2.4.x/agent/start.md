# media_entity_download — agent start

Adds a permanent route `media_entity_download.download` (`/media/{media}/download`) that
streams a media entity's referenced file, forcing a download via
`Content-Disposition: attachment` (pass `?inline` for browser-default handling). Ships a
matching field formatter, a Views field, and Linkit substitutions. Depends only on core
`media`. No global config UI (`configure` is null); settings live on the field formatter.

- The download route/link, the formatter, disposition (attachment vs inline), the source-field
  setting, Views + Linkit integration → [configure/media_entity_download.md](configure/media_entity_download.md)
- The `download media` permission and access checks → [permissions/media_entity_download.md](permissions/media_entity_download.md)
