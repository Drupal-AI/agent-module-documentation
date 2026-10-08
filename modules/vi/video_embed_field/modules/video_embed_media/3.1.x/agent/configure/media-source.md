# Media source

Defines a media source plugin (`src/Plugin/media/Source/VideoEmbedField.php`):

```php
/**
 * @MediaSource(
 *   id = "video_embed_field",
 *   ...
 *   default_thumbnail_filename = "video.png"
 * )
 */
```

## Set up
1. Enable the module (pulls in `media` + `video_embed_field`).
2. **Admin → Structure → Media types → Add media type**, choose source **Video embed field**.
3. The source adds a `video_embed_field` source field storing the provider URL; map the media
   name/thumbnail to it.
4. Add the media type to a Media reference field or the Media library.

Thumbnails come from the provider (via video_embed_field's provider plugins); the bundled
`video.png` is the fallback. Config schema: `config/schema/video_embed_media.schema.yml`.
