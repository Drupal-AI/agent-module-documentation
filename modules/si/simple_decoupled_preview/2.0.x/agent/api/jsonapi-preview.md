# JSON:API preview submodule (API)

`simple_decoupled_preview_jsonapi` (name "Simple Decoupled Preview JSON:API Node Preview", package
Web services, deps `node`, `jsonapi`). Enabled as a dependency of the parent module. It exposes a
live per-node preview on JSON:API and provides the serialisation service the parent's logger uses.
There is no separate doc directory for it — it is documented here.

## Dynamic preview routes — `Routing\Routes::routes()`

`simple_decoupled_preview_jsonapi.routing.yml` registers a `route_callbacks` entry
`\Drupal\simple_decoupled_preview_jsonapi\Routing\Routes::routes` (class extends
`\Drupal\jsonapi\Routing\Routes`). For every JSON:API resource type whose entity type is `node` it
adds one route:

- Name: `jsonapi.node--{bundle}.individual.preview` (via `getRouteName($resource_type,
  'individual.preview')`).
- Path: `/{jsonapi_base_path}/node/{bundle}/{node_preview}/preview` (GET).
- Controller: `simple_decoupled_preview_jsonapi.entity_resource:getIndividualNodePreview`.
- Requirement `_node_preview_access: '{node_preview}'` (core node preview access check).
- Param `node_preview` uses converter type `node_preview` — core's `NodePreviewConverter`, which
  loads the previewed node from **the current user's private tempstore** (`node_preview` collection),
  not from the database. So this live route only ever returns a preview the requesting user just
  created, and only if they pass node create/update access.
- Routes also get `_content_type_format: api_json`, `_format: api_json`, all auth providers
  (`_auth`), and the JSON:API route flag.

## Controller — `Controller\EntityResource`

`Drupal\simple_decoupled_preview_jsonapi\Controller\EntityResource` extends
`Drupal\jsonapi\Controller\EntityResource`; service
`simple_decoupled_preview_jsonapi.entity_resource` (`parent: jsonapi.entity_resource`).

- `getIndividualNodePreview(NodeInterface $node_preview, Request $request)` — sets
  `mergeCacheMaxAge(0)` (never cache previews), runs the node through
  `entityAccessChecker->getAccessCheckedResourceObject()` (throws `EntityAccessDeniedHttpException`
  on denial), wraps it as `ResourceObjectData`, and returns `buildWrappedResponse(...)` with includes
  resolved in preview mode.
- `getIncludes(Request $request, $data, bool $in_preview = FALSE)` — overrides core to pass the
  `$in_preview` flag into the custom include resolver
  (`simple_decoupled_preview_jsonapi.include_resolver`) when an `?include=` query is present.

## Include resolver — `IncludeResolver`

`Drupal\simple_decoupled_preview_jsonapi\IncludeResolver` extends `jsonapi\IncludeResolver`; service
`simple_decoupled_preview_jsonapi.include_resolver` overrides `jsonapi.include_resolver` (args
`entity_type.manager`, `jsonapi.entity_access_checker`). Adds an `$in_preview` parameter to
`resolve()` / `resolveIncludeTree()`: in preview mode it resolves related entities from the
**already-loaded** field values (`$field_item->entity`) instead of reloading from the database (so
unsaved referenced entities are included), sets `mergeCacheMaxAge(0)` on them, and still runs each
through `entityAccessChecker->getAccessCheckedResourceObject()` and per-field `access('view')` checks
(label-only / access-denied relationships are represented as `EntityAccessDeniedHttpException`, as in
core).

## Normalization cacher — `EventSubscriber\ResourceObjectNormalizationCacher`

Overrides core service `jsonapi.normalization_cacher`. `generateLookupRenderArray()` copies the
resource object's `getCacheMaxAge()` onto `#cache['max-age']`, so preview normalizations
(max-age 0) are not written to the JSON:API normalization cache.

## Serialisation service — `EntityToJsonApiPreview`

`Drupal\simple_decoupled_preview_jsonapi\EntityToJsonApiPreview` (service
`simple_decoupled_preview.entity_to_jsonapi_preview`; args `http_kernel.basic`,
`jsonapi.resource_type.repository`, `session`, `request_stack`). This is what the parent
`PreviewLogger::getJson()` calls to turn the draft node into JSON.

- `serialize(EntityInterface $entity, array $includes = [])` — builds the JSON:API `individual` URL
  for the entity, appends `/preview`, and issues a **sub-request** through the HTTP kernel carrying
  the current request's cookies, server vars and session (i.e. the editor's authenticated context),
  then returns the response body. Because the sub-request hits the preview route above, the JSON is
  generated with the previewing editor's access rights.
- `normalize(EntityInterface $entity, array $includes = [])` — `Json::decode(serialize(...))`.
- `getResourceType(string $type, string $bundle): ResourceType`.
- `isValidInclude(ResourceType $resource_type, array $path_parts): bool` — recursively validates an
  include path against the resource type's public field names / relatable resource types; used by the
  settings form validator and by `getJson()`.
