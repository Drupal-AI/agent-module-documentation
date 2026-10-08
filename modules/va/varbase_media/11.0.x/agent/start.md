# Varbase Media — agent index

Varbase-distribution feature module that adds media behaviors on top of core Media: remote-video
oEmbed rendering, a video-player play-icon overlay, CKEditor 5 percentage media-resize +
`drimage_improved` responsive images, and social-share-image tokens. **No config page
(`configure` null), no permissions, no routes, no Drush, no config/install.** Logic is all
hooks + tokens + a filter override + a Twig function. Only declared dependency:
`drimage_improved`.

- **Social-share tokens: `[media:social_large|_medium|_small]` and smart `[node:share-image]`,
  the `varbase_media_drimage()` Twig function** → [api/tokens.md](api/tokens.md)
- **Runtime behaviors: remote-video oEmbed rewrite, video-player overlays, CKEditor 5 resize,
  filter override, templates, theme suggestions** → [theming/behaviors.md](theming/behaviors.md)

Key facts:
- Hook class `src/Hook/VarbaseMediaHooks.php` (attribute `#[Hook(...)]` style); tokens in
  `src/Hook/VarbaseMediaTokens.php`; Twig ext `src/Twig/VarbaseMediaTwigExtension.php`.
- Filter plugin `filter_resize_media` is **replaced** at runtime with
  `VarbaseFilterResizeMedia` (extends `ckeditor_media_resize`'s `FilterResizeMedia`) via
  `hook_filter_info_alter` — it does not define a new filter id.
- Libraries (`varbase_media.libraries.yml`): `common`, `common_logged`,
  `varbase_video_player`, `media_library_enhancements`, `ckeditor5`, `ckeditor5_media_resize`,
  `ckeditor_drimage`, `ckeditor_varbase_video_player`.
- References image styles `social_large` / `social_medium` / `social_small` and media fields
  `field_media` / `field_image` / `field_video` / `field_media_image` that come from the
  Varbase distribution, **not** shipped by this module (no config/install here).
