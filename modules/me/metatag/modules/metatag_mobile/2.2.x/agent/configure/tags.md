# Mobile & UI tags

Adds a "Mobile & UI Adjustments" MetatagTag group (~34 tags). Highlights:

- **Core** — `viewport`, `theme-color`, `format-detection`, `application-name`,
  `manifest`, `x-ua-compatible`, `cleartype`, `HandheldFriendly`, `MobileOptimized`,
  `alternate` (mobile-site link), `apple-itunes-app`.
- **Apple web-app** — `apple-mobile-web-app-capable`,
  `apple-mobile-web-app-status-bar-style`, `apple-mobile-web-app-title`.
- **Microsoft (`msapplication-*`)** — `msapplication-tilecolor`,
  `msapplication-tileimage`, square/wide logo tiles (70×70/150×150/310×310/310×150),
  `msapplication-starturl`, `msapplication-task`, `msapplication-navbutton-color`,
  `msapplication-tooltip`, `msapplication-config`, notification/badge tags.

Set as Metatag defaults (usually global) or per entity; token-enabled. Schema:
`config/schema/metatag_mobile.metatag_tag.schema.yml`.
