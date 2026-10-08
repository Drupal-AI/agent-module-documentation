# Instagram Media block

`Drupal\instagram_media\Plugin\Block\InstagramMedia` — `@Block(id = "instagram_media", admin_label = "Instagram Media Block")`.

All configuration is per block instance; there is no global settings form. Place the block in **Structure → Block layout** (or any region), then fill in the block settings form. Saving the form (`blockSubmit()`) immediately calls the service to fetch + download the feed for that block; the block is then re-populated again on every cron run.

## Behavior
- `build()` reads cached rows from `instagram_media_posts` (via `getPosts($block_id)`) and, if **View links** is on, one row from `instagram_media_links`. It does NOT hit the Graph API at render time — rendering is served from the local DB + downloaded files.
- Images render via core `#theme => image` / `image_style` / `responsive_image` depending on **Image style options**; videos render as a local `<video>`. Media files are served from `public://instagram_media/<block_id>/`.
- `blockAccess()` returns `AccessResult::allowedIfHasPermission($account, 'access content')` — i.e. the rendered feed is visible to anyone who can access content. (Editing the block, where the token lives, is gated by core block-administration access — see [permissions](../permissions/permissions.md).)
- `getCacheTags()` adds `instagram_media:media` to the block's cache tags.
- Just before returning, `build()` invokes `hook_instagram_media_build_alter(&$build)` (see [hooks](../hooks/hooks.md)).

## Settings fields
See [configure/settings.md](../configure/settings.md) for the full field-by-field table, config-object path, schema keys, and how to set them via drush/PHP. Summary of the form groups:

| Group | Fields |
|---|---|
| (top) | `token` (required textarea, long-lived token), `auto_refresh` (checkbox) |
| Config settings (shown when auto_refresh) | `app_id`, `app_secret` |
| Media settings | `image_style_options` (`''`/`image_style`/`responsive_image_style`), `image_style`, `different_image_style` + per-post `image_styles_rendering`, `responsive_image_style`, `different_responsive_style` + per-post `responsive_image_rendering`, `limit` (capped at 25 by the API), `video` (hide videos), `autoplay` |
| Post settings | `post_caption`, `insights`, `links`, `header_mode` (`only_link`/`tag_and_link`/`all_info`) |
| Styling settings | `has_title`, `swiper`, `swiper_arrow`, `swiper_pagination`, `fancybox`, `disabled_style`, `grid` (`no-grid`/`grid-4`/`grid-2-4`/`grid-5`/`grid-2-5`/`grid-6`/`grid-2-6`) |

Per-post image-style selects (`image_styles_rendering` / `responsive_image_rendering`) are rebuilt by AJAX to match `limit` and appear only when the matching "Use different styles for posts" checkbox is on. Responsive-style fields appear only when the `responsive_image` module is enabled.

## Libraries attached
- `instagram_media/instagram` (CSS) unless `disabled_style` is checked.
- `<active_theme>/swiper` when `swiper` is on, `<active_theme>/fancybox` when `fancybox` is on — these must be defined by the active theme (the module does not ship them). See [theme](../theme/theme.md).
