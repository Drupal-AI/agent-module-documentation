<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API dashboard, routes & key generator

## Routes (`acquia_cms_headless.routing.yml`)

| route | path | controller | requirement |
|-------|------|------------|-------------|
| `acquia_cms_headless.dashboard` | `/admin/headless/dashboard` | `HeadlessDashboardController::content` | `_permission: access acquia cms headless dashboard` |
| `acquia_cms_headless.generate_keys` | `/admin/headless/dashboard/generate/keys` | `HeadlessKeyGenerator::generateApiKeys` | `_permission: administer acquia cms headless keys` |
| `acquia_cms_headless.generate_consumer_secret` | `/admin/headless/dashboard/generate/secret/consumer/{consumer}` | `HeadlessKeyGenerator::generateConsumerSecret` | `_permission: administer acquia cms headless keys` |
| `acquia_cms_headless.generate_preview_secret` | `/admin/headless/dashboard/generate/secret/preview/{next_site}` | `HeadlessKeyGenerator::generatePreviewSecret` | `_permission: administer acquia cms headless keys` |

The dashboard menu link (`acquia_cms_headless.links.menu.yml`) hangs under the Acquia CMS tour.
All routes are admin-permission gated; the generator routes are opened in AJAX modal dialogs from
the dashboard's operation dropbuttons.

## `HeadlessDashboardController::content()`

`src/Controller/HeadlessDashboardController.php` (marked `@internal`, `final`). Iterates
`plugin.manager.acquia_cms_headless` definitions; for each whose `isModuleEnabled()` is true, calls
`classResolver->getInstanceFromDefinition()` and renders it via `formBuilder()->getForm()` (each
section is a `FormInterface`). Attaches `acquia_cms_tour/acquia_cms_tour_dashboard` and
`acquia_cms_headless/acquia_cms_headless_dashboard` libraries.

## `HeadlessKeyGenerator` controller

`src/Controller/HeadlessKeyGenerator.php`. Three actions, all returning a render array shown in the
modal:
- `generateApiKeys()` → `StarterkitNextjsService::generateOauthKeys()`; message reports the
  key-pair path (built from `%site.path%`) and links to the OAuth settings page.
- `generateConsumerSecret()` → new secret via `createHeadlessSecret()`, `$consumer->set('secret',
  $secret)->save()`, renders the new secret so the operator can copy it into `.env`.
- `generatePreviewSecret()` → new secret written to `next.next_site.<id>` config `preview_secret`,
  rendered plus a link to the next_site entity.

The secret/key generators are **GET** routes (opened as `use-ajax` links) that mutate state
(rotate a consumer secret, rotate a preview secret, regenerate the OAuth key pair). Access is
gated by the `administer acquia cms headless keys` permission.

## Plugin type `AcquiaCmsHeadless` (dashboard sections)

Manager `AcquiaCmsHeadlessManager` (dir `Plugin/AcquiaCmsHeadless`, annotation
`Annotation\AcquiaCmsHeadless` with `id`/`title`/`weight`, base `AcquiaCmsHeadlessPluginBase`,
interface `AcquiaCmsHeadlessInterface`). Definitions sorted by `weight`. Each section extends
`acquia_cms_tour`'s `AcquiaCmsDashboardBase` (a config form) and declares a `$module` it depends on:

| id | weight | class | shows |
|----|--------|-------|-------|
| `headless_api_url` | 1 | `AcquiaHeadlessApiUrl` | base JSON:API URL + link to jsonapi_extras settings |
| `headless_api_docs` | 2 | `AcquiaHeadlessApiDocs` | ReDoc / Swagger UI / OpenAPI resource links |
| `headless_next_sites` | 3 | `HeadlessNextSites` | table of `next_site` entities + ops (env vars, edit, delete, clone, new preview secret) |
| `headless_api_keys` | 4 | `HeadlessApiKeys` | table of consumers; secret column masked `**********`; ops (edit, generate secret, generate keys, delete, clone) |
| `headless_next_entity_types` | 5 | `HeadlessNextEntityTypes` | table of `next_entity_type_config` |
| `headless_api_users` | 6 | `HeadlessApiUsers` | users holding the `headless` role |

`HeadlessApiKeys::buildEntityRows()` deliberately renders the consumer `secret` as `**********`
(never the value) — the info text says "Consumer secrets are encrypted and cannot be displayed."
`client_id` is shown in full. All section entity queries use `accessCheck(TRUE)` and pager(10).

## Tour step — `Plugin/AcquiaCmsTour/AcquiaHeadlessForm`

The "Headless" get-started form. Two checkboxes: **Enable Next.js starter kit** (on submit, when
newly checked, runs `initStarterkitNextjs('headless', ['site-name' => 'Headless Site 1',
'site-url' => 'http://localhost:3000'])` and saves `starterkit_nextjs`), and **Enable Headless
mode** (installs/uninstalls the `acquia_cms_headless_ui` submodule and saves `headless_mode`).
`checkMinConfiguration()` is "configured" only when both are true.
