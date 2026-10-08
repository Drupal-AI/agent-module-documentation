# Social Feed theming & remote-HTML rendering

## Theme hooks & templates (registered in `socialfeed_theme()`)

| Hook | Template | Preprocess (`.theme.inc`) |
|---|---|---|
| `socialfeed_facebook_post` | `templates/facebook/socialfeed-facebook-post.html.twig` | `template_preprocess_socialfeed_facebook_post` |
| `socialfeed_twitter_post` | `templates/twitter/socialfeed-twitter-post.html.twig` | `template_preprocess_socialfeed_twitter_post` |
| `socialfeed_instagram_post_image` | `…/instagram/socialfeed-instagram-post-image.html.twig` | `_socialfeed_instagram_preprocess` |
| `socialfeed_instagram_post_video` | `…-video.html.twig` | same |
| `socialfeed_instagram_post_carousel_album` | `…-carousel-album.html.twig` | same |

Facebook adds a theme suggestion per post `status_type`
(`socialfeed_facebook_post__<status_type>`, e.g. `__added_photos`). Override any template in your theme.

## What preprocess does

- **Facebook** (`socialfeed.facebook.theme.inc`): trims `post.message` to `trim_length`, links `#hashtags`
  to facebook.com (`target=_blank rel=noopener`), builds the "Read More" permalink Link, derives an
  `image_alt` from `strip_tags(message)`, formats `created_time` with Carbon, attaches
  `socialfeed/facebook_style` when default styling is on, and finally wraps the message as
  `['#markup' => $post['message']]`.
- **X** (`socialfeed.twitter.theme.inc`): converts bare URLs and `#hashtags`/`@mentions` to Links, trims
  to `trim_length`, formats the date (absolute or Carbon `diffForHumans()` relative), and sets
  `['#markup' => $tweet]`.
- **Instagram**: only sets the style flag / attaches CSS; media URLs and captions render directly in Twig
  (caption used as truncated `alt`).

## Remote-HTML render note (by design)

Facebook `post.message` and the X `tweet` come from the remote social APIs and are emitted through
Drupal `#markup`. During rendering, `#markup` string values are passed through `Xss::filterAdmin()`,
which strips `<script>`, `on*` event handlers, and dangerous URL protocols but permits a broad
admin-level tag set — it is **not** a strict allow-list. In practice script-injection is prevented, but
the displayed content is only as trustworthy as the connected social account and what
`Xss::filterAdmin()` permits. This is standard "admin-trusted remote HTML" output. If you need stricter output, override the templates and run the
text through your own filter/allow-list, or `strip_tags()` in a template override. The Instagram OAuth
callback also echoes the obtained token via `#markup`, but that route requires `administer socialfeed`.
