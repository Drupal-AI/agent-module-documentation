<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: manager service, access mechanism, storage

## Service `editorial_access_manager.manager`

Class `Drupal\editorial_access_manager\EditorialAccessManager`. Public methods:

| Method | Returns | Purpose |
|--------|---------|---------|
| `isSupported(string $entity_type_id)` | bool | Entity type enabled in `editorial_access_manager.settings`. |
| `getSupportedEntityTypesList()` | `string[]` | Enabled entity type ids. |
| `getSupportedEntityTypes()` | `EntityTypeInterface[]` | Keyed by id. |
| `getEntityAssigneesPerLanguage($entity, string $langcode)` | `UserInterface[]` | Assignees for one entity + language. |
| `getEntityAssigneesGroupedByLanguage($entity)` | `array` | `langcode => uid[]`. |
| `setEntityAssignees($entity, string $langcode, array $assignees)` | void | Replace assignees for entity + language (transactional; also stores referenced-entity access). |
| `clearEntityAssignees($entity, string $langcode, bool $clear_references = FALSE)` | void | Remove assignees for entity + language. |
| `getEntityFromRouteParameters()` | `?EntityInterface` | Loads from `entity_type_id`/`entity_id` route params. |
| `userIsAssignable($entity, $account)` | bool | Bundle `enabled` **and** account holds `edit assigned entity`/`edit assigned <type>`. |
| `getEntityAccess($entity, $operation, $account, $language)` | `AccessResultInterface` | Access decision used by `hook_entity_access` (allowed or neutral). |
| `getTranslationAccess($entity, $account, $language)` | bool | Assignable + assignee at a language (or via a referencing parent). |
| `getTranslationOverviewAccess($entity, $account)` | bool | Assignable + assignee in any language. |
| `accessCheckAssigneeParents($entity, $account, callable $cb, bool $obj = FALSE)` | bool/AccessResult | Runs `$cb` against parents recorded in `editorial_access_references`. |
| `recalculateEntityAssignees($entity)` | void | Re-sync assignees + references after an entity save. |
| `recalculateNodeGrants($node)` | void | Re-acquire and write node grants for one node. |

The service is constructed with `@config.factory`, `@entity_type.manager`, `@database`,
`@current_route_match`, `@node.grant_storage`, `@logger.channel.editorial_access_manager`.

## How access is granted (three cooperating mechanisms)

1. **Node grants** (nodes only): `hook_node_access_records()` writes, for each assignee of a node, a grant
   `{realm: editorial_access_manager_assignees, gid: <assignee uid>, grant_view: 1, grant_update: 1,
   grant_delete: 0, langcode}`. `hook_node_grants()` returns realm `editorial_access_manager_assignees =>
   [account uid]` for accounts holding `edit assigned <type>`. Grants are recomputed on assignment save
   and on reassign (`recalculateNodeGrants`, `node_access_rebuild`).
2. **`hook_entity_access()`** (all supported types) → `EditorialAccessManager::getEntityAccess()`: returns
   `allowed()` (never `forbidden()`) for `view`/`update` on assigned content of an enabled bundle, so it
   only widens core access. Also grants access to referenced entities via `editorial_access_references`.
3. **Translation**: `hook_entity_type_alter()` swaps the content-translation handler for
   `EditorialAccessManagerTranslationHandler` on supported types and sets the translation
   `access_callback` to `editorial_access_manager_translate_access`, so assignees may add/edit
   translations for their assigned languages. Route/tab wiring is added by
   `EditorialAccessManagerRouteSubscriber` and `ContentTranslationController`/`EditorialAccessManagerController`.

## Storage (two tables, from `hook_schema()`)

- `editorial_access` — one row per assignment: `date`, `entity_type`, `entity_id`, `langcode`, `uid`
  (PK: entity_type, entity_id, langcode, uid).
- `editorial_access_references` — inherited access to referenced entities: `entity_type`, `entity_id`,
  `parent_entity_type`, `parent_entity_id`, `uid`.

Cleanup hooks: `hook_entity_delete` removes rows for a deleted entity; `hook_user_delete` removes rows for
a deleted user (node-access rows are cleaned on the next content update).

## Entity-reference selection plugin

`AssignableUserSelection` (id `editorial_access_manager_assignable_user`, group
`editorial_access_manager`, extends core `UserSelection`) restricts the assignment autocomplete to users
whose roles carry the relevant `edit assigned …` permission. Selection setting
`editorial_content_entity_type` is the target entity type id (or `all`).

## Routes

| Route | Path | Access |
|-------|------|--------|
| `editorial_access_manager.settings` | `/admin/config/content/editorial-access-manager` | `administer site configuration` |
| `editorial_access_manager.editorial_assignment` | `/editorial-access-manager/editorial-assignment/{entity_type_id}/{entity_id}/{langcode}` | `access content` + `_editorial_access_manager_assign_access` |
| `editorial_access_manager.assigned_content` | `/admin/content/assigned` | `_editorial_access_manager_assigned_content_access` |
| `editorial_access_manager.reassign` | `/admin/content/reassign` | `reassign assigned entities` |
| `editorial_access_manager.reassign_confirm` | `/admin/content/reassign/{assignee_old}/{assignee_new}/confirm` | `reassign assigned entities` |
| `entity.<type>.editorial_access_management` (dynamic) | `<canonical>/editorial-access` | `_entity_access: <type>.view` + `_editorial_access_manager_assign_access` |
