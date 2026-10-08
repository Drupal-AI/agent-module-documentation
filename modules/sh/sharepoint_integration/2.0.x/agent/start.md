<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SharePoint Integration — agent index

Connects **Microsoft SharePoint / OneDrive to Drupal** using the **Microsoft Graph API**
and the **SharePoint REST API** (miniOrange). Version **2.0.0**, core `^10 || ^11`,
package *miniOrange SharePoint Integration*. Configure at **`mo_sharepoint.client_configuration`**
(`/admin/config/mo-sharepoint-integration/client-config`).

## What it does
- Connects one or more SharePoint sites through a **Microsoft Entra ID (Azure AD) app
  registration** (Tenant ID, Client ID, Client Secret — or a client certificate via the
  optional `custom_certificate` module).
- Authenticates with the **OAuth 2.0 client-credentials grant** (app-only) against
  `getAccessTokenEp()`; separate tokens for Graph (`graph.microsoft.com/.default`) and
  SharePoint REST (`{domain}.sharepoint.com/.default`). Tokens are cached and auto-refreshed.
- Syncs SharePoint **document libraries, lists, list/library views and site pages** into
  local config entities (`mo_sharepoint_site`, plus `MoSharepointFiles`/`MoSharepointLists`/
  `MoSharepointPage`), on **cron** (premium) or on demand.
- Front-end **browse / preview / download / upload** of SharePoint files, lists and pages,
  each gated by a Drupal permission.
- **Import/Export** of configuration, configurable **logging**, and a premium **AI Assistant**
  chat widget (Microsoft Copilot Studio iframe or Azure OpenAI + Graph).

## Key pieces
- Graph client: `src/MoApi/MoGraphQl/MoDefaultGraphQlService.php` (sites, drives, items,
  download, preview, upload, pages).
- REST client: `src/MoApi/MoREST/MoDefaultRestService.php` (list views, list-item attachments).
- Token: `src/MoApi/MoREST/MoFetchToken.php` (client-credentials; optional RS256 JWT client
  assertion for certificate auth). Config DTO: `src/MoDTO/MoClientConfiguration.php`.
- Controllers: `MoSharePointFilesController`, `MoSharePointListsController`,
  `MoSharePointPagesController`, `MoSharepointController`, `MoModuleController`.
- Constants (fixed endpoint templates): `src/MoConstant/MoModuleConstant.php` —
  Graph base `https://graph.microsoft.com/v1.0`, REST base `https://{tenant}.sharepoint.com`.

## Permissions (`sharepoint_integration.permissions.yml`)
- `mo_administrator` — administer the module (restricted; grants access to the stored Entra ID
  client credentials).
- `mo_access_file` / `mo_access_list` / `mo_access_view` / `mo_access_page` — end-user access
  to synchronized files / lists / list&library views / pages.

## Drush
- `drush sharepoint_integration:sync-site` — sync a configured SharePoint site.

## Mechanism notes
- SharePoint/Graph/REST API calls use Drupal's standard HTTP client (`\Drupal::httpClient()`);
  the Graph host is fixed to `graph.microsoft.com` and the REST host is the tenant SharePoint
  domain. OAuth is app-only client-credentials, so there is **no interactive redirect/callback**.
- The chat widget passes only non-secret settings to `drupalSettings`; the Copilot Direct Line
  secret and the Azure OpenAI API key stay **server-side** (see `hook_page_attachments`).
- Client credentials and cached tokens live in Drupal config (`sharepoint_integration.mo_sharepoint_config`);
  restrict `mo_administrator` and manage config export securely.

## Diff 1.1.x → 2.0.x (major bump — BC breaks)
- **Full rewrite / new architecture.** 1.1.x exposed a single connection form at
  `sharepoint_integration.connection`; 2.0.x replaces it with a `mo_*` route/class family and a
  new config object `sharepoint_integration.mo_sharepoint_config`. **The configure route changed
  to `mo_sharepoint.client_configuration`** and the old `sharepoint_integration.connection` route
  no longer exists.
- **New permission set.** Old single admin-oriented scheme → `mo_administrator` plus four
  granular end-user permissions (`mo_access_file/list/view/page`). Update role grants after upgrade.
- **New config entity** `mo_sharepoint_site` (multiple sites; one site on the free tier) with
  add/edit/delete/sync routes, replacing the earlier single-connection model.
- **New front-end surface:** `/mo-sharepoint/*` routes for browsing, previewing, downloading and
  uploading Files, Lists, Views and Pages.
- **New capabilities:** cron + Drush sync (`sharepoint_integration:sync-site`), config
  import/export, logger settings form, and a premium **AI Assistant** (Copilot Studio / Azure
  OpenAI) chat widget.
- **Dual OAuth scopes** (Graph and SharePoint REST) with cached, auto-refreshed app-only tokens,
  and optional certificate-based (JWT client-assertion) authentication via `custom_certificate`.
- The old `MOSupport::callService()` support helper was reorganized; support/license calls now
  live under `MoHelper`/`MoFeatures`. Treat this as a fresh install-and-reconfigure, not an
  in-place settings carry-over.

See `usage.md` for use cases. Store the Entra ID client secret securely and operate over HTTPS.
