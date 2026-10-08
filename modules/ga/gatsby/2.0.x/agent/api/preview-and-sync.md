# Gatsby — preview delivery, Fastbuilds sync, permissions, Drush

## How a content change reaches Gatsby

`gatsby.module` implements `hook_entity_insert/update/delete`. Each:
1. Gets `gatsby.preview` (`GatsbyPreview`) and skips unless `isSupportedEntity($entity)` — i.e. a
   `ContentEntityInterface` whose type is in `supported_entity_types` and is not `gatsby_log_entity`.
2. If `build_published` is on, non-node entities are skipped entirely.
3. File entities: temporary files are skipped; `private://` files skipped unless `publish_private_files`.
4. Calls `GatsbyPreview::gatsbyPreparePreviewData()` (always, for preview) and
   `gatsbyPrepareBuildData()` (only for **published** default-revision entities, plus `redirect`; an
   unpublish of a previously-published node queues a build `delete`).
5. Registers a shutdown fn `_gatsby_update()` → `GatsbyPreview::gatsbyUpdate()` which POSTs to each
   queued webhook via `triggerRefresh()`.

`GatsbyPreview` service (`@gatsby.preview`), args `@http_client, @config.factory, @entity_type.manager,
@logger.factory, @gatsby.logger`. Key methods:
- `gatsbyPreparePreviewData($entity, $action)` — logs a `preview` record + queues `preview_callback_url`.
- `gatsbyPrepareBuildData($entity, $action)` — logs a `build` record + queues `incrementalbuild_url`.
- `triggerRefresh($url, $path)` — `POST` with **1s timeout**, fire-and-forget; splits comma URLs;
   adds `x-gatsby-cloud-data-source` header if `custom_source_plugin` set. `ConnectException` swallowed.
- `updateData()` / static `$updateData` — dedupes so one request per endpoint per page load.

## Fastbuilds log entity + sync endpoint

`GatsbyEntityLogger` (`@gatsby.logger`) writes `gatsby_log_entity` records. `logEntity($entity,$action,
$type)`: deletes any prior record for the same uuid/langcode/type, builds the JSON via
`EntityToJsonApi::normalize()` (recursive over relationships; honors `prevent_selfreferenced_entities`
and `supported_entity_types`), then stores fields `entity_uuid, title, entity, bundle, langcode, action,
preview (bool), published (bool), json`. Paragraphs are not logged on non-delete.

Route `gatsby.gatsby_fastbuilds_sync` = `/gatsby-fastbuilds/sync/{last_fetch}` (`last_fetch` digits
only), `_auth: [basic_auth, cookie, key_auth]`, permission `sync gatsby fastbuild log entities`.
`GatsbyFastbuildsController::sync()` returns `-1` status if `last_fetch < gatsby.last_logtime` (state),
else `GatsbyEntityLogger::getSync($last_fetch)`:
- `getSync()` reads `\Drupal::currentUser()`; if the user has `sync gatsby fastbuild preview log
  entities` it returns **preview** records, otherwise **build** records (`preview` column filter).
- Query uses `->accessCheck(FALSE)`; returns each record's stored `json` decoded, plus a `timestamp`.

Second admin list route `gatsby.gatsby_fastbuilds_log` = `/admin/config/services/gatsby/fastbuilds/logs`
(`_entity_list: gatsby_log_entity`, permission `administer gatsby log entity entities`).

## Permissions (`gatsby.permissions.yml`)

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer gatsby` | true | Settings form. |
| `administer gatsby log entity entities` | true | Log admin/list. |
| `add` / `edit` / `delete` / `view gatsby log entity entities` | — | Log entity CRUD (via `GatsbyLogEntityAccessControlHandler`). |
| `sync gatsby fastbuild log entities` | — | The sync endpoint (build records). |
| `sync gatsby fastbuild preview log entities` | — | Makes the sync endpoint return **preview/draft** records. |

## Drush / cron

- `drush gatsby:logs:purge` (aliases `gatsdel`, `gatsby_fastbuilds:delete`) →
  `GatsbyEntityLogger::deleteExpiredLoggedEntities(time())` (purges all) and resets
  `gatsby.last_logtime`. Class `GatsbyFastbuildsCommands` (`drush.services.yml`). A legacy Drush 8
  `gatsby.drush.inc` mirrors it.
- `hook_cron` prunes expired log entities when `delete_log_entities` is on, in batches of
  `number_items_delete`, and updates `gatsby.last_logtime` to the oldest remaining record.
