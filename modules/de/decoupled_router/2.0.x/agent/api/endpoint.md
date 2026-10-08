<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the translate-path endpoint

## Request

```
GET /router/translate-path?path=<front-end-path>&_format=json
```

- Route name: `decoupled_router.path_translation` (`decoupled_router.routing.yml`).
- Method: `GET` only. `_format: json` is required. Permission: **`access content`**.
- Auth options accepted: `basic_auth`, `cookie`, `oauth2`, `jwt_auth`.
- `path` is the single required query arg — a site-relative path or alias, URL-encoded.
  Missing/empty `path` → `404` ("Unable to translate empty path…").
- Both an **alias** (`/about-us`) and its **canonical system path** (`/node/42`) resolve to
  the same entity and the same `resolved` URL (the alias).

## Success response (HTTP 200)

Content entity behind a matched route:

```json
{
  "resolved": "https://example.com/about-us",
  "isExternal": false,
  "isHomePath": false,
  "entity": {
    "canonical": "https://example.com/about-us",
    "type": "node",
    "bundle": "page",
    "id": "42",
    "uuid": "3e2b1590-4a1a-43a8-bba1-2fbe61e9fc8e"
  },
  "label": "About us"
}
```

- `label` is present only when the user has `view label` access on the entity.
- With **JSON:API enabled**, an extra `jsonapi` block is added (this is the whole point of
  the module for JSON:API consumers):

```json
"jsonapi": {
  "individual": "https://example.com/jsonapi/node/page/3e2b1590-…",
  "resourceName": "node--page",
  "pathPrefix": "jsonapi",
  "basePath": "/jsonapi",
  "entryPoint": "https://example.com/jsonapi"
}
```
  (`jsonapi.pathPrefix` is deprecated in favor of `basePath`; a `meta.deprecated` note is
  included.) With JSON:API **disabled** the response simply omits the `jsonapi`/`meta` keys.

## Other status codes

| Status | When |
|---|---|
| `200` + `{ "resolved", "isExternal": true, "isHomePath": false }` | `path` is an external URL — passed through, no Drupal lookup |
| `403` | Path matched but the user cannot `view` the entity (unpublished/restricted), or the route method is not allowed |
| `404` | Path matches no route, matches a route with no entity, or `path` is empty. Body: `{ "message", "details" }`. Tagged `4xx-response` |
| `500` | A valid entity had no buildable canonical URL |

`isHomePath` is `true` when the resolved URL equals the site's configured front page
(`system.site:page.front`). Responses are cacheable and vary by `url.query_args:path` and
content language; alias insert/update/delete auto-invalidates them (see `hook_path_*` /
`hook_path_alias_insert` in `decoupled_router.module`).

## Internals (for extension/debugging)

- Controller `PathTranslator::translate()` builds a `PathTranslatorEvent`
  (`Drupal\decoupled_router\PathTranslatorEvent`, event name constant
  `PathTranslatorEvent::TRANSLATE` = `decoupled_router.translate_path`) seeded with a `404`
  response, then dispatches it. Subscribers fill in the real response.
- `RouterPathTranslatorSubscriber::onPathTranslation()` (service
  `decoupled_router.router_path_translator.subscriber`) does the entity resolution above via
  `router.no_access_checks`.
- `RedirectPathTranslatorSubscriber` runs only when the **redirect** module is installed and
  resolves configured redirects before entity lookup, reporting the redirect chain/status.
- To call the resolver **without HTTP** (e.g. in a test or Drush), dispatch the event
  yourself:

```php
use Drupal\decoupled_router\PathTranslatorEvent;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\HttpKernelInterface;

$event = new PathTranslatorEvent(
  \Drupal::service('http_kernel'),
  Request::create('/router/translate-path?path=/about-us'),
  HttpKernelInterface::MAIN_REQUEST,
  '/about-us'
);
\Drupal::service('event_dispatcher')->dispatch($event, PathTranslatorEvent::TRANSLATE);
$data = json_decode($event->getResponse()->getContent(), TRUE);
```
