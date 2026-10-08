<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SharePoint Integration (by miniOrange) synchronizes and serves Microsoft SharePoint / OneDrive content in Drupal using the Microsoft Graph and SharePoint REST APIs.

---

SharePoint Integration connects one or more Microsoft SharePoint sites to Drupal through a
Microsoft Entra ID (Azure AD) application registration. Using the OAuth 2.0 client-credentials
grant, it obtains app-only tokens for the Microsoft Graph API (`graph.microsoft.com`) and the
SharePoint REST API (`{tenant}.sharepoint.com`), then synchronizes SharePoint document
libraries, lists, list/library views and site pages into Drupal config entities. Drupal users
can browse, preview, download and upload SharePoint content directly from the site, with each
front-end surface gated by a dedicated Drupal permission.

Configure it at `mo_sharepoint.client_configuration`
(`/admin/config/mo-sharepoint-integration/client-config`): enter the Tenant ID, Client ID and
Client Secret (or select a client certificate via the optional `custom_certificate` module),
fetch a token to verify the connection, then add SharePoint site(s) and run a sync. Grant the
`mo_administrator` permission (restricted) only to trusted roles, and grant the end-user
permissions (`mo_access_file`, `mo_access_list`, `mo_access_view`, `mo_access_page`) to the
roles that should see synchronized content. Synchronization runs on Drupal cron (premium) or on
demand with `drush sharepoint_integration:sync-site`. Configuration can be moved between
environments with the built-in Import/Export form, logging is configurable, and a premium AI
Assistant chat widget (Microsoft Copilot Studio or Azure OpenAI + Graph) can answer questions
about SharePoint content. Store the Entra ID client secret securely and operate over HTTPS.

---

- Connect a SharePoint site to Drupal via a Microsoft Entra ID (Azure AD) app registration.
- Authenticate app-only with the OAuth 2.0 client-credentials grant (no user SharePoint login).
- Use certificate-based (JWT client-assertion) auth instead of a client secret via `custom_certificate`.
- Synchronize SharePoint document libraries and files into Drupal.
- Synchronize SharePoint lists and list/library views into Drupal.
- Synchronize SharePoint site pages into Drupal.
- Browse synchronized SharePoint Files from a front-end page (`/mo-sharepoint/sites/files/all`).
- Browse synchronized SharePoint Lists (`/mo-sharepoint/lists/all`) and Pages (`/mo-sharepoint/sites/pages/all`).
- Preview a SharePoint file or list item in a modal using a Microsoft-generated preview URL.
- Download a SharePoint drive item as a file from Drupal.
- Upload a new file from Drupal back into a SharePoint document library.
- Restrict who can view files, lists, views and pages using granular Drupal permissions.
- Manage multiple SharePoint sites (Premium; one site on the free tier).
- Schedule automatic site synchronization on Drupal cron (Premium).
- Trigger a site sync from the command line with `drush sharepoint_integration:sync-site`.
- Export the module configuration and import it into another environment.
- Tune how much API activity is logged via the Log Settings form.
- Add an AI Assistant chat widget backed by Microsoft Copilot Studio (Premium).
- Add an AI Assistant chat widget backed by Azure OpenAI + Microsoft Graph (Premium).
- Show publicly available SharePoint documents inside Drupal pages.
- Stream SharePoint file/list-attachment content through Drupal without a separate SharePoint login.
- Keep SharePoint content in Drupal current with scheduled or on-demand re-sync.
- Delegate SharePoint content administration by granting `mo_administrator` to trusted roles only.
