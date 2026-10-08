JSON:API Response Alter gives other modules a hook (`hook_jsonapi_response_alter`) and an event (`JsonApiResponseAlterEvent`) to modify the decoded JSON body of any JSON:API response just before it is sent.

---

The module is a pure extension point — it ships no default behaviour and has no config, permissions, or Drush. Its single `ResponseSubscriber` listens to the Symfony `KernelEvents::RESPONSE` event; when the current route is a JSON:API route (detected via `Routes::JSON_API_ROUTE_FLAG_KEY` / `Routes::isJsonApiRequest()`), it takes the already-rendered response content, `json_decode`s it to an array, then (a) invokes `hook_jsonapi_response_alter(&$jsonapi_response, $response)` via the module handler and (b) dispatches a `JsonApiResponseAlterEvent` carrying the same array plus the `Response` object, and finally `json_encode`s the (possibly modified) array back onto the response. If the body doesn't decode to an array it returns untouched. Because it runs at response time on the serialized output, it operates **after** JSON:API has already applied its own entity/field access filtering and serialization — implementers receive the final, access-filtered document and can add, remove, or rewrite top-level keys and nested data. This is handy for injecting computed metadata, stripping keys, or reshaping payloads for a specific decoupled client without overriding JSON:API's normalizers. Requires `jsonapi`.

---

- Add a custom top-level `meta` key (build info, feature flags, timestamps) to JSON:API responses.
- Inject a computed/aggregate field into responses without a Drupal computed field.
- Strip or rename keys a particular decoupled front end doesn't want.
- Add CORS-independent client hints or versioning info to the payload.
- Reshape the `data`/`included` structure for a legacy client's expected format.
- Append localized labels or currency-formatted values alongside raw attributes.
- Add links (e.g. canonical front-end URLs) computed from entity data.
- Tag responses with A/B-test or personalization metadata for the client.
- Redact specific attribute values for certain routes via a hook implementation.
- Merge in data from a non-entity source (config, external service) at the top level.
- Provide a single place to post-process all JSON:API output in a decoupled build.
- Subscribe with an event subscriber instead of a hook when you prefer OOP/DI.
- Add debug metadata (query counts, cache info) to responses in non-production environments.
- Normalize error/response envelopes across collections and individual resources.
- Inject aggregate counts (e.g. total unread) into a user resource response.
- Post-filter `included` resources for a specific client contract.
- Attach signed download URLs or tokens computed at request time.
- Add a schema/version marker so clients can negotiate response shape.
- Rewrite absolute/relative URLs in the response for a proxy setup.
- Centralize response transformations that would otherwise need custom normalizers.
