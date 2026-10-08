Token Url Plus adds `current-page` URL tokens that include the query string — including variants that keep or drop specific query parameters — for building canonical URLs that need to preserve (or strip) parameters like paging or UTM tags.

---

Core's `[current-page:url]` token drops the query string, which is a problem for canonical URLs on
paged or filtered pages. This module (dependency: the Token module) fills that gap via
`hook_token_info_alter` + `hook_tokens`. It adds `[current-page:url-with-query]` (the current
absolute URL *with* its query string) and a chained token type `url-with-query` exposing two
filtered forms: `[current-page:url-with-query:without-some-parameters:a,b,c]` returns the current
URL with the named query parameters removed (e.g. strip `utm_campaign,utm_medium,utm_source`), and
`[current-page:url-with-query:with-some-parameters:a,b]` returns the URL keeping only the named
parameters (e.g. `page,category_id`). URLs are built from the current request with
`Url::createFromRequest()` (falling back to `Url::fromUserInput()` on 404-type failures),
generated absolute via `toString(TRUE)`, and the `url` cache context plus generated-URL cache
metadata are added to bubbleable metadata so caching stays correct. There is no configuration,
no permissions, and no UI — the tokens simply become available anywhere Drupal tokens are used
(Metatag canonical fields being the primary use case).

---

- Build a canonical URL that preserves the query string on paged listing pages.
- Set a self-referential canonical that keeps the `page` parameter so paginated pages are distinct.
- Strip tracking parameters (`utm_source`, `utm_medium`, `utm_campaign`) from a canonical URL.
- Keep only meaningful filter parameters (e.g. `category_id`) in a canonical URL and drop the rest.
- Use `[current-page:url-with-query]` in a Metatag canonical or og:url field.
- Preserve a `?page=N` pager parameter in SEO metadata while dropping session/tracking noise.
- Produce clean canonical URLs for faceted/filtered views that rely on query parameters.
- Include query parameters in any tokenized text that references the current page URL.
- Feed the current URL-with-query into a token-aware field, block, or view.
- Normalize canonical URLs by removing a fixed set of ephemeral query parameters.
- Whitelist exactly which query parameters are considered canonical for a page.
- Avoid duplicate-content penalties by controlling which parameters appear in canonical tags.
- Reference the full current URL (path + query) in email or notification tokens.
- Chain the filter tokens to customize URL output per placement without code.
- Keep cache metadata correct (the `url` context is added) when using these tokens in cached output.
