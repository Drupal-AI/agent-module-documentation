<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft Graph API is a developer-only connection layer that stores Azure credentials in a Key entity and hands other modules an authenticated Microsoft Graph client.

---

Microsoft Graph is the single API surface over Microsoft 365 and Entra ID (Azure AD): users, groups, mail, calendars, files, Teams and directory data. This module is deliberately plumbing rather than a feature — it provides no blocks, fields or admin screens for content, and installing it alone changes nothing a site builder can see. Its job is to hold the credentials, perform the OAuth 2.0 client-credentials token exchange against `login.microsoftonline.com`, and return a ready-to-use `Microsoft\Graph\Graph` object from the official `microsoft/microsoft-graph` PHP SDK. The business logic — what you actually read from or write to Graph — is left to whatever custom or contrib module needs it.

Credentials live in a dedicated Key type ("MS Graph API Key") supplied by this module, holding the tenant domain, tenant ID, client ID and client secret. Because `key:key` is a hard dependency, the client secret can be sourced from an environment variable and kept out of configuration exports. A site-wide **default** key is chosen on the settings form at `/admin/config/services/ms-graph-api`; consuming code fetches the `ms_graph_api.graph` service for that default, or calls the `ms_graph_api.graph.factory` service to build a client from any custom key by ID — useful when a site talks to several Azure tenants. The release documented here is **2.0.0-beta2**, and the project is marked "Seeking new maintainer" / "No further development", so evaluate carefully before relying on it in production.

---

- Give a custom module an authenticated Microsoft Graph client via dependency injection.
- Read the Microsoft 365 staff directory into a Drupal intranet.
- List events from a shared Microsoft 365 calendar.
- Reflect Entra ID (Azure AD) group membership on a site.
- Look up a user's profile with `GET /me` or `GET /users/{id}`.
- Query organisation data through the official Graph PHP SDK models.
- Store Azure client secret, client ID, tenant ID and tenant domain in one Key entity.
- Keep the client secret in an environment variable, out of config exports.
- Select a site-wide default Graph credential at `/admin/config/services/ms-graph-api`.
- Serve multiple Azure tenants by building a client per custom key ID.
- Obtain the default client with `\Drupal::service('ms_graph_api.graph')`.
- Build a client for a named key with `buildGraphFromKeyId('my_key')`.
- Retrieve a tenant's primary domain from its key without a full client.
- Register a Drupal site as an Azure AD app and wire its credentials in.
- Rotate the Azure client secret by editing the Key entity.
- Centralise Graph authentication so consuming modules never handle raw secrets.
- Front a Teams or SharePoint integration built as a separate module.
- Reuse one credential store across several Graph-consuming features.
- Audit which Graph application permissions the site's app registration holds.
- Prototype a Microsoft 365 integration before committing to a full build.
