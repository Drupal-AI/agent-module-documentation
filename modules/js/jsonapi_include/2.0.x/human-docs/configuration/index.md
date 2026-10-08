# Configuration

JSON:API Include has exactly **one** setting: whether it flattens *every* JSON:API
response, or only the requests that explicitly ask for it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → JSON:API** and open the **Include** task tab,
   or navigate directly to `/admin/config/services/jsonapi/include`.

The setting is stored in the config object **`jsonapi_include.settings`**.

## The setting

**Use jsonapi_include query in url** (`use_include_query`) — a single checkbox.

- **Unchecked** *(default)* — **every** JSON:API response is parsed and flattened. This is
  the right choice for a fully decoupled site that always wants merged output.
- **Checked** — opt‑in mode. A response is flattened **only** when the request carries
  `jsonapi_include=1` in the query string, for example
  `/jsonapi/node/article?include=field_tags&jsonapi_include=1`. Requests without that
  query argument get the standard raw compound JSON:API document. Use this when existing
  clients rely on the untouched shape and you want new clients to opt in explicitly.

## Reading and setting it from the command line

```bash
drush cget jsonapi_include.settings use_include_query
drush cset jsonapi_include.settings use_include_query true -y    # switch to opt-in
drush cset jsonapi_include.settings use_include_query false -y   # flatten everything (default)
```

## How caching handles the two shapes

The module adds the cache context `url.query_args:jsonapi_include`, so the flattened and
non‑flattened variants of the same URL are cached as separate entries. This matters in
opt‑in mode, where the same path can return either shape depending on whether the query
argument is present.

## When it acts

The transformation only runs on JSON:API routes, and only when the response body starts
with `{"jsonapi"`. Non‑JSON:API responses are never touched.
