# Twitter Cards tags

Adds a "Twitter Cards" MetatagTag group (`<meta name="twitter:…">`).

- **Core** — `twitter:card` (summary | summary_large_image | player | app),
  `twitter:title`, `twitter:description`, `twitter:image`, `twitter:image:alt`,
  `twitter:site`, `twitter:site:id`, `twitter:creator`, `twitter:creator:id`.
- **Player card** — `twitter:player`, `twitter:player:width`, `twitter:player:height`,
  `twitter:player:stream`, `twitter:player:stream:content_type`.
- **App card** — `twitter:app:country`, and id/name/url for `iphone`, `ipad`,
  `googleplay` (e.g. `twitter:app:id:iphone`, `twitter:app:name:googleplay`,
  `twitter:app:url:ipad`).

Set as Metatag defaults or per entity; token-enabled. Twitter falls back to Open Graph for
missing values. Schema: `config/schema/metatag_twitter_cards.metatag_tag.schema.yml`.
