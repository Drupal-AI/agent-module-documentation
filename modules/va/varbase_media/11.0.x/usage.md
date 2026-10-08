Varbase Media is a Varbase-distribution feature module that layers media behaviors onto Drupal core Media: custom remote-video oEmbed rendering, a lightweight video player with play-icon overlays, CKEditor 5 media-resize (percentage) integration, `drimage_improved` responsive-image wiring, and social-share-image tokens. It is a behavioral/glue module — it ships no config, permissions, routes, or settings page.

---

Almost all of the module's logic lives in hook implementations (`src/Hook/VarbaseMediaHooks.php`) plus a token provider, a filter-plugin override, and a Twig extension. For **remote video** it rewrites the oEmbed iframe `src` in `hook_preprocess_field` to route through core's `media.oembed_iframe` (adding provider/view-mode/langcode query args and the security hash from `media.oembed.iframe_url_helper`), adds theme suggestions per provider/type/view-mode, ships a `media-oembed-iframe--remote-video` template, and fixes Vimeo URL argument escaping via `hook_oembed_resource_url_alter`. In `hook_entity_view_alter` it attaches its `common`, `common_logged`, and `varbase_video_player` libraries to media entities and wraps video / cover-image fields so a CSS play-button overlays the thumbnail (also in Views tables via `views_pre_render` / `preprocess_views_view_table`). For **rich text** it enhances CKEditor 5: `hook_library_info_alter` injects its media/drimage/video-player assets into the core CKEditor 5 media plugin, `hook_editor_js_settings_alter` switches the media resize unit to `%` and adds Large/Medium/Small (100/50/25%) resize options on `full_html`, and `hook_filter_info_alter` swaps core's `filter_resize_media` filter for `VarbaseFilterResizeMedia` (adds drimage awareness). A **Twig function** `varbase_media_drimage(src)` (`VarbaseMediaTwigExtension`) reverses a Canvas/SDC-supplied image URL back to a managed file + media entity and returns the `drimage_improved` data array for client-side responsive rendering. Finally it provides **tokens** (`VarbaseMediaTokens`): `[media:social_large|social_medium|social_small]` (image-style URLs at 1200×630 / 600×315 / 280×150) and a smart `[node:share-image]` that checks `field_media` → `field_image` → `field_video` and falls back to the active theme's `share-image.png`. It also hides revision UI on media forms and removes standalone width/height/sizes image variables to keep SDC image components valid. The only declared dependency is `drimage_improved`; the image styles and media types it references come from the wider Varbase distribution.

---

- Render remote-video (YouTube/Vimeo) media through core's oEmbed iframe with provider-aware templates.
- Fix Vimeo oEmbed URLs whose query arguments would otherwise break the embed.
- Show a click-to-play button overlay on video and remote-video thumbnails in content and Views.
- Attach a lightweight video-player behavior to `field_media_oembed_video` / `field_media_video_file`.
- Overlay a media cover image over a video player as the poster/play affordance.
- Enable percentage-based media resizing in CKEditor 5 (unit `%`).
- Offer editors named resize presets — Large 100%, Medium 50%, Small 25% — on the Full HTML format.
- Apply the `data-media-width` resize filter with drimage/drimage_improved awareness (`VarbaseFilterResizeMedia`).
- Wire `drimage_improved` responsive images into the CKEditor 5 media plugin.
- Return client-side responsive-image (drimage) data for a raw image `src` in a Twig/SDC template via `varbase_media_drimage()`.
- Generate a social-share image URL for a media entity at 1200×630 (`[media:social_large]`).
- Generate 600×315 or 280×150 share images (`[media:social_medium]`, `[media:social_small]`).
- Add a smart `[node:share-image]` token that finds the best media/image/video field automatically.
- Fall back to the active theme's `share-image.png` when a node has no suitable image.
- Feed share-image tokens into Metatag Open Graph / Twitter card fields.
- Add media-bundle CSS classes to Views table rows for per-bundle styling.
- Enhance the Media Library widget with extra grid classes and CSS.
- Hide revision information / log fields on media add/edit forms for a simpler editor UX.
- Provide per-provider / per-view-mode oEmbed iframe template suggestions for custom theming.
- Keep width/height out of SDC image component props to avoid `InvalidComponentException`.
- Use as the media layer of a Varbase-based site (best paired with the Varbase distribution).
