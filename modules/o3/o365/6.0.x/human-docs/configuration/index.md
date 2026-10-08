# Configuration

Setting up the Microsoft 365 Connector has three parts: registering an
application in Microsoft, creating a connector in Drupal that points at it, and
granting the module's permissions. Because the module builds on OAuth2 Client and
External Authentication, some of the credential handling happens through those
modules.

## 1. Register an application in Microsoft

In the Microsoft Entra admin center (Azure portal), create an **app
registration** for your Drupal site. From it you will obtain:

- a **client ID** (application ID),
- a **client secret**,
- the **authorization scopes** your site needs (for sign-in and any Graph data
  you intend to read),
- a **redirect URI** pointing back at your Drupal site's OAuth callback.

Keep the client secret to hand for the next step — and treat it as a secret (see
below).

## 2. Configure the connection in Drupal

1. Log in as a user with the **Access o365 settings page** permission.
2. Go to **Configuration → System → Microsoft 365 Connector**
   (`/admin/config/system/o365/settings`) to set the module-level options.
3. Create an **o365 connector** entity — one per Microsoft app registration —
   describing the client credentials, scopes and behaviour for that connection.
   You can create several connectors, for example separate ones for staff and
   student tenants.

The OAuth client details (client ID and secret) are handled through the
**OAuth2 Client** configuration that this module builds on. Follow this project's
convention and source the **client secret** from an environment variable via a
Key entity rather than committing it into exported configuration.

## 3. Map Microsoft groups to Drupal roles

The module can map Entra ID **group membership** onto Drupal **roles**, so that a
user's access in Drupal follows their Microsoft group membership. Configure the
role mapping so that the appropriate Microsoft groups grant the roles you want —
then audit which Drupal roles are derived from Microsoft groups so nothing is
granted unexpectedly.

## 4. Grant permissions

The module ships granular permissions — assign them at **People → Permissions**:

| Permission | Purpose |
|---|---|
| **Access o365 settings page** | Reach the settings form. Grant to site admins. |
| **Access o365 debugger page** | Reach the diagnostics/debugger page. |
| **Administer o365 connectors** | Full control of connector entities — **restricted**, grant only to trusted admins. |
| **Access / create o365 connector** (and the rest of the connector CRUD set) | Manage connector entities at a finer grain. |

## 5. Verify and diagnose

- Check the **authorization scopes report** at `/admin/reports/o365-auth-scopes`
  to review exactly which scopes are being requested.
- If sign-in fails, use the **debugger page** (behind *Access o365 debugger page*)
  to diagnose the OAuth connection.
- When rendering Microsoft-backed blocks, remember the module provides an
  **uncached** block base for anything showing per-user Graph data — use it so one
  user's Microsoft data is never cached and served to another.

## A note on caching per-user data

Microsoft Graph data is specific to the signed-in user. Blocks that render it must
not be shared between visitors, which is why the module ships a dedicated uncached
block base class. If you build custom Microsoft-backed blocks, base them on that
so caching stays correct.
