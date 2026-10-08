DDECK Plyr & Advanced Media provides Drupal field formatters that render local audio/video files and YouTube/Vimeo links through the Plyr player and image fields as PhotoSwipe lightbox galleries.

---

The module ships no configuration form, routes, permissions, or content types. Instead it adds four `FieldFormatter` plugins you select on any entity's Manage display page, plus an `image_gallery` media source and a `hook_library_info_alter()` that registers the module's stylesheet with CKEditor 5. The three Plyr formatters (`DdeckPlyrFileAudioFormatter`, `DdeckPlyrFileVideoFormatter`, `DdeckPlyrRemoteVideoFormatter`) accept a single JSON `settings` textarea whose keys map to Plyr player options (autoplay, loop, resetOnEnd, hideControls, a `controls` object, and a `youtube` privacy object); the shared `DdeckPlyrSharedFormatterTrait` decodes that JSON, builds the `data-plyr-config` attribute, and falls back to legacy flat keys for backward compatibility. The `PhotoswipeMediaGalleryFormatter` renders an image field as one gallery container with per-image thumbnail and full-size image styles, wired to PhotoSwipe via the `advanced-media-gallery` behavior. Rendering uses Single Directory Components (`ddeck_advanced_media:plyr`, `ddeck_advanced_media:media_gallery`) and Twig templates; the Plyr and PhotoSwipe JS/CSS libraries must be installed under `/libraries/`.

---

- Play local audio files (MP3/OGG/WAV) with an accessible Plyr audio player via the DDECK Plyr for audio files formatter.
- Play local video files (MP4/WebM) with a Plyr video player via the DDECK Plyr for video files formatter.
- Embed YouTube and Vimeo videos from a link/string/string_long field using the DDECK Plyr for remote videos formatter.
- Show a media thumbnail poster over remote videos before playback starts.
- Turn a multi-value image field into a responsive PhotoSwipe lightbox gallery.
- Configure Plyr behavior (autoplay, loop, reset-on-end, auto-hide controls) per display via a JSON settings textarea.
- Select exactly which Plyr control buttons appear (play, progress, current-time, duration, mute, volume, settings, fullscreen, etc.).
- Enable YouTube privacy-enhanced mode (`youtube.noCookie`) to serve from youtube-nocookie.com.
- Standardize modern media playback UX across many content types without custom front-end code.
- Keep all display configuration inside Drupal's native Manage display UI rather than in custom templates or JS.
- Apply a thumbnail image style to gallery grid previews and a separate image style to the opened PhotoSwipe image.
- Reuse existing Media and image fields — no new content type is created by the module.
- Add the module's CKEditor 5 stylesheet automatically so gallery/media markup styles consistently in the editor.
- Provide an `image_gallery` media source for building reusable image-gallery media types.
- Localize Plyr control labels through Drupal.t() in the player behavior.
- Cache remote-video output correctly by adding each field item as a cacheable dependency.
- Copy the default JSON player settings from the formatter form as a starting template and tweak per display.
- Fall back to original image files when no image style is chosen for gallery thumbnails or full images.
- Serve media-heavy galleries efficiently by pairing configured image styles with a CDN/caching strategy.
- Migrate older per-key formatter settings automatically through the trait's backward-compatibility path.
- Present audio, video, remote video, and image galleries through one installed module instead of several.
