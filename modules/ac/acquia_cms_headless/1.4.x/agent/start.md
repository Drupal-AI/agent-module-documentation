<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS Headless (acquia_cms_headless) — agent index

Composes and auto-configures the **decoupled stack** for Acquia CMS: JSON:API (+ JSON:API Extras /
Menu Items), the Next.js `next`/`next_jsonapi` modules, **Consumers**, **Simple OAuth**, RESTUI,
decoupled_router and OpenAPI ReDoc/Swagger. It ships an **API dashboard** whose plugin sections
provision and manage a Next.js "starter kit" (consumer, OAuth keys, user, role, `next_site`,
`next_entity_type_config`). Package `Acquia CMS`. Core `^10 || ^11`. GPL-2.0-or-later. Version 1.4.1.

Runtime deps (info.yml): `acquia_cms_common`, `acquia_cms_tour`, `consumers`, `jsonapi_extras`,
`jsonapi_menu_items`, `next:next_jsonapi`, `openapi_jsonapi`, `openapi_ui_redoc`,
`openapi_ui_swagger`, `rest`, `simple_oauth`. Composer also pulls `decoupled_router`, `restui`.

## Solution docs

- **Config object, install hooks, the `headless` role, seckit rewrite** →
  [config/settings.md](config/settings.md)
- **The starter-kit service: consumer/key/user provisioning, OAuth keys, env vars** →
  [services/starterkit.md](services/starterkit.md)
- **API dashboard: routes, permissions, key-generator controller, dashboard plugin sections** →
  [dashboard/dashboard.md](dashboard/dashboard.md)
- **Drush commands (`acms:headless:new-nextjs`, `acms:headless:regenerate-env`)** →
  [drush/commands.md](drush/commands.md)

## What it provides (from source)

- **Config**: `acquia_cms_headless.settings` (`starterkit_nextjs`, `headless_mode`, `consumer_uuid`,
  `user_uuid`; schema in `config/schema/`). Install default at `config/install/`. Ships the
  `headless` user role (`config/install/user.role.headless.yml`) and a `seckit.settings` rewrite
  (`config/rewrite/`) that disables X-Frame-Options.
- **Permissions** (`acquia_cms_headless.permissions.yml`): `administer acquia cms headless
  configuration`, `access acquia cms headless dashboard`, `administer acquia cms headless keys`.
- **Routes** (`acquia_cms_headless.routing.yml`): `acquia_cms_headless.dashboard`
  (`/admin/headless/dashboard`) and three key/secret generators under `/admin/headless/dashboard/
  generate/*` handled by `Controller\HeadlessKeyGenerator`.
- **Services** (`acquia_cms_headless.services.yml`): `acquia_cms_headless.starterkit_nextjs`
  (`Service\StarterkitNextjsService`), plugin manager `plugin.manager.acquia_cms_headless`
  (`AcquiaCmsHeadlessManager`), `PreviewLinkAccessCheck` (access_check `_preview_link_access_check`),
  `PreviewLinkRouteSubscriber`, and `Config\AcquiaCmsHeadlessConfigSubscriber` (recreates the
  headless user on config import).
- **Plugin type** `AcquiaCmsHeadless` (`src/Annotation/AcquiaCmsHeadless.php`, base
  `AcquiaCmsHeadlessPluginBase`, interface `AcquiaCmsHeadlessInterface`): dashboard sections in
  `src/Plugin/AcquiaCmsHeadless/` — `AcquiaHeadlessApiUrl`, `AcquiaHeadlessApiDocs`,
  `HeadlessNextSites`, `HeadlessApiKeys`, `HeadlessNextEntityTypes`, `HeadlessApiUsers`.
- **Tour plugin** `Plugin/AcquiaCmsTour/AcquiaHeadlessForm` (the "Headless" get-started step).
- **Field formatters**: overrides core oEmbed formatter — `Plugin/Field/FieldFormatter/
  OEmbedFormatter` + `OEmbedAdvanceFormatter` (swapped in via `hook_field_formatter_info_alter`).
- **Drush**: `Commands\AcquiaCmsHeadlessCommands` (`drush.services.yml`).
- **Hooks** (`acquia_cms_headless.module`): `hook_content_model_role_presave_alter` (adds content
  roles to the `headless` user) and `hook_field_formatter_info_alter`.
- **Submodule**: `acquia_cms_headless_ui` (pure headless mode) — see its own docs tree.
