# Settings reference

Instagram Media has no admin route (`configure` is null). Settings are stored on each **block instance** in the config object `block.block.<block_id>` under the `settings` key. The config-schema type is `block.settings.instagram_media` (`config/schema/instagram_media.schema.yml`).

## Fields (block `settings.*`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `token` | string | `''` | Long-lived Facebook/Instagram access token (required). |
| `auto_refresh` | bool | FALSE | Enable cron token auto-renew (needs `app_id`+`app_secret`). |
| `app_id` | string | `''` | Facebook App ID (for token refresh). |
| `app_secret` | string | `''` | Facebook App Secret (for token refresh). |
| `image_style_options` | string | `image_style` | `''` (none), `image_style`, or `responsive_image_style`. |
| `image_style` | string | `large` | Image style machine name when `image_style` chosen. |
| `different_image_style` | int/bool | 0 | Use a per-post image style. |
| `image_styles_rendering` | mapping | – | Per-post styles keyed `image_style_<i>` (0..limit-1). |
| `responsive_image_style` | string | `wide` | Responsive style id (needs `responsive_image` module). |
| `different_responsive_style` | int/bool | 0 | Use per-post responsive styles. |
| `responsive_image_rendering` | mapping | – | Per-post keyed `responsive_style_<i>`. |
| `limit` | number | 6 | Posts to fetch/show; **hard-capped at 25** by the service. |
| `video` | bool | FALSE | "Hide videos" — replaces videos with their thumbnail image. |
| `autoplay` | bool | TRUE | Autoplay videos in the feed. |
| `post_caption` | bool | FALSE | Show post captions. |
| `insights` | bool | FALSE | Show like/comment counts. |
| `links` | bool | FALSE | Fetch + show profile header/links. |
| `header_mode` | select | `tag_and_link` | `only_link` / `tag_and_link` / `all_info`. |
| `has_title` | bool | FALSE | Render the block label as a feed title. |
| `swiper` | bool | FALSE | Carousel (needs a theme `swiper` library). |
| `swiper_arrow` | bool | FALSE | Swiper prev/next arrows. |
| `swiper_pagination` | bool | FALSE | Swiper pagination dots. |
| `fancybox` | bool | FALSE | Lightbox (needs a theme `fancybox` library). |
| `disabled_style` | bool | FALSE | Do not attach the module CSS. |
| `grid` | select | `no-grid` | `no-grid`/`grid-4`/`grid-2-4`/`grid-5`/`grid-2-5`/`grid-6`/`grid-2-6`. |

Managed automatically (not in the form): `block_id` (the block's config id) and `media_path` (`public://instagram_media/<block_id>/`). The `media` schema key exists but is unused.

> Schema note: `block.settings.instagram_media` only declares a subset of these keys (`token`, `limit`, `video`, `autoplay`, `post_caption`, `media`, `media_path`, `block_id`, `insights`, `links`, `header_mode`, `swiper*`, `fancybox`, `disabled_style`). `auto_refresh`, `app_id`, `app_secret`, `image_style*`, `responsive_image*`, `different_*`, `has_title`, `grid` are stored but not covered by schema.

## Set via drush / PHP

Read/write like any block config. Editing `token`/`limit` etc. does not re-fetch on its own — the UI submit handler is what triggers a fetch; a `drush cr` + next cron (or `drush cron`) applies changes.

```php
$block = \Drupal::configFactory()->getEditable('block.block.MYBLOCKID');
$block->set('settings.token', getenv('INSTAGRAM_TOKEN'))
  ->set('settings.limit', 9)
  ->set('settings.insights', TRUE)
  ->save();
```

```bash
ddev drush config:set block.block.MYBLOCKID settings.limit 9 -y
ddev drush cron   # re-fetches posts + refreshes the token if auto_refresh is on
```

The token, app_id and app_secret are stored as-is in this block config object (and thus in config exports). Per this repo's conventions, prefer sourcing the token from an environment variable / Key when scripting, rather than committing it.
