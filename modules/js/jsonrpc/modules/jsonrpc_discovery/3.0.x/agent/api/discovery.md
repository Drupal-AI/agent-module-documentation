# Discovery endpoints

Controller `Drupal\jsonrpc_discovery\Controller\DiscoveryController`.

## Routes

| Route | Path | Method | Auth | Permission |
|---|---|---|---|---|
| `jsonrpc.method_collection` | `/jsonrpc/methods` | GET | cookie, basic_auth, oauth2 | `use jsonrpc services` |
| `jsonrpc.method_resource` | `/jsonrpc/methods/{method_id}` | GET | cookie, basic_auth, oauth2 | `use jsonrpc services` |

(Discovery hard-codes its `_auth` list, unlike the main `/jsonrpc` route whose auth comes from config.)

## Behavior

- `methods()` → `{ "data": [<method definitions>], "links": { "self": "<url>" } }`. Serialized with
  `DefinitionNormalizer::DEPTH_KEY => 0`.
- `method($method_id)` → the single method's serialized definition, or a `CacheableNotFoundHttpException` (404)
  when the id is not in the available set (cache context `url.path`).
- `getAvailableMethods()` = `handler->supportedMethods()` filtered by `$method->access('view', NULL, TRUE)`
  (each access result added as a cacheable dependency), so the list is per-user and reflects the same permissions
  that gate execution. `MethodInterface::access('view')` delegates to the `execute` access check.

## Serialization

`DefinitionNormalizer` (service `serializer.normalizer.jsonrpc_definition`, tag `normalizer`, needs core
`serialization`) turns each `MethodInterface`/definition into the JSON shape (id, usage, params, output, access,
etc.). Responses are `CacheableJsonResponse` with the aggregated cacheability attached.

Use it to build self-adapting clients: fetch the collection, read each method's params/output, then POST calls to
`/jsonrpc`.
