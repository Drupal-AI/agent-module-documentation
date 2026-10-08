<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring per-path limits

This module has **no UI and no exported config**. Its only setting is the container parameter
`jsonapi_page_limit.size_max`, which you define in a **custom `services.yml`** (typically
`sites/default/services.yml`). It maps request-path patterns to a maximum item count.

```yaml
parameters:
  jsonapi_page_limit.size_max:
    /jsonapi/node/page: 100
    /jsonapi/taxonomy/*: 75
```

Then rebuild the container so Drupal picks up the change:

```
drush cr
```

## How it resolves (from `src/Controller/EntityResource.php`)

1. The request must include a `page[limit]` query parameter. If it does not, nothing changes and core's
   normal 50 cap applies.
2. The current request path (`router.request_context->getPathInfo()`) is matched against every key in
   `size_max` using `path.matcher` (`matchPath`), so **wildcards** like `/jsonapi/taxonomy/*` work.
3. **First match wins** — `array_filter` preserves order and `reset()` takes the first matching entry.
   Order your keys most-specific-first.
4. The effective limit is `min($requested_limit, $matched_max)`. If no key matches, the fallback is
   `OffsetPage::SIZE_MAX` = **50**.

## Behaviour notes / gotchas

- **It is a ceiling, not a default.** Raising `/jsonapi/node/page` to 100 does not make responses
  return 100; the client must send `?page[limit]=100`. A plain request still returns 50.
- **It can also lower limits.** Setting a path to `10` caps that path at 10 items even if a client asks
  for 50.
- **Paths, not routes.** Keys are URL paths (with any JSON:API path prefix your site uses), because the
  service is built during route matching before a route name exists (see the comment in
  `jsonapi_page_limit.services.yml`).
- **Empty by default** — with no parameter set, the module does nothing.
- **Container parameter, not config entity** — changes are code/deploy artifacts and need `drush cr`;
  they are not managed by config import/export.
- **Alternative:** `jsonapi_defaults` (in `jsonapi_extras`) makes the raised number the default instead
  of requiring an explicit `page[limit]`, and is more actively maintained.

## Performance caution

Every returned entity is loaded, access-checked and serialised. Set each ceiling to what that specific
resource can serve within its response-time budget — a 200-term vocabulary is cheap; 200 nodes with
rendered fields and relationships is not. Raise limits narrowly and measure.
