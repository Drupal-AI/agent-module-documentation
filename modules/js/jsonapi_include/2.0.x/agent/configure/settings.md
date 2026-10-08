<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure JSON:API Include

One setting. Form route `jsonapi_include.settings` at **`/admin/config/services/jsonapi/include`**
(also linked as a task tab under the JSON:API settings; requires `administer site configuration`).

## The setting

Config object **`jsonapi_include.settings`**:

```yaml
use_include_query: false   # boolean, shipped default
```

- **`use_include_query: false`** (default) — **every** JSON:API response is parsed and flattened.
- **`use_include_query: true`** — opt-in mode: a response is flattened **only** when the request
  carries `jsonapi_include=1` in the query string, e.g.
  `/jsonapi/node/article?include=field_tags&jsonapi_include=1`. Requests without it get the
  standard compound (raw) JSON:API document.

The form field is the checkbox "Use jsonapi_include query in url".

## Read / set it

```bash
drush cget jsonapi_include.settings use_include_query
drush cset jsonapi_include.settings use_include_query true -y    # switch to opt-in
drush cset jsonapi_include.settings use_include_query false -y   # flatten all (default)
```

## Caching

The response subscriber adds the cache context `url.query_args:jsonapi_include`, so the flattened
and non-flattened variants of the same URL are cached as separate entries. This matters only in
opt-in mode, where the same path can return either shape depending on the query arg.

## When it acts

Only on JSON:API routes, and only when the response body starts with `{"jsonapi"`. Non-JSON:API
responses are never touched.
