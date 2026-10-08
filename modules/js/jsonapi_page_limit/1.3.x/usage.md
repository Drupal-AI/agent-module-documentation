<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Page Limit raises (or lowers) JSON:API's hard 50-item collection cap for chosen request paths, so a client that asks for more with `?page[limit]=` can receive it.

---

The module ships no admin UI, routes, permissions or config entity. It works by decorating one core service: `jsonapi_page_limit.services.yml` re-registers `jsonapi.entity_resource` to the subclass `Drupal\jsonapi_page_limit\Controller\EntityResource`, which overrides `getJsonApiParams()`. Core normally builds an `OffsetPage` whose size is clamped to `OffsetPage::SIZE_MAX` (50); this subclass, only when the request actually carries a `page[limit]` query parameter, rebuilds the `OffsetPage` with a size of `min($requested_limit, $per_path_max)`, bypassing the 50 clamp. The per-path maximum comes from the container parameter `jsonapi_page_limit.size_max` — a map of path patterns to integers that you place in a custom `services.yml` (e.g. `sites/default/services.yml`), for example `/jsonapi/node/page: 100` or `/jsonapi/taxonomy/*: 75`. Lookup uses the current request path (`router.request_context->getPathInfo()`) matched against each key with Drupal's `path.matcher` (wildcards allowed); on multiple matches the first array entry wins, and paths with no entry fall back to 50. Because the value is a container parameter, changes require a container/cache rebuild (`drush cr`) to take effect, and the parameter is empty by default so the module does nothing until configured. Note the default is unchanged: a resource whose limit you raised to 100 still returns 50 unless the client explicitly requests more, which distinguishes it from `jsonapi_defaults` (in `jsonapi_extras`), where the raised number becomes the default. Access control is untouched — every returned entity still passes through JSON:API's normal entity access checks; only the pagination ceiling moves, so the real cost is performance (more entities loaded, access-checked and serialised per request).

---

- Return an entire small taxonomy vocabulary in one JSON:API request instead of paging.
- Cut round trips for a decoupled front end that assembles a view from several collections.
- Raise the cap only for a cheap resource (e.g. `/jsonapi/taxonomy_term/*`) while leaving nodes at 50.
- Lower the effective ceiling for an expensive resource by capping requested limits below 50.
- Fetch all options for a filter/facet panel in a single call.
- Tune pagination per path with wildcard patterns rather than a global change.
- Reduce request count during a static-site-generator build step.
- Speed up a mobile app's cold start by batching reference data.
- Avoid raising the global JSON:API limit for every resource at once.
- Fetch a full menu or navigation structure in one request.
- Reduce API chatter between a headless front end and Drupal.
- Support a bulk export that reads a resource in fewer, larger pages.
- Keep the default at 50 while allowing power clients to opt into larger pages via `page[limit]`.
- Serve a Next.js / Gatsby / Nuxt data-fetch that needs >50 items per collection.
- Provide a higher ceiling only on internal/trusted integration paths.
- Match page size to a specific resource's serialisation cost and timeout budget.
- Reduce front-end pagination-loop complexity for known-small collections.
- Prototype a decoupled integration quickly without editing core's OffsetPage.
- Give one route a bespoke limit while every other JSON:API route stays capped at 50.
- Deliberately balance response size against server response-time limits, per path.
