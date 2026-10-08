# Token Url Plus — agent index

Adds `current-page` URL tokens that include the query string, with filter variants to keep or drop
named query parameters. Pure token module: depends on `token`; no config, no permissions, no
Drush, no plugins, no schema. Implemented in `token_url_plus.module` via `hook_token_info_alter`
+ `hook_tokens`.

- **The tokens provided and how to use / chain them** → [api/tokens.md](api/tokens.md)

Key facts:
- New tokens: `[current-page:url-with-query]`, and chained type `url-with-query` with
  `:without-some-parameters:<csv>` and `:with-some-parameters:<csv>`.
- URLs built from the current request (`Url::createFromRequest()`, fallback
  `Url::fromUserInput()`), absolute, via `toString(TRUE)`.
- Adds the `url` cache context + generated-URL cacheable metadata to bubbleable metadata.
- Primary consumer: Metatag canonical / og:url fields.
