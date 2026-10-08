# Runtime behaviors (hooks, templates, filter)

All from `src/Hook/VarbaseMediaHooks.php` unless noted. These are hook implementations the
module runs automatically — you do not call them. Templates live in `templates/`, JS/CSS in
`js/` and generated CSS libraries in `varbase_media.libraries.yml`.

## Remote-video oEmbed rendering

- `hook_preprocess_field` — for fields formatted with `oembed` on a `remote_video` media
  bundle, rebuilds the iframe `src` to route through core's `media.oembed_iframe` route,
  adding query args `url`, `max_width`, `max_height`, `type=remote_video`, `provider`,
  `view_mode`, `langcode`, and `hash` (core `media.oembed.iframe_url_helper::getHash`). Langcode
  falls back media-lang → current-lang → `en`.
- `hook_theme` + template `media-oembed-iframe--remote-video.html.twig`; theme hook
  `media_oembed_iframe__remote_video`.
- `hook_theme_suggestions_media_oembed_iframe_alter` — adds suggestions by provider / view_mode
  / type (e.g. `media_oembed_iframe__youtube`, `…__remote_video__vimeo__hero`).
- `hook_preprocess_media_oembed_iframe` (+ the `__remote_video` variant) — exposes `type`,
  `provider`, `view_mode`, `langcode`, `base_path`, `varbase_media_path`, and `media_title`
  (from the oEmbed resource) to those templates.
- `hook_oembed_resource_url_alter` — Vimeo only: rewrites `&`/`?` in the video URL to `/&`
  so Vimeo arguments survive oEmbed.

## Video-player play-icon overlay

- `hook_entity_view_alter` (media entities, not `field_preview` mode) — attaches
  `varbase_media/common` (+ `common_logged` for authenticated users) and, when a video field is
  present or the bundle is `video`/`remote_video`, `varbase_media/varbase_video_player`; wraps
  `field_media_oembed_video` / `field_media_video_file` in a `.varbase-video-player` div and the
  cover image / thumbnail in play-icon overlay divs.
- `hook_views_pre_render` + `hook_preprocess_views_view_table` — attach the video-player library
  and add `media-bundle--<bundle>` classes to table rows containing video media.
- `hook_preprocess_media_library_item` — adds `media-library-item` / `--grid` classes.

## CKEditor 5 media resize + drimage

- `hook_library_info_alter` — injects `varbase_media` assets (drimage, common, video-player,
  ckeditor CSS) into core's `internal.drupal.ckeditor5.media` library, and (if
  `drimage_improved` is enabled) `drimage_improved/drimage_improved`; also hooks
  `media_library/widget` and `ckeditor_media_resize/editor`.
- `hook_editor_js_settings_alter` — on the `full_html` format, sets the CKEditor media
  `resizeUnit` to `%` and appends Large (100), Medium (50), Small (25) resize options. No-op if
  `ckeditor_media_resize` is not enabled.
- `hook_filter_info_alter` — replaces the `filter_resize_media` filter **class** with
  `VarbaseFilterResizeMedia` (`src/Plugin/Filter/VarbaseFilterResizeMedia.php`), which extends
  `ckeditor_media_resize`'s `FilterResizeMedia` and, when neither `drimage_improved` nor
  `drimage` is enabled, maps the `data-media-width` to a `data-view-mode` by image-style width;
  when drimage is present it lets drimage handle responsiveness. It does **not** register a new
  filter plugin id — it overrides the existing one, so enable/configure the filter via the
  `ckeditor_media_resize` module's "Resize media images" filter on your text format.

## Entity-embed & image SDC fixes

- `hook_preprocess_entity_embed_container` — sets `url` from
  `data-entity-embed-display-settings.link_url`, sanitized with `UrlHelper::filterBadProtocol`.
  `hook_theme_registry_alter` repoints the `entity_embed_container` template to this module's
  `templates/entity-embed-container.html.twig`.
- `hook_preprocess_image` — removes standalone `width`/`height` (and NULL `sizes`) Twig vars
  after they're copied to attributes, so `vartheme_bs5:image` SDC props don't get pixel ints
  (avoids `InvalidComponentException`).
- `hook_form_alter` — on media entity forms, hides/disables revision info, log message, and
  forces the revision checkbox on (hidden) for a simpler editor UX.
