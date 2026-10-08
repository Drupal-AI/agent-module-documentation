# Hooks

## Implemented by this module (`instagram_media.module`)
- `hook_cron()` — runs `$service->tokenRefresh()` then `$service->updateInstagramMediaData()`. So every cron: refresh any near-expiry auto-refresh tokens, then re-fetch and re-download the feed for every `instagram_media` block (each block's media directory is purged and each cached table is truncated + rebuilt). Feed freshness is therefore tied to your cron interval.
- `hook_theme()` — declares the `instagram_media_block` theme hook (delegates to `InstagramMediaTheme::hook()`). See [theme](../theme/theme.md).
- `hook_help()` — on `help.page.instagram_media`, returns the module's `README.md` wrapped in `<pre>` (delegates to `Help::hook()`).

## Invoked for integrators (alter hook)
`InstagramMedia::build()` calls, just before returning the render array:

```php
\Drupal::moduleHandler()->alter('instagram_media_build', $build);
```

Implement `hook_instagram_media_build_alter(array &$build)` in any module to modify the block's render array — e.g. add/remove `#attached` libraries, tweak `#posts`, or adjust `#swiper_config` / `#header_mode`. The `$build` keys available: `#theme`, `#posts`, `#autoplay`, `#video`, `#post_caption`, `#insights`, `#grid`, `#title_config`, `#swiper_config`, `#header_mode`, `#fancybox`, and `#user_links` (only when "View links" is on).

No custom entity hooks, no `hook_requirements`, no drush integration.
