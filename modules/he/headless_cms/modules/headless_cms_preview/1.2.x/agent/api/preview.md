<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview — token flow, JSON:API routes, access & events

## End-to-end flow

1. Editor clicks **Save Preview** on an enabled node bundle. The unsaved node is stored in a private
   tempstore keyed by uuid under the editor's account; a preview **token** is generated and shown
   with per-consumer preview URLs (via `ConsumerHeadlessPreviewManager`).
2. The frontend calls the JSON:API preview route (or the standard individual route) and sends the
   token in the **`X-Headless-Preview-Token`** header.
3. `PreviewTokenNegotiator::negotiateFromRequest()` decodes the header into a `PreviewToken` DTO
   (ownerUid, entityUuid, entityId, entityTypeId, entityTypeBundle) and stashes it on the request.
4. Access is resolved (auth provider + `hook_entity_access`) and the draft is returned, uncached.

## Preview token (`src/PreviewToken/`)

- `PreviewTokenManager` (interface `PreviewTokenManagerInterface`, service
  `headless_cms_preview.preview_token_manager`) — `encode(ownerUid, entityUuid, entityTypeId,
  entityBundleId)` and `decode(tokenValue): ?PreviewToken`. When an **Encrypt profile** is selected
  in `headless_cms_preview.settings`, the token is encrypted/decrypted with the `encrypt` service;
  otherwise a plain encoding is used. `decode()` also loads the entity by uuid to fill `entityId`,
  and logs + returns NULL on failure.
- `PreviewTokenNegotiator` — `requestHasPreviewToken()` (cheap header check) and
  `negotiateFromRequest()` (decode). Header constant `X-Headless-Preview-Token`. The token manager
  is injected as a **service closure** (`AutowireServiceClosure`) so entity services are not pulled
  into the HTTP-kernel construction graph (the negotiator is a dependency of the page-cache request
  policy).

## JSON:API preview routes (`src/Routing/Routes.php`)

A `hook_routing` route-callback (extends `jsonapi\Routing\Routes`) registers, **per node resource
type**, a GET route:

```
/{jsonapi_base}/{node-path}/{node_preview}/preview
```

- `_node_preview_access` requirement on `{node_preview}`.
- Controller `Controller\JsonApiEntityResource::getIndividualNodePreview` (decorates
  `jsonapi.entity_resource`), `no_cache: TRUE`, all auth providers enabled, `api_json` format only.
- `{node_preview}` is upcast by `ParamConverter\HeadlessNodePreviewConverter`: it requires a
  negotiated token whose `entityUuid` equals the route uuid, loads the token owner, and returns the
  **unsaved** entity from that owner's `node_preview` private tempstore (via
  `TempStore\PreviewTempStoreFactory` + `Session\AccountProxyWrapper`). On any mismatch it triggers
  the page-cache kill switch and returns NULL.

The controller merges cache-max-age 0, runs the JSON:API access check on the resource object, and
resolves includes through `JsonApi\PreviewIncludeResolver` (which returns the referenced entities'
**preview** values, cache-max-age 0). The standard individual resource route can also serve the
stored (draft) entity when a matching token is presented.

## Authentication & access

- `Authentication\Provider\PreviewToken` (provider id `headless_preview_token`, priority 110):
  `applies()` only when a token is present AND the current route is the JSON:API
  `…individual.preview` or `…individual` route for the token's entity type/bundle AND the route's
  entity uuid matches the token; `authenticate()` returns the **owner user** named in the token
  (`ownerUid`), so the preview request runs as that user.
- `headless_cms_preview_entity_access()` (`.module`): for the negotiated token, returns
  `AccessResult::allowed()` (cache-max-age 0) for `view`, `update` and `view all revisions` on the
  entity whose type+uuid match the token, and for child content entities whose `parent_type` /
  `parent_id` fields match the token's entity — so referenced paragraphs resolve. Otherwise neutral.
- `PageCache\RequestPolicy\HeadlessPreviewRequestPolicy::check()` returns `DENY` whenever a
  preview-token header is present, keeping preview responses out of the page cache.

## Node revision overview

`Routing\RouteSubscriber` repoints `entity.node.version_history` to
`Controller\HeadlessCmsPreviewNodeController::revisionOverview`, which extends core's `NodeController`
to add a **Preview** column with per-consumer revision links (tokens built via
`PreviewTokenManager::encode()` + `ConsumerHeadlessPreviewManager::getRevisionUrlsForAllConsumers()`).

## Event

`headless_cms_preview.preview_updated` — `Event\HeadlessPreviewUpdatedEvent(entity, account)`,
dispatched from `_headless_cms_preview_form_save_preview_submit()` after a Save Preview. The
Preview - NATS submodule subscribes to it to publish a live-reload message.

## Operating notes

- Configure an **Encrypt profile** on the settings page for preview tokens on production sites.
- Preview URLs/tokens are shown to editors and passed to frontends; treat them like credentials for
  the draft they unlock (share over TLS, avoid logging).
