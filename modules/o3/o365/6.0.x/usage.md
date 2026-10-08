<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft 365 Connector gives Drupal a Microsoft Graph API client and an OAuth2 sign-in flow for Microsoft 365 / Entra ID, with a connector entity per Microsoft app registration, group-to-role mapping, and a family of submodules that surface mail, calendar, files, contacts, Teams and profile data as blocks.

---

The module builds on `oauth2_client` for the OAuth flow and `externalauth` for mapping Microsoft identities onto Drupal accounts, and pulls in the `microsoft/microsoft-graph` PHP SDK. Each connection is an **`o365_connector`** config entity (label, redirect URL, requested scopes) managed under `/admin/config/system/o365/settings/o365-connectors`; the sensitive client id / secret / tenant id are read from `settings.php` (`$settings['o365'][<connector_id>]`) via `HelperService`, not stored in config. `GraphService` (service `o365.graph`) is the central developer API — `getGraphData()`, `sendGraphData()` and `getCollectionData()` wrap Graph calls and inject the current user's token; `AuthenticationService` drives the delegated authorization_code sign-in (with an app-only client_credentials `oauth2_client` plugin as an alternative), `RolesService` maps Microsoft group membership onto Drupal roles on login, `PersonaRenderService` renders person cards, and `O365LoggerService` provides the module's log channel. Two block base classes (`O365BlockBase`, `O365UncachedBlockBase`) let integrators write Microsoft-backed blocks with correct caching — the uncached variant exists because Graph data is per-user. A scopes report at `/admin/reports/o365-auth-scopes` and a Graph debugger form aid setup, and `hook_o365_auth_scopes()` lets other modules add the scopes their integration needs. Fourteen submodules add SSO, user sync, profiles/personas, Outlook mail and calendar, OneDrive and SharePoint file access, contacts, Groups-to-Teams linking, Teams messaging, app links, and REST endpoints. The installed release on the 6.0.x branch is a beta.

---

- Let staff sign in to Drupal with their Microsoft 365 account (SSO).
- Provision Drupal accounts on first Microsoft sign-in via externalauth.
- Map Entra ID group membership to Drupal roles, with a list of safe roles.
- Give developers a simple `GraphService` to read any Graph endpoint.
- Write data back to Graph (create Outlook events, send data) from Drupal.
- Page through large Graph collections with `getCollectionData()`.
- Keep client credentials out of config by sourcing them from `settings.php`.
- Connect several Microsoft app registrations via separate connector entities.
- Serve different connectors for staff and student tenants.
- Render a Microsoft persona / person card from Graph profile data.
- Sync Microsoft profile fields and profile picture onto the Drupal user (`o365_sso_user`).
- Show a user's latest or unread Outlook mail in a block (`o365_outlook_mail`).
- Display and add to the user's Outlook calendar (`o365_outlook_calendar`).
- List a user's recent or shared OneDrive files (`o365_onedrive`).
- Search SharePoint files from a block or link to them from a field (`o365_sharepoint_file`, `o365_sharepoint_field`).
- Search Microsoft 365 contacts (`o365_contacts`).
- Link Drupal Group entities to Microsoft Teams and list Team files (`o365_groups`).
- Send Teams messages or start a chat/call from Drupal (`o365_teams`).
- Show a block of links to the user's Office apps (`o365_links`).
- Expose the current user's access token or profile data over REST (`o365_rest`, `o365_profile_rest`).
- Add extra Graph authorization scopes from a custom module via `hook_o365_auth_scopes()`.
- Review which authorization scopes are requested at `/admin/reports/o365-auth-scopes`.
- Diagnose Graph calls on a dedicated debugger page.
- Cache Graph-backed custom blocks correctly per user with the uncached block base.
- Grant editors access to the settings page without full site admin.
- Log connector activity to a dedicated `o365` channel.
- Build an intranet dashboard aggregating a user's Microsoft 365 data.
