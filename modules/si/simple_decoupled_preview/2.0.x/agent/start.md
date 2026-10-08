<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Decoupled Preview (simple_decoupled_preview) — agent index

Lets a decoupled/headless front end render an editor's **unsaved node preview**. When an editor
clicks Drupal's Preview button on a configured node type, a custom submit handler serialises the
in-memory draft node to JSON:API format (via the bundled `simple_decoupled_preview_jsonapi`
submodule) and stores it as a `preview_log_entity` keyed by the node UUID, langcode and previewing
user id. Drupal's preview page then renders a `decoupled_preview` view mode whose only output is an
`<iframe>` pointing at a configured front-end URL (`preview_callback_url`), with
`/{bundle}/{uuid}/{langcode}/{uid}` appended. The front end loads that iframe, calls back into a
REST endpoint (`/api/preview/{uuid}?uid=…&langcode=…`) to fetch the stored draft JSON, and renders
it. The submodule also registers, for every node resource type, a live JSON:API preview route
(`/jsonapi/node/{bundle}/{node_preview}/preview`) that serialises the current user's tempstore
preview on the fly.

The module exists to work around the fact that core's JSON:API node-preview data is only reachable
by the same authenticated user that created the preview (it lives in that user's tempstore). By
caching the editor-generated JSON into a stored entity and re-serving it through a REST resource, a
separately authenticated front end (or service account) can fetch it. A cron task deletes expired
log entities so the table stays small.

- Depends on (info.yml): `node`, `jsonapi`, `rest`, **`restui`** (a *UI* module in the runtime
  dependency list — enabling this pulls in the REST resources admin UI), and its own submodule
  `simple_decoupled_preview_jsonapi`.
- Core: `^10.2 || ^11`. Package: `Web services`. Composer: `drupal/restui:^1.18`, `drupal/core`.
- Settings page / `configure` route: **yes** — `simple_decoupled_preview.settings_form`
  (`/admin/config/services/simple_decoupled_preview/settings`).
- Provides config schema (`simple_decoupled_preview.settings`), 6 own permissions, **no** drush,
  **no** new plugin *types* (it ships one REST `@RestResource` plugin instance and a content entity).
- Entity type defined: `preview_log_entity` (base table `preview_log_entity`) with list builder,
  views data and an access control handler.

## What you'd do → where

- **Configure the callback URL, which node types are previewable, JSON:API includes, log expiry;
  and the required content-type / view-mode / REST / permission setup** →
  [configure/settings.md](configure/settings.md)
- **Fetch stored preview JSON from a front end / call the preview logger service from PHP /
  understand the `preview_log_entity` fields and its access permissions** → [api/rest.md](api/rest.md)
- **Understand the live JSON:API preview routes, the controller/route-callback/include-resolver
  overrides, and the `EntityToJsonApiPreview` service** →
  [api/jsonapi-preview.md](api/jsonapi-preview.md)

## Key facts (real machine names)

- Routes (parent): `simple_decoupled_preview.settings_form`
  (`/admin/config/services/simple_decoupled_preview/settings`, perm `administer simple decoupled
  preview`), `simple_decoupled_preview.previews_log`
  (`/admin/config/services/simple_decoupled_preview/preview/logs`, `_entity_list:
  preview_log_entity`, perm `administer preview log entity entities`).
- REST resource plugin: id `simple_decoupled_preview_json`, class
  `Plugin/rest/resource/PreviewResource`, canonical URI `/api/preview/{uuid}` (GET only). Its
  generated permission is `restful get simple_decoupled_preview_json` ("Access GET on Simple
  Decoupled Preview JSON resource"). Disabled until enabled via REST UI.
- Routes (submodule, dynamic via `Routing\Routes::routes`): one per node resource type,
  `jsonapi.node--{bundle}.individual.preview` at
  `/jsonapi/node/{bundle}/{node_preview}/preview` (GET, requirement `_node_preview_access`).
- Services: `simple_decoupled_preview.logger` (`PreviewLogger`),
  `simple_decoupled_preview.entity_to_jsonapi_preview` (`…_jsonapi\EntityToJsonApiPreview`).
  Submodule overrides core JSON:API services: `jsonapi.normalization_cacher` (→
  `ResourceObjectNormalizationCacher`), `simple_decoupled_preview_jsonapi.entity_resource` (extends
  `jsonapi.entity_resource`), `simple_decoupled_preview_jsonapi.include_resolver` (`IncludeResolver`).
- Entity: `preview_log_entity` — access handler `PreviewLogEntityAccessControlHandler`, list builder
  `PreviewLogEntityListBuilder`, views data `PreviewLogEntityViewsData`. Fields: `entity_uuid`,
  `title`, `type`, `bundle`, `published`, `json` (string_long, the serialised draft), `uid`
  (entity_reference→user, "Previewed by"), `created`. Entity keys include `uid`, `langcode`,
  `published`=`status`.
- Permissions (6): `administer simple decoupled preview` (restrict), `administer preview log entity
  entities` (restrict), `add/edit/delete/view preview log entity entities`.
- Config object `simple_decoupled_preview.settings`: `preview_callback_url` (uri), `bundles`
  (sequence), `includes` (sequence, per-bundle comma list), `delete_log_entities` (bool, default
  true), `log_expiration` (string seconds, default `86400`).
- View mode: `node.decoupled_preview` ("Decoupled Preview", `config/optional`, off by default).
- Theme/template: hook `node__decoupled_preview`, template
  `templates/node--decoupled-preview.html.twig` (renders only `content.preview_iframe`). Library
  `simple_decoupled_preview/iframe_preview` (`css/iframe_preview.css`). Extra display field
  `preview_iframe` added per configured bundle.
- Hooks implemented (`.module`): `help`, `form_alter` (+ custom submit `…_preview_submit`),
  `form_node_preview_form_select_alter`, `theme`, `entity_extra_field_info`, `entity_view` (builds
  the iframe), `jsonapi_preview_log_entity_filter_access`, `cron` (expiry cleanup).
