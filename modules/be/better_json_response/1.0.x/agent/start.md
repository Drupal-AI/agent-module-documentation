<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Json Response (better_json_response) — agent index

A developer/decoupled utility that improves core's Symfony `JsonResponse`/`CacheableJsonResponse`
for **custom controllers**: return entities in **JSON:API format** and toggle response caching
from the back office. Package `AB`. Depends only on core **`jsonapi`**. Core requirement
`^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.1.

- **The response class, the event subscriber, how to return JSON:API from a controller** →
  [api/better-json-response.md](api/better-json-response.md)
- **The one admin setting (deactivate cache) and its config object** →
  [config/settings.md](config/settings.md)

## What it actually provides (from source)

- **Class `BetterJsonResponse`** (`src/BetterJsonResponse.php`) — extends Symfony
  `JsonResponse`, implements `CacheableResponseInterface` via `CacheableResponseTrait`. Keeps the
  pre-serialization `originalData` (`getOriginalData()`), overrides `setData()` to keep it in
  sync, and adds `isCacheabilityDefined()`. This is what a custom controller returns.
- **Event subscriber `SubResourceResponseSubscriber`** (`src/EventSubscriber/…`, service id
  `ogf_jsonapi.subscriber.sub_resource_response`) — extends core JSON:API
  `ResourceResponseSubscriber`. Listens on `kernel.response` at priority **129**; on any
  `BetterJsonResponse` whose data is an array it recursively finds embedded
  `jsonapi\ResourceResponse` objects, serializes each via `@jsonapi.serializer` (`api_json`),
  and swaps in the decoded JSON:API document. Re-emits as `CacheableJsonResponse` (adds a
  `config:better_json_reponse.settings` cache tag) or a plain `JsonResponse` when caching is
  deactivated.
- **Settings form `BetterJsonResponseConfigForm`** (`ConfigFormBase`) at
  `admin/config/development/better_json_response` (route `better_json_response.form.config`,
  permission core **`administer site configuration`**), one checkbox `deactivate_cache`, config
  object **`better_json_reponse.settings`** (note the misspelled machine name — no "s" in
  "reponse").

## What it does NOT provide

- No permissions of its own (`*.permissions.yml` absent — reuses core `administer site
  configuration`). No entities, no field/plugin types, no Drush, no libraries.
- No `config/schema/` — only `config/install/better_json_reponse.settings.yml`
  (`deactivate_cache: 0`). `hook_install()` sets module weight to 1 so the subscriber orders
  after JSON:API.
- No routes that return content data — the only route is the admin config form. It never fetches
  a request-supplied URL, makes no external HTTP calls, and only serializes entities you hand it
  through the standard JSON:API serializer (which enforces JSON:API entity access).
