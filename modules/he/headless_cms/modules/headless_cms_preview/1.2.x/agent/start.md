<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS - Preview (headless_cms_preview) — agent index

Previews **unpublished node content and revisions** in a decoupled frontend over **JSON:API**,
using per-render **preview tokens**. Version **1.2.x**. Core `^10.3 || ^11`. Depends on
`drupal:node`, `drupal:jsonapi`, `headless_cms:headless_cms`, `consumers:consumers`. Optional:
`drupal/encrypt` (for token encryption).

## What it provides

- **Preview token system** (`src/PreviewToken/`): `PreviewTokenManager` (`encode()`/`decode()`),
  `PreviewToken` DTO (ownerUid, entityUuid, entityId, entityTypeId, entityTypeBundle),
  `PreviewTokenNegotiator` (reads header `X-Headless-Preview-Token`, service closure to avoid early
  container graph).
- **Dynamic JSON:API routes** (`src/Routing/Routes.php`, `hook_routing` callback): one
  `/{jsonapi-path}/{node_preview}/preview` GET route per node resource type, controller
  `Controller\JsonApiEntityResource::getIndividualNodePreview`, param `node_preview` upcast by
  `ParamConverter\HeadlessNodePreviewConverter` from the private tempstore.
- **Authentication provider** `Authentication\Provider\PreviewToken` (provider id
  `headless_preview_token`, priority 110) — authenticates the request as the token's owner user,
  only for the matching JSON:API preview/individual route + uuid.
- **Access** `headless_cms_preview_entity_access()` (`.module`) — grants view/update/"view all
  revisions" on the entity that matches the negotiated token (and matching child entities).
- **JSON:API include resolver** `JsonApi\PreviewIncludeResolver` — resolves referenced entities from
  the preview data (decorates `jsonapi.entity_resource`).
- **Page-cache policy** `PageCache\RequestPolicy\HeadlessPreviewRequestPolicy` — DENY page cache
  when a preview-token header is present.
- **Consumer base fields** (`headless_cms_preview.basefields.inc`): `headless_cms_preview_url`,
  `headless_cms_revision_url` (URL templates with `[preview:*]` placeholders).
- **Consumer URL builder** `ConsumerHeadlessPreviewManager` (per-consumer preview/revision URLs).
- **Settings form** `Form\HeadlessCmsPreviewSettingsForm` (config `headless_cms_preview.settings`:
  `enabled_bundles`, `encryption_profile`).
- **Node revision overview** override `Controller\HeadlessCmsPreviewNodeController` (adds preview
  links), `Routing\RouteSubscriber`.
- **Form integration** (`.module`): Save Preview button + preview-URL block on enabled node forms;
  dispatches `Event\HeadlessPreviewUpdatedEvent` on save.
- **Custom tempstore** `TempStore\PreviewTempStoreFactory` + `Session\AccountProxyWrapper` (read the
  owner's private tempstore).

## Solution docs

- **Enable, settings page, enabled bundles, encryption profile, consumer URL templates** →
  [config/settings.md](config/settings.md)
- **Token flow, JSON:API preview routes, auth provider, entity access, include resolver, events** →
  [api/preview.md](api/preview.md)
