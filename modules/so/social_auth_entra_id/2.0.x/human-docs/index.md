# Microsoft Entra ID SSO Login — manual setup guide

**Microsoft Entra ID SSO Login** (`social_auth_entra_id`) lets people sign in to
your Drupal site with their **Microsoft Entra ID** account (formerly Azure Active
Directory) — the usual requirement for an intranet, employee portal, or any site
backed by a Microsoft 365 tenant. It gives you enterprise‑ready Single Sign‑On
using a standard OAuth2 flow, automatic account creation on first login, and a
"Log in with Microsoft" button on the Drupal login page.

The login flow is standard OAuth/OIDC: a redirect route at `/user/login/entra-id`
sends the visitor to Microsoft, and a callback route receives them back with a
code that is exchanged for tokens and matched to a Drupal account. On first sign‑in
a new Drupal account can be created automatically, and you can restrict login and
registration to specific email domains — useful for keeping access to your own
organization. It depends only on core's **User** module (it does not build on the
Social Auth framework), and it has no submodules.

The module needs configuration before it does anything: you register an
application in the Azure portal and enter the **Client ID**, **Tenant ID**, and
**Client Secret** into the module's settings, optionally restricting allowed email
domains. See [Configuration](configuration/index.md) for the walk‑through.

Two security points are worth knowing, straight from the module's own notes.
First, the **client secret** you enter is saved into the module's configuration —
on this project's convention it should come from an environment variable and be
kept out of exported config, so treat it carefully. Second, on a site that already
has local user accounts, review how an Entra ID identity is matched to an existing
account by email before you enable it, so a Microsoft login cannot unexpectedly
take over a pre‑existing account. (The redirect route is intentionally open and
uncached — necessarily so, because someone starting a login is not yet
authenticated.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register an Azure application and
   enter the Client ID, Tenant ID, and Client Secret.

## Where it lives in the admin menu

After enabling the module, its settings live under **Configuration → People →
Social Auth Entra ID** (the settings form; the settings route is
`/admin/config/services/entra-id/settings`), gated by the **Administer site
configuration** permission. Once configured, users see a **Log in with Microsoft**
option on the login page.
