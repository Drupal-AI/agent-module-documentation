Media Brightcove adds a core Media **source** plugin, "Brightcove Video", so Brightcove videos can be wrapped as reusable Media entities (usable in the Media Library, media reference fields, etc.).

---

The submodule provides one `@MediaSource` plugin (`brightcove_video`,
`src/Plugin/media/Source/BrightcoveVideo.php`) whose source field is an `entity_reference` to a
`brightcove_video` entity. It exposes a large set of metadata attributes mapped from the referenced
Brightcove video — `name`, `api_client`, `player`, `video_id`, `duration`, `description`,
`long_description`, `poster`, `thumbnail`, `reference_id`, `state`, `tags`, `custom_fields`, geo
restriction data, schedule (`starts_at`/`ends_at`), economics, and more — and derives the media
`thumbnail_uri` from the referenced video's thumbnail (falling back to a default). A validation
constraint (`BrightcoveVideoConstraint` + validator) enforces the source field points at a valid
Brightcove video. Depends on core `media` and the main `brightcove` module. No config, permissions,
or Drush of its own.

---

- Create a "Brightcove Video" media type backed by the Brightcove Video media source.
- Reference Brightcove videos through standard Media reference fields.
- Pick Brightcove videos from the Media Library UI.
- Map Brightcove metadata (duration, description, tags) onto media fields.
- Use the Brightcove video's thumbnail as the media entity thumbnail.
- Reuse one Brightcove video as media across many nodes.
- Expose Brightcove player/video IDs as media metadata for templates.
- Surface geo-restriction and schedule metadata on the media entity.
- Validate that a media entity references a real Brightcove video.
- Integrate Brightcove into existing Media-based editorial workflows.
- Embed Brightcove videos through CKEditor's media embed button.
- Display Brightcove media with core Media view modes and formatters.
- Map Brightcove geo-restriction flags onto media fields for conditional display.
- Show a Brightcove video's schedule (starts_at/ends_at) as media metadata.
- Expose Brightcove custom fields as media metadata.
- Build a single media type that editors reuse instead of re-embedding videos.
- Reference Brightcove media from paragraphs or layout builder components.
- Keep Brightcove video metadata in sync via the parent module's queues while media just references it.
