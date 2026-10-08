<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translate View Path (tvp) makes a Views page's URL follow the language-specific path alias you create for it in core's URL Alias UI, so views — and the segmented URLs Facets Pretty Paths builds on top of them — get localised paths in a multilingual site.

---

A Views page display exposes a fixed route path, e.g. `/program`. Core lets you create a path alias for that path per language (`/admin/config/search/path`), but because the view is reached by a *route* rather than by an entity canonical URL, core does not swap the route path for that alias when it builds or resolves the URL — so a Norwegian visitor still sees and links to `/program` even though you aliased it to `/programmes`. This module closes that gap with one service, `tvp.page_path_processor` (`Drupal\tvp\PathProcessor\TvpProcessor`), registered as both an **inbound** path processor (priority 1000) and an **outbound** path processor (priority -1000). On outbound URL generation, when the language of the URL being built matches a language for which the view path has an alias, the processor rewrites the view path to that alias; on inbound requests it does the reverse, turning the aliased request path back into the view route path so routing still resolves. It discovers candidate paths by scanning **all views' display paths** (via `Views::getAllViews()`, skipping any `admin/`-prefixed path), looks up each path's alias for every enabled language through the core alias manager, and **caches** that map for 24 hours under the cache id `view_path_aliases_cid` in the default cache bin — so after adding or changing a view path or its aliases you must clear caches. Admin paths and `/` are always left untouched. Its headline use case is **Facets Pretty Paths**, where the URL (`/products/colour/red/...`) is generated dynamically from the view path plus facet segments and would otherwise stay in the source language. The module has no routes, no permissions, no settings form, and no config of its own — all configuration is the core URL-alias entries you create per language. Depends on core `path_alias` and `views`; version 1.1.2 on core `^8.8.0 || ^9 || ^10 || ^11`, PHP >= 8.

---

- Serve a Views page under a translated path per language (`/program` → `/programmes` for `nb`).
- Localise the URL of a faceted listing built with Facets Pretty Paths.
- Give a French visitor a French view URL instead of English path segments.
- Keep a multilingual product-catalogue view's URL in the visitor's language.
- Improve per-language SEO by aligning a listing's URL with its content language.
- Make generated links (menus, breadcrumbs, `Url::fromRoute()`) to a view emit the localised path.
- Resolve an incoming request to an aliased view path back to the correct view/route.
- Localise a search-results view path on a multilingual site.
- Translate a category or archive listing's URL segment.
- Alias each language of a view path independently through core's URL Alias UI.
- Support a localised e-commerce storefront's browse/filter URLs.
- Keep faceted URLs shareable and readable in every language.
- Provide language-consistent URLs alongside a language URL prefix.
- Avoid mixed-language URLs (source-language path with a translated prefix).
- Meet a localisation/compliance requirement that URLs be in the page language.
- Reuse core's existing per-language alias workflow rather than a custom UI.
- Add localised view paths without writing a custom outbound path processor.
- Translate a taxonomy- or content-listing view's public path per language.
- Keep a multilingual events/news archive's URL localised.
- Bridge Views routing and core path aliases so aliases actually take effect on view pages.
