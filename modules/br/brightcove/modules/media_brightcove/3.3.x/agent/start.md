# Media Brightcove — agent index

Submodule of `brightcove`. Adds a core Media source plugin so Brightcove videos become reusable
Media entities. Depends on `media` + `brightcove`. No config page, permissions, Drush, or config
schema of its own.

- **The media source plugin, its source-field type, metadata attributes, and setup** → [configure/media-source.md](configure/media-source.md)

Key facts:
- Media source plugin id `brightcove_video` (`@MediaSource`), `allowed_field_types = {entity_reference}` — the source field references a `brightcove_video` entity.
- `getMetadataAttributes()` maps name/player/video_id/duration/description/poster/thumbnail/tags/geo/schedule/economics/… ; `getMetadata('thumbnail_uri')` uses the referenced video's thumbnail.
- Validation: `BrightcoveVideoConstraint` (+ validator) ensures the source field references a valid Brightcove video.
