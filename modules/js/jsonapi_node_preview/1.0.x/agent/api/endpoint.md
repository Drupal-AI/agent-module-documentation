<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The JSON:API node-preview endpoint

## Route

For every JSON:API node resource, a preview route is generated (`Routes::routes`, extends
`\Drupal\jsonapi\Routing\Routes`):

```
GET  {jsonapi_base_path}/{node_resource_path}/{node_preview}/preview
# e.g.  GET /jsonapi/node/article/1f8b435a-0026-4628-93f3-38ae7353ffbb/preview
```

- `{node_preview}` is the node **UUID** (the "8-4-4-4-12" id from core's preview URL
  `/node/preview/{uuid}/{view_mode}`).
- Controller: `jsonapi_node_preview.entity_resource:getIndividualNodePreview`.
- Method: `GET` only. Requires the `Accept: application/vnd.api+json` media type / `api_json` format.
- All available authentication providers are enabled on the route (`_auth`).
- Supports standard JSON:API params: `?fields[...]`, `?include=...`, etc.

## Workflow

1. An editor edits a node and clicks **Preview** (core writes the unsaved node to their private
   `node_preview` tempstore, keyed by the user's session).
2. The client grabs the UUID from the resulting preview URL.
3. The client requests `…/{UUID}/preview` over JSON:API and receives the previewed (unsaved) node.

## Access model (why it is not an unpublished-content leak)

Two independent checks gate every response — a low-privilege or anonymous consumer cannot read draft
content they shouldn't:

1. **Param conversion** — the `node_preview` converter (Drupal core) loads the node **from the current
   user's own private tempstore**. A UUID that the caller has not personally previewed in this session
   is not found → JSON:API `404`. There is no path to an arbitrary stored node.
2. **`_node_preview_access`** (core `NodePreviewAccessCheck`) — requires create/update access to that
   node for the account.
3. **Field-level access** — the controller runs
   `entityAccessChecker->getAccessCheckedResourceObject($node_preview)` and throws
   `EntityAccessDeniedHttpException` if view access is denied, and access-checks each field, exactly as
   normal JSON:API does.

So the endpoint only ever returns a preview the caller both created (in their session) and is allowed to
view. Responses are uncacheable (`mergeCacheMaxAge(0)`).

## Overridden services (implementation detail)

The module swaps three internal JSON:API services purely to add a preview-aware `$in_preview` flag:

- `jsonapi.entity_resource` → `Controller\EntityResource` (adds `getIndividualNodePreview`, overrides
  `getIncludes()` with `$in_preview`).
- `jsonapi.include_resolver` → `IncludeResolver` (threads `$in_preview` through include-tree
  resolution; kept "in sync" with core's `@internal` methods).
- `jsonapi.normalization_cacher` → `ResourceObjectNormalizationCacher`.

These carry no behavior change for non-preview requests; they only ensure `?include=` related entities
resolve in preview mode.
