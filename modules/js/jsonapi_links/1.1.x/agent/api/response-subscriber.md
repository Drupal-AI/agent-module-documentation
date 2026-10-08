# Response event subscriber (API / mechanism)

The whole module is one event subscriber. There is no route, controller, service you call, or
plugin type — integration means understanding when this subscriber fires and how to keep the links
you still need.

## Service & event

- Service id: `jsonapi_links.subscriber` (`services.yml`; `autowire`/`autoconfigure` on).
- Class: `Drupal\jsonapi_links\EventSubscriber\ResponseSubscriber`.
- Subscribes to `KernelEvents::RESPONSE` at **priority 112**, method `onResponse`
  (`ResponseSubscriber.php:170`).
- Constructor deps (autowired): `config.factory`, `current_route_match`. It loads
  `jsonapi_links.settings` once in the constructor.

## When it acts (guard order in `onResponse`, ResponseSubscriber.php:51)

It runs on **every** response but exits early unless all of these hold:

1. `Content-Type` header, lowercased, is exactly `application/vnd.api+json`. A missing/non-string
   header throws `JsonApiLinksException` (`Failed to get content-type header!`); anything else just
   returns.
2. The body JSON-decodes to an object (`json_decode`) — non-string content or non-object decode
   throws `JsonApiLinksException`.
3. The decoded object has a top-level `jsonapi` property (`property_exists($json, 'jsonapi')`).
   Otherwise return.
4. The request path is **not** the JSON:API base path. It reads `jsonapi.base_path` from the current
   route match and compares to `$event->getRequest()->getPathInfo()`; if equal it returns untouched.
   This is what preserves the `/jsonapi` root document (including `meta.links.me`).
5. Config `remove_links` is truthy. If `FALSE` (the shipped default), return.

Only if all pass does it walk the tree, strip links, `json_encode` the mutated object, and
`$response->setContent()` / `$event->setResponse()`. A failed re-encode throws
`JsonApiLinksException` (`Failed to encode JSON!`).

## What gets stripped (`removeLinks`, ResponseSubscriber.php:113)

Recursive descent over the decoded object/array graph, tracking a dotted `$path` of the keys walked:

- On any node whose current dotted path matches an ignore-list regex, it stops descending there
  (`isOnIgnoreList()`, ResponseSubscriber.php:179 — `preg_match($regex, $path) === 1`).
- On an object that does **not** itself have a `jsonapi` property: it `unset()`s `->links`, and it
  `unset()`s `->meta->links` — if that leaves `meta` empty, `meta` is removed too. The node holding
  the top-level `jsonapi` property is deliberately skipped, so the **document-level `links`** (pager
  `next`/`prev`/`self`) survive; per-resource and per-relationship `links` do not.
- Recurses into every object property and every array element.

Net effect: `data[*].links`, `included[*].links`, relationship `links`, and resource `meta.links`
are removed; the top-level `links` and the `/jsonapi` root document are kept.

## Ignore list (keep specific links)

`ignore_list` is a newline-separated list of **PHP regexes** (each including delimiters, e.g.
`/^data\.[0-9]+\.relationships/`). Split on `\n`, trimmed, empties dropped
(`ResponseSubscriber.php:88`). Each is matched with `preg_match` against the current dotted path;
a match halts stripping for that subtree. Array indices appear numerically in the path
(`data.0.relationships.uid`). The value is only editable via the settings form
(`administer site configuration`) — see [../configure/settings.md](../configure/settings.md).

## Operational notes

- Priority 112 places it among the early RESPONSE subscribers; it mutates already-rendered content
  rather than the JSON:API normalization, so it composes with `jsonapi_extras` etc.
- It re-decodes/re-encodes the whole body on matching responses — a cost proportional to payload
  size on every JSON:API request while `remove_links` is on.
- This changes only the response shape. It is **not** an access control: unlinked resources remain
  reachable at their canonical JSON:API paths. Use `jsonapi` access / entity access /
  `jsonapi_permission` for the real boundary.
