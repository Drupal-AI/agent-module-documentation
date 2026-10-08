Adds the Twitter Cards (`twitter:*`) meta tag family so links shared on Twitter/X render as rich summary, image, player, or app cards.

---

Twitter/X uses `twitter:*` meta tags to decide how a shared link is displayed — as a plain summary, a summary with a large image, a media player, or an app-install card. This submodule registers ~24 of those tags as Metatag plugins: card type, title, description, image (with alt), site/creator handles and IDs, player embed dimensions and stream, and app-card IDs/names/URLs for iPhone, iPad, and Google Play. All are token-enabled and settable as defaults or per entity. Depends on the main Metatag module; commonly used with Open Graph, from which Twitter falls back for missing values.

---

- Choose the card type with `twitter:card` (summary, summary_large_image, player, app).
- Set the card title with `twitter:title`.
- Set the card description with `twitter:description`.
- Provide a card image with `twitter:image` (+ `twitter:image:alt`).
- Attribute the site with `twitter:site` / `twitter:site:id`.
- Attribute the author with `twitter:creator` / `twitter:creator:id`.
- Embed a media player with `twitter:player` (+ width/height).
- Provide a player stream (`twitter:player:stream`, `…:content_type`).
- Add iPhone app-card data (`twitter:app:id:iphone`, `twitter:app:name:iphone`, `twitter:app:url:iphone`).
- Add iPad app-card data (`twitter:app:*:ipad`).
- Add Google Play app-card data (`twitter:app:*:googleplay`).
- Set the app country with `twitter:app:country`.
- Get large-image previews when articles are tweeted.
- Set Twitter Card defaults globally.
- Override Twitter tags per content type.
- Populate image/description from tokens.
- Drive app installs from tweeted links.
- Improve click-through from Twitter/X.
- Pair with Open Graph so Twitter reuses OG values.
- Standardize Twitter tagging across a site.
- Keep Twitter config exportable.
- Provide accurate creator attribution on shares.
