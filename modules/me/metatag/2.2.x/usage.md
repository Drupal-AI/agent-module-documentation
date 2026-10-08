Metatag lets you configure and manage the HTML meta tags (title, description, canonical, Open Graph, Twitter Cards, robots, and hundreds more) that Drupal outputs for every entity and page, improving SEO and control over how content appears in search engines and social networks.

---

Meta tags are `<meta>` and `<link>` elements in a page's `<head>` that describe the page to search engines, social networks, and browsers. Metatag centralizes their management: you set **default meta tags** globally and per entity type/bundle (as `metatag_defaults` config entities at Admin → Configuration → Search and metadata → Metatag), and can override them per node/term/user via a Metatag field added to the entity. Values are token-enabled (`[node:title]`, `[node:summary]`, `[site:name]`), so tags fill in automatically from content, and inheritance flows Global → entity type → bundle → entity. Each individual tag is a `MetatagTag` plugin and tags are organized into `MetatagGroup` plugins; the core module ships the Basic and Advanced groups (title, description, keywords, canonical URL, robots, referrer, geo, etc.) while submodules add Open Graph, Twitter Cards, Dublin Core, Facebook, favicons, mobile, verification and more. The `metatag.manager` service generates the render array attached to the page head, and a set of alter hooks lets code adjust tags for any route, including non-entity pages. It depends on the Token and core Field modules and integrates with Views, Page Manager, and migrations from Drupal 6/7. It is one of the most widely used SEO building blocks in the Drupal ecosystem.

---

- Set a site-wide default page title pattern like `[node:title] | [site:name]`.
- Provide an SEO meta description generated from each node's summary.
- Emit a canonical URL tag to prevent duplicate-content penalties.
- Control search-engine indexing with a `robots` tag (noindex, nofollow, noarchive).
- Add Open Graph tags so shared links show rich previews on Facebook/LinkedIn.
- Add Twitter Card tags for large-image previews when tweeted.
- Configure per-content-type defaults (articles vs. basic pages).
- Override meta tags on a single important landing page.
- Populate tags from tokens so editors never touch raw markup.
- Add Dublin Core metadata for library and academic catalogs.
- Set a favicon and touch-icon set for mobile devices.
- Emit `theme-color` and viewport tags to tune the mobile browser UI.
- Verify site ownership for Google, Bing, Pinterest, and others.
- Add hreflang tags for multilingual, multi-region sites.
- Provide `next`/`prev` pagination hints on listing pages.
- Add geo-position meta tags for location-based content.
- Set the `content-language` and cache-control meta tags.
- Attach meta tags to Views pages and displays (with Metatag: Views).
- Attach meta tags to Page Manager variants.
- Migrate meta tags from Drupal 7 Metatag or Drupal 6 Nodewords.
- Define custom, project-specific meta tags without code (Custom Tags submodule).
- Grant fine-grained per-tag edit permissions to editors (Extended Permissions).
- Alter meta tags programmatically for a custom route via `hook_metatag_route_entity()`.
- Strip or rewrite meta tags on the front page via `hook_metatags_alter()`.
- Expose a Metatag field via GraphQL/JSON:API for a decoupled front end.
- Trim description tags to a maximum length automatically.
- Add product Open Graph tags for e-commerce catalog pages.
- Provide Pinterest-specific rich pin meta tags.
- Add app-links meta tags for deep-linking into mobile apps.
