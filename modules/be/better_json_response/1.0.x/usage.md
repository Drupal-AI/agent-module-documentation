Better Json Response ships a `BetterJsonResponse` class (a drop-in `JsonResponse`/`CacheableJsonResponse` replacement) that lets a custom controller embed JSON:API-serialized entities and toggle response caching from the admin UI.

---

Better Json Response is a small developer/decoupled utility for Drupal 10/11/12 that improves on core's Symfony `JsonResponse` and `CacheableJsonResponse` for custom (non-JSON:API-route) controllers. A controller returns a `Drupal\better_json_response\BetterJsonResponse` whose data array may contain `Drupal\jsonapi\ResourceResponse` objects (e.g. built from entities). A response event subscriber (`SubResourceResponseSubscriber`, running at priority 129 on the `kernel.response` event, after core's JSON:API `ResourceResponseSubscriber`) walks the data array recursively, renders each embedded `ResourceResponse` through the `jsonapi.serializer` in the `api_json` format, replaces it with the decoded JSON:API document, and aggregates cacheability metadata. The response is then re-emitted as a `CacheableJsonResponse` (carrying the collected cache tags plus a `config:better_json_reponse.settings` tag) — or, when the site-wide "Deactivate cache" checkbox is on, as a plain `JsonResponse`, which is convenient for debugging without repeatedly clearing caches. It depends only on core `jsonapi` and requires no permissions, entities, or plugins of its own beyond one admin settings form.

---

- Return JSON:API-formatted entity data from a custom (non-JSON:API-generated) route/controller.
- Embed one or more entities inside an otherwise hand-built JSON payload for a decoupled/headless front end.
- Build a bespoke aggregation endpoint that mixes scalar values and JSON:API entity documents in one response.
- Include related entities (JSON:API `include`s) inside a custom response's serialized entity output.
- Use `BetterJsonResponse` as a drop-in replacement for `CacheableJsonResponse` in existing controllers.
- Attach cacheability metadata (cache tags/contexts/max-age) to a custom JSON response via `CacheableResponseTrait`.
- Let the response subscriber automatically collect and merge cache metadata from embedded entities so you don't wire it up by hand.
- Toggle response caching off site-wide from `admin/config/development/better_json_response` while debugging a headless endpoint.
- Re-enable caching in production with a single checkbox once debugging is done.
- Avoid the usual "swap CacheableJsonResponse for JsonResponse then swap back" edit cycle during development.
- Serve entity data as JSON:API without registering a JSON:API resource route.
- Keep a custom controller's status code and headers while upgrading its body to JSON:API format.
- Inspect the pre-serialization payload via `getOriginalData()` when writing or testing a controller.
- Set or reset the response payload after construction with `setData()` (keeps `originalData` in sync).
- Provide a caching JSON endpoint for a mobile app or SPA that consumes JSON:API entity structures.
- Ensure the JSON response is invalidated when the module's own config changes (via the `config:better_json_reponse.settings` cache tag).
- Standardize how a team returns entity data from custom API controllers in a decoupled project.
- Deliver nested/tree-shaped payloads where entities appear at arbitrary depth in the data array (recursive transformation).
- Combine JSON:API entity serialization with core render caching for high-traffic headless read endpoints.
- Give site builders a back-office switch to disable API response caching without a code deploy.
