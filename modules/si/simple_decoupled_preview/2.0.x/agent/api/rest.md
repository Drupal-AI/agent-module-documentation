# REST endpoint, logger service and the log entity (API)

## REST resource — `/api/preview/{uuid}`

Plugin `Drupal\simple_decoupled_preview\Plugin\rest\resource\PreviewResource`
(`@RestResource(id = "simple_decoupled_preview_json")`, canonical URI `/api/preview/{uuid}`, GET).
This is the endpoint a decoupled front end calls to retrieve the stored preview JSON produced when
the editor clicked Preview.

- Must be enabled in the REST UI (method GET, format `json`, auth providers); gated by the generated
  permission `restful get simple_decoupled_preview_json`. Disabled/ungranted by default.
- Request: `GET /api/preview/{uuid}?uid={uid}&langcode={langcode}` where `{uuid}` is the previewed
  **node's** UUID (stored on the log entity as `entity_uuid`). `langcode` defaults to `en`; `uid` is
  **required** (400 if missing).
- `get()` loads the `preview_log_entity` via `loadByProperties(['entity_uuid'=>$uuid,
  'langcode'=>$langcode,'uid'=>$uid])`, then returns `json_decode($entity->get('json')->value, TRUE)`
  as a `ModifiedResourceResponse`. The stored `json` is the full JSON:API document
  (`{data, included?}`) generated at preview time.
- Error responses: 400 with `{error:{message}}` for empty uuid, missing `uid`, or no matching entity;
  `NotFoundHttpException` if the loaded row is not a `PreviewLogEntityInterface`.

The stored document is the JSON:API `individual` representation (see
[jsonapi-preview.md](jsonapi-preview.md) for how it is generated). Response shape:

```json
{ "data": { "type": "node--article", "id": "<uuid>", "attributes": { … }, "relationships": { … } },
  "included": [ … ] }
```

## Preview logger service — `simple_decoupled_preview.logger`

`Drupal\simple_decoupled_preview\PreviewLogger` (args: `config.factory`, `entity_type.manager`,
`entity.repository`, `simple_decoupled_preview.entity_to_jsonapi_preview`).

```php
$logger = \Drupal::service('simple_decoupled_preview.logger');
$logger->logEntity($node);   // NodeInterface (the unsaved preview entity)
```

- `logEntity(NodeInterface $entity)` — deletes any existing log for the same `entity_uuid` + current
  `uid` + langcode (so each user's preview of a node/language is overwritten, not accumulated), calls
  `getJson()`, and — if non-empty — creates a `preview_log_entity` with `entity_uuid`, `title`,
  `type`, `bundle`, `langcode`, `published` (`isPublished()` if available), `json` (JSON-encoded).
- `getJson(ContentEntityInterface $entity): ?array` — resolves the JSON:API resource type; reads the
  bundle's `includes` config, keeps only paths validated by
  `EntityToJsonApiPreview::isValidInclude()`, then calls
  `EntityToJsonApiPreview::normalize($entity, $included)`. Returns `['data'=>…, 'included'?=>…]`, or
  `NULL` on `RouteNotFoundException`.
- `deleteLoggedEntity(string $uuid, int $uid, string $langcode='en')` — deletes matching rows
  (`accessCheck(FALSE)`).
- `deleteExpiredLoggedEntities(int $timestamp)` — deletes up to 50 rows with `created < $timestamp`
  (`accessCheck(FALSE)`); called from `hook_cron`.

## Entity — `preview_log_entity`

`Drupal\simple_decoupled_preview\Entity\PreviewLogEntity` (ContentEntityType, base table
`preview_log_entity`, not translatable, `admin_permission = administer preview log entity entities`).

| Field | Type | Notes |
|---|---|---|
| `id` | int | Entity id / label. |
| `uuid` | uuid | Log entity's own uuid (entity key). |
| `entity_uuid` | string(50) | UUID of the previewed node (the `{uuid}` in the REST path). |
| `title` | string(250) | Previewed node title. |
| `type` | string(50) | Entity type id (`node`). |
| `bundle` | string(50) | Node bundle. |
| `langcode` | language | Entity key. |
| `published`/`status` | boolean | Whether the previewed node was published. |
| `json` | string_long | The serialised JSON:API document returned verbatim by the REST resource. |
| `uid` | entity_reference→user | "Previewed by"; entity key; default = current user. |
| `created` | created | Creation timestamp (used by cron expiry). |

Handlers: access `PreviewLogEntityAccessControlHandler`, list builder `PreviewLogEntityListBuilder`
(admin list at `simple_decoupled_preview.previews_log`), views data `PreviewLogEntityViewsData`.

Because it is a content entity, JSON:API also auto-exposes it at
`/jsonapi/preview_log_entity/preview_log_entity` (collection + individual, and POST/PATCH/DELETE);
`hook_jsonapi_preview_log_entity_filter_access` returns `allowed` for all filter operations
(AMONG_ALL / PUBLISHED / OWN).

## Permissions & access

- Log-entity operations (admin list, JSON:API resource, entity CRUD) go through
  `PreviewLogEntityAccessControlHandler`: view → `view preview log entity entities`,
  update → `edit …`, delete → `delete …`, create → `add …`.
  `administer preview log entity entities` is the admin permission and gates the admin log list route.
- The `PreviewResource` REST endpoint is gated by the REST module's generated resource permission
  `restful get simple_decoupled_preview_json` (assign it to the role your front end authenticates as,
  and choose the auth providers in the REST UI). It looks the row up by
  `entity_uuid` + `langcode` + `uid` and returns the stored `json`.
