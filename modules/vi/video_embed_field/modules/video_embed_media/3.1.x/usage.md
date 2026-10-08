Submodule of Video Embed Field that provides a Media source plugin, so remote videos (YouTube, Vimeo, …) become first-class Media entities usable in the core Media library.

---

`video_embed_media` bridges `video_embed_field` and core Media. It defines a `@MediaSource` plugin (`id = "video_embed_field"`) that stores a provider video URL on a media entity and derives the media's name and thumbnail from the video. This lets editors add and reuse videos through the standard Media library UI, reference them with Media reference fields, and manage them alongside images, documents and other media. Because the source builds on video_embed_field's provider plugins, any provider added to the parent module is automatically available. The nested `vem_migrate_oembed` submodule offers a Drush path to migrate these entities to core's oEmbed video source. Requires the core Media module and the parent video_embed_field module.

---

- Create a "Remote video" style Media type backed by video_embed_field.
- Add YouTube/Vimeo videos through the core Media library UI.
- Reuse a single embedded video across many nodes via a Media reference field.
- Give videos a thumbnail derived from the provider preview image.
- Present videos alongside images and documents in one media system.
- Curate a browsable, searchable library of external videos.
- Attach videos to content using an entity reference (media) field.
- Apply the video_embed_field formatters to media-referenced videos.
- Restrict allowed providers on the media source field.
- Let non-technical editors pick existing videos instead of pasting URLs each time.
- Build a decoupled front end that queries video media entities.
- Standardise video metadata (name, thumbnail) via the media source mappings.
- Support translation/workflow on video media like any other media entity.
- Migrate video_embed_media entities to core oEmbed with the vem_migrate_oembed Drush command.
- Seed a media type whose default thumbnail is the bundled video icon.
- Combine with Media Library widget for in-CKEditor video insertion.
