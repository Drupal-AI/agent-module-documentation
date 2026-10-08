<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push & receive flow

Two sides, both provided by this module: a **push** side that normalizes a node and POSTs it, and a
**receive** side that rebuilds the entity from the payload.

## Push side

### Trigger: node actions
`Plugin\Action\PushContentQA|Stage|Prod` (`@Action type="node"`, ids `push_content_qa|stage|prod`) appear on
`/admin/content`. `execute($entity)` reads the matching `<env>_url` from config (errors if empty), gets the
entity's current `langcode`, and calls `ContentSyncBatch::startBatch([$entity->id()], $env, $langcode)`.
`access()` delegates to `$entity->access('view')`. The `system.action.push_content_*` config entities install
these actions.

### Batch: `Batch\ContentSyncBatch`
`startBatch()` builds a `BatchBuilder`, adds one `processItem($nid, $env, $langcode)` operation per node.
`processItem()` resolves `batch_content_sync.sync_service` and calls `pushToRemote()`; results collect into
`$context['results']['success'|'errors']`. `onFinish()` shows a messenger status/error summary.

### `Service\SyncService::pushToRemote($nid, $env, $langcode)`
- Loads the node, gets the requested translation (errors if missing).
- `normalizeEntityRecursive($node)` builds the payload entity array:
  - Core fields via `normalizeCoreField()`: `type`→bundle; `uid`/`revision_uid`→{uuid,name,mail}; status flags
    and timestamps cast to int; `langcode`.
  - `entity_reference_revisions` (paragraphs) → recursed.
  - `entity_reference` → for media with `field_media_image`, emits {uuid,bundle,langcode,filename,mimetype,
    **base64** of the file bytes}; other refs emit {uuid,bundle,langcode}.
  - `image` / `file` fields → {filename,mimetype,**base64**,(alt/title/width/height)} read from disk via
    `getMimeMeta()` (filename recomputed from the file's real mimetype).
  - Layout Builder: `layout_builder__layout` sections filtered; a `layout_builder__sections` array of
    `Section::toArray()` added when the section-storage manager is available.
- Wraps it as `{token, entity_type:'node', bundle, langcode, entity}`, sends headers
  `X-Access-Token: <token>`, `Content-Type/Accept: application/json`, and `POST $url` with `json` body via
  the core `http_client` (Guzzle; default TLS verification). `http_errors: true`.
- Logs the payload as type `sent` via `batch_content_sync.logger`. Returns decoded JSON or an `error` array.

### REST resources (secondary, note the bug)
`Plugin\rest\resource\PushContentQa|Stage|Prod` expose `POST /api/push-content-{qa,stage,prod}` (cookie auth,
`rest.resource.push_content_*` config). Each calls `pushToRemote($data['nid'], $env)` with **only two args**,
but `pushToRemote()` requires `$langcode` (no default) → an `ArgumentCountError`; these endpoints do not work
as written. The working path is the node actions above.

## Receive side

### Endpoints
`batch_content_sync.routing.yml` defines `POST /api/push-entity-{qa,stage,prod}` → `ReceiverController::receive`,
`_format: json`. All three are identical handlers.

### `Controller\ReceiverController::receive(Request)`
1. Token check: `$provided = $request->get('token', $request->headers->get('X-Access-Token'))`; if
   `$provided !== getConfiguredToken()` → 401. (`getConfiguredToken()` reads `access_token`.)
2. `json_decode` the body; require `entity_type`, `bundle`, `entity`.
3. Determine `uuid` and `langcode`; **auto-create the `configurable_language`** if the target lacks it.
4. If `existing_content_behavior === 'override'` and an entity with that UUID exists, load it (add the
   translation if needed) and strip `uuid/langcode/nid/vid` from the incoming fields; otherwise `create()` a
   new entity of the given bundle (in `clone` mode strip `uuid` and prefix the title with `(Clone) `).
5. Log the payload as type `received`.
6. For each field on the entity, set it by type: paragraphs rebuilt (matched by UUID or created) and saved;
   media matched by UUID or built from base64 (`createMediaFromBase64` → `public://sync_media/<filename>`);
   `image`/`file` fields built from base64 (`createImageFromBase64`→`public://sync_images/`,
   `createFileFromBase64`→`public://sync_files/`); taxonomy refs resolved/created via `getOrCreateTerm()`
   (by uuid, tid, or vid+name); everything else `set()` verbatim.
7. Owner set from `fields['uid']['uuid']` (fallback user 1); `save()`.
8. If `layout_builder__sections` present, rebuild the overrides section storage and save again.
9. Returns `{status:'ok', id:<entity id>}`, or a 400/401/500 JSON error.

Base64 file writes use `file.repository`'s `writeData(..., EXISTS_RENAME)` with the payload-supplied
`filename`; `prepareDirectory()` creates the `public://sync_*` dirs.

## Sync log
`Service\SyncLogger::log()` truncates base64 blobs (`sanitizeBase64Recursive`) then inserts a row into
`batch_content_sync_log`. `Controller\ContentSyncLogController::view()` lists the last 100 rows at
`/admin/content/sync-log` (perm `administer site configuration`) with a client-side search box;
`detail($id)` returns the stored JSON pretty-printed at `/admin/content/sync-log/{id}`.
