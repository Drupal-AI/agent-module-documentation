# Microsoft 365 Connector — manual setup guide

**Microsoft 365 Connector** (`o365`) lets Drupal authenticate users against
Microsoft 365 / Entra ID (formerly Azure AD) and pull data from the Microsoft
Graph API. Staff can sign in to Drupal with their Microsoft account, their Entra
ID group membership can be mapped onto Drupal roles, and blocks can render
Microsoft-backed content such as person cards and profile data.

The module stands on two well-established building blocks rather than reinventing
them: it uses **OAuth2 Client** (`oauth2_client`) for the OAuth sign-in flow and
**External Authentication** (`externalauth`) for mapping Microsoft identities onto
Drupal accounts. On top of that it adds a configuration entity called an
**o365 connector** — one per Microsoft app registration — that describes the
client credentials, scopes and behaviour for a connection, and a settings form for
the module as a whole.

Under the hood, dedicated services handle sign-in, Microsoft Graph calls, group-to-
role mapping and person-card rendering, plus the module's own logging channel. It
also ships two block base classes so Microsoft-backed blocks can be written with
the correct caching behaviour — there is an "uncached" variant specifically
because Graph data is per-user and must never be cached and served to a different
visitor. A report page lists the authorization scopes in play, and a debugger page
(behind its own permission) helps diagnose failed connections.

Permissions are granular: separate permissions guard the settings page, the
debugger page, and the connector entities (with `administer o365 connectors`
called out as a restricted permission). The packaged release is a beta
(`6.0.0-beta6`), so test it thoroughly before production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it with its dependencies, and run database updates.
2. [Configuration](configuration/index.md) — register your Microsoft app, create
   a connector, map roles, and grant permissions.

## Where it lives in the admin menu

- **Settings** — **Configuration → System → Microsoft 365 Connector**
  (`/admin/config/system/o365/settings`), behind the *Access o365 settings page*
  permission.
- **Authorization scopes report** — `/admin/reports/o365-auth-scopes`.
- **Debugger page** — behind the *Access o365 debugger page* permission.
- **Connectors** — the `o365_connector` entities, managed with their own
  create/access permissions and the restricted *Administer o365 connectors*
  permission.
