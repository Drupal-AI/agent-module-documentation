# Theme & libraries

## Theme hook `instagram_media_block`
Declared by `Drupal\instagram_media\Hook\InstagramMediaTheme`. Template: `templates/instagram-media-block.html.twig`. Override by copying that template into your theme.

Variables:

| Variable | Content |
|---|---|
| `posts` | array of post rows; each has `media_type`, `media_url` (a render array for images / local uri for video), `caption`, `like_count`, `comments_count`, `permalink`, `video_class`, `fancybox_full_uri` |
| `autoplay`, `video` (hide-videos), `post_caption`, `insights`, `fancybox` | booleans |
| `grid` | grid class (`no-grid`, `grid-4`, …) |
| `title_config` | `{ has_title, title }` |
| `swiper_config` | `{ swiper, swiper_arrow, swiper_pagination }` |
| `header_mode` | `only_link` / `tag_and_link` / `all_info` |
| `user_links` | profile row (`name`, `username`, `profile_url`, `profile_picture_url`, `media_count`, `followers_count`, `follows_count`) — only when "View links" is on |

The template autoescapes all values (captions, usernames, URLs); images are rendered through core image render arrays. It defines Twig macros `render_media` (image/video markup) and `format_count` (caps insight counts at `99+`).

## Libraries (`instagram_media.libraries.yml`)
- `instagram_media/instagram` — the module's CSS (`misc/css/instagram.css`), attached automatically unless the block's `disabled_style` is checked.

When a block enables **Swiper** or **Fancybox**, the block attaches `"<active_theme>/swiper"` / `"<active_theme>/fancybox"` — i.e. it expects the **active theme** to define libraries named `swiper` and `fancybox` (carousel/lightbox JS+CSS). The module itself ships neither; if the theme lacks them, those features attach a missing library and stay unstyled/inert.
