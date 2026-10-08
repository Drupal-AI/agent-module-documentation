Video Embed HTML5 adds an "HTML5" provider to the Video Embed Field module so editors can embed self-hosted / direct-link videos (URLs ending in mp4, ogg, or webm) that render in a native HTML5 `<video>` player.

---

The module contributes a single `video_embed_field` provider plugin, `html_5`, that recognises any URL ending in `.mp4`, `.ogg`, or `.webm` (matched by `getIdFromInput()`'s regex) and renders it through the `video_embed_html5` theme as `<video controls><source src=… type="video/…"></video>`, honouring the field's autoplay setting. Because it is just a provider, you use it exactly like any other Video Embed Field provider: add a *Video Embed* field and paste a direct video link. Thumbnails are handled two ways: server-side, if the optional `php_ffmpeg` module is installed the provider grabs a frame at 1 second with FFMpeg; otherwise it falls back to a client-side canvas thumbnail generated from the first frame by the `video_embed_html5/thumbnails` JS library, optionally showing a placeholder image while that happens. That placeholder behaviour is the module's only configuration: the form at `/admin/config/media/video-embed-html5` (route `video_embed_html5.config.form`, permission `administer video_embed_html5`) stores `add_placeholder` (bool, default true) and an optional uploaded `placeholder` image in `video_embed_html5.config`. It requires `video_embed_field` (^2.5 || ^3.0) and PHP 8+.

---

- Embed a self-hosted MP4 in a node using a Video Embed field.
- Play WebM or Ogg videos with a native HTML5 player, no third-party service.
- Let editors paste a direct video URL (ending in mp4/ogg/webm) instead of a YouTube link.
- Serve videos from your own CDN or file storage rather than an external provider.
- Add autoplay (muted) HTML5 video via the Video Embed Field autoplay setting.
- Restrict a Video Embed field to only the HTML5 provider via its allowed-providers setting.
- Generate video thumbnails server-side with php_ffmpeg for consistent poster images.
- Fall back to client-side canvas thumbnails when FFmpeg isn't available.
- Show a branded placeholder image while a client-side thumbnail is being generated.
- Upload a custom placeholder image for videos awaiting a thumbnail.
- Disable the placeholder entirely so nothing shows until the thumbnail renders.
- Combine HTML5 videos with core Media / Media Library workflows via Video Embed Field.
- Present privacy-friendly video (no YouTube/Vimeo tracking) on GDPR-sensitive sites.
- Reuse Video Embed Field formatters (thumbnail, video, colorbox) with local videos.
- Mix HTML5 and remote (YouTube, Vimeo) videos in the same field.
- Deliver product demo or background videos hosted alongside the site.
- Provide downloadable/streamable lecture videos in an e-learning context.
- Use the HTML5 player for short looping clips in a gallery or hero region.
- Standardise on one Video Embed field type across remote and self-hosted video.
- Export the placeholder configuration for consistent behaviour across environments.
