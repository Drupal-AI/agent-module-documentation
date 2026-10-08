# API — Tokens provided

Defined in `token_url_plus.module` (`hook_token_info_alter`, `hook_tokens`). No services or
functions to call — these are Drupal tokens, usable anywhere token replacement runs.

## Tokens
| Token | Result |
|---|---|
| `[current-page:url-with-query]` | Current page's absolute URL **including** its query string. |
| `[current-page:url-with-query:without-some-parameters:p1,p2,…]` | Current URL with the listed query parameters **removed** (others kept). |
| `[current-page:url-with-query:with-some-parameters:p1,p2,…]` | Current URL keeping **only** the listed query parameters. |

A standalone type `url-with-query` (needs-data `full-url`) is also registered with tokens
`full-url`, `without-some-parameters`, `with-some-parameters`, so the filters can be chained off
`current-page:url-with-query`.

## Examples
```
[current-page:url-with-query]
  → https://example.com/products?page=2&utm_source=news

[current-page:url-with-query:without-some-parameters:utm_campaign,utm_medium,utm_source]
  → https://example.com/products?page=2

[current-page:url-with-query:with-some-parameters:page,category_id]
  → https://example.com/products?page=2   (only page & category_id retained)
```

## Behaviour / internals
- The base URL comes from `Url::createFromRequest($request)` with `absolute => TRUE` and
  `query => $request->query->all()`; on failure (e.g. 404 routes) it falls back to
  `Url::fromUserInput($request->getPathInfo())`.
- Filters operate on the `query` Url option: `without-some-parameters` uses `array_diff_key` vs.
  `explode(',', <csv>)`; `with-some-parameters` uses `array_intersect_key`.
- Output is generated with `->toString(TRUE)` (a `GeneratedUrl`); query values are URL-encoded by
  the URL generator. The `url` cache context and the generated URL's cacheable metadata are added
  to the `BubbleableMetadata`, so cached render output stays correct per URL.

## Notes
- Values reflect the live request query string. As with any token that emits a URL, the consuming
  field is responsible for context-appropriate escaping (e.g. Metatag escapes attribute output);
  the token itself returns a properly generated, URL-encoded absolute URL of the current page.
- Language: if a `langcode` option is passed to token replacement, the URL is generated for that
  language.
