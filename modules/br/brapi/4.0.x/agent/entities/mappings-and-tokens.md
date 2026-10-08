<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrAPI mappings & tokens (entities)

## `brapidatatype` — datatype mapping (config entity)

`src/Entity/BrapiDatatype.php`. `@ConfigEntityType` id `brapidatatype`, `admin_permission = "administer site configuration"`, access handler `BrapiDatatypeAccessController`, list builder `BrapiDatatypeListBuilder`, add/edit/delete forms. Exported keys: `id`, `uuid`, `label`, `contentType`, `contentFieldPath`, `mapping`.

- **ID format** (`BRAPI_DATATYPE_ID_REGEXP`): `{v1|v2}-{release}-{Datatype}[-{subfield...}]`, e.g. `v2-2.1-Germplasm`. `parseId()` splits it; helpers `getBrapiVersion/Release/Datatype/SubFields()`.
- **`contentType`** is `"{entity_type}:{bundle}"`; `getMappedEntityTypeId()` / `getMappedEntityBundleId()` split it.
- **`mapping`** maps each BrAPI field → `['field' => <drupal field>]`, or `'_custom'` (a JSONPath/text expression in `custom`, optionally `is_json`), or `'_submapping'` (delegates to another `brapidatatype`, via `submapping` = another mapping id or `custom`). Fields may be flagged `hidden`.
- **`getBrapiIdField()`** — the identifier field is `lcfirst(datatype).'DbId'` (special-case `listDetailsDbId` → `listDbId`).

### Data operations

- **`getBrapiData(array $parameters)`** — the read path. Maps BrAPI filter names to Drupal fields (`getDrupalMappedField()`, with singular/plural fixups), builds an entity query on the mapped storage, applies bundle + filter conditions and pagination, loads entities, and projects each into a BrAPI object array (resolving `_submapping` recursively and `_custom` JSONPath via `galbar/jsonpath` `JsonObject`). Returns `['total_count' => int, 'entities' => array]`. Complex/`_custom` filters are applied as PHP post-filters after projection. `#entity`, `#include_hidden`, `#page`, `#pageSize` are special parameter keys.
- **`saveBrapiData(array $parameters)`** — create (`#is_new`) or update. New records check the identifier isn't taken (via `getBrapiData`), set the bundle, map fields and `storage->create()`. Updates locate the entity by the mapped id field, `set()` mapped fields and `storage->save()`. Fires `hook_brapi_{datatype}_save_alter`. Throws `BrapiObjectAlreadyExistsException` / `BrapiObjectException` / `BrapiStorageException` (`src/Exception/`).
- **`deleteBrapiData(array $parameters)`** — resolves entities by mapped filters and deletes them; returns removed ids.

Access handler `BrapiDatatypeAccessController::checkAccess()`: `view` allowed for `use brapi` / `edit brapi content` / `use restricted brapi`; `update`/`delete` for `administer brapi` or `administer site configuration`.

## `brapi_token` — access token (content entity)

`src/Entity/BrapiToken.php`. `@ContentEntityType` id `brapi_token`, base table `brapi_token`. Base fields: `id`, `uuid`, `token` (string, 32), `expiration` (datetime), `user_id` (entity_reference → user).

- **`preCreate()`** sets `token = bin2hex(random_bytes(16))`, `user_id` = current user, `expiration = time() + token_default_lifetime`.
- **`getUserTokens($user, $include_expired)`** — query by `user_id`, newest expiration first, filtering to valid (`expiration > now` OR `< 0`) unless including expired; `accessCheck(FALSE)` (a token may have been created by an admin).
- **`getUserToken($user, $renew)`** — returns the latest valid token, renewing (`renew()`) or creating one if none. `renew()` resets expiration (permanent tokens `expiration < 0` are left alone).
- **`isExpired()`**, **`purgeExpiredTokens()`** (deletes expired, non-permanent tokens).

The `/brapi/token` pages (`BrapiController::tokenPage`/`newTokenPage`/`expireTokenPage`/`deleteTokenPage`) render `brapi-token.html.twig` via `brapi_preprocess_brapi_token()`, which shows the current user's tokens (all, incl. expired) and — for `administer brapi` users — every other user's unexpired tokens.

## `brapi_list`

`src/Entity/BrapiList.php` — entity backing BrAPI list objects (`/lists`, `/lists/{listDbId}`, `/lists/{listDbId}/data`). List result post-processing (flatten `data`, format dates, decode `externalReferences`) is done by `hook_brapi_call_*_v2_lists_*_result_alter` implementations in `brapi.module`. `brapi_update_9001()` (`brapi.install`) rebuilt this entity's mappings.
