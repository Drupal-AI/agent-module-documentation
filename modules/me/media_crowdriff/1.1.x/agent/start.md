# Media Crowdriff — agent index

Adds a core-Media **media source** (`media_crowdriff`) for embedding [Crowdriff](https://crowdriff.com/)
galleries, plus a Media Library add form, a validation constraint, and a display formatter.
**No settings form, no `configure` route (`configure: null`), no permissions, no Drush, no
config schema.** You "configure" it by creating a Media type that uses the Crowdriff source.

- **Create/inspect a Crowdriff media type, source field, embed formatter** →
  [configure/media-type.md](configure/media-type.md)
- **The four plugins (source, add form, constraint, formatter) + theme hook and how they fit** →
  [plugins/architecture.md](plugins/architecture.md)

Key facts:
- Media source plugin id `media_crowdriff`, `allowed_field_types = {"string_long"}`; the auto
  source field is `field_media_media_crowdriff`.
- Valid embed codes must match `/(cr-init__|cr__init-)[a-z0-9]{8,}/` (constraint `media_crowdriff`).
- Formatter id `media_crowdriff` (for `string_long`), settings `width` (`100%`) / `height` (`900px`).
- Renders `media_crowdriff` theme hook → async `<script src="https://starling.crowdriff.com/js/crowdriff.js">`.
