Video Embed Field provides a pluggable Drupal field type for storing a video URL from a third-party host (YouTube, Vimeo, …) and rendering it as a responsive embed with an optional locally-cached preview thumbnail.

---

Editors paste a video URL into a normal field and the module recognises the provider, renders the embed iframe, and (for thumbnail/colorbox formatters) downloads the remote preview image so it can be run through Drupal image styles. Providers are plugins managed by `ProviderManager` (annotation `@VideoEmbedProvider`), so YouTube, YouTube playlist and Vimeo ship in core and additional hosts can be added by any module. Several field formatters are included: full Video, Thumbnail (linked to content or the video), Lazy load, and a Colorbox modal formatter. Each formatter exposes settings for autoplay, responsive sizing, explicit width/height, iframe `loading` mode, image style and link target. A "never autoplay videos" permission lets you disable autoplay per role for accessibility. Developers can preprocess the `video_embed_iframe` render element (globally or per provider) and alter the provider plugin definitions through hooks. Submodules integrate the field with the core Media library (`video_embed_media`) and CKEditor 5 (`video_embed_wysiwyg`).

---

- Add a "video" field to a content type that accepts YouTube and Vimeo URLs.
- Embed a responsive YouTube player that scales to its container width.
- Display a Vimeo video with a fixed 854×480 size.
- Show only a preview thumbnail that links to the full node.
- Show a thumbnail that opens the video in a Colorbox modal/lightbox.
- Lazy-load the video iframe so it only loads on interaction/scroll.
- Cache remote video thumbnails locally and run them through image styles.
- Restrict a field to allow only specific providers (e.g. YouTube only).
- Disable autoplay for certain roles via the "never autoplay videos" permission.
- Set the iframe `loading` attribute to lazy or eager per formatter.
- Embed an entire YouTube playlist with the YouTube Playlist provider.
- Start a YouTube video at a specific time index from the URL.
- Add support for a new video host by writing a VideoEmbedProvider plugin.
- Replace the built-in YouTube provider class with a custom implementation via hook.
- Add a CSS class to all Vimeo iframes by preprocessing the iframe element.
- Enable a YouTube feature (e.g. modestbranding) by altering the iframe query string.
- Create a Media type backed by video_embed_field for the Media library.
- Insert videos inside CKEditor 5 rich-text content without the Media suite.
- Provide a decoupled front end with a stored, validated external video URL.
- Migrate legacy Embedded Media Field (emvideo) data into video fields.
- Migrate video_embed_media entities to core oEmbed with the vem_migrate_oembed Drush command.
- Validate on input that a pasted URL matches a supported provider.
- Give content authors a single text box instead of complex embed markup.
- Standardise video presentation site-wide through formatter settings.
