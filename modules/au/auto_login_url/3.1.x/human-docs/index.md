# Auto Login URL — manual setup guide

**Auto Login URL** (`auto_login_url`) creates "magic link" URLs that log a
specific user in without a password and then drop them wherever you want — their
dashboard, an account-edit page, or any destination you choose. It is the
building block behind passwordless email links, "finish setting up your account"
invitations, and one-click login flows.

Each link points at a public route, `/autologinurl/{uid}/{hash}`, where the hash
is a cryptographically strong, unguessable token. The token is built from random
bytes mixed with your site's hash salt, a module secret, and the target user's
current password hash — so nobody can forge or brute-force one, and changing a
user's password automatically invalidates every outstanding link for that user.
Links expire (30 days by default, or a custom lifetime per link), can be made
single-use, can be locked to the IP that created them, and login attempts are
flood-protected per IP.

You can mint links three ways: from an **admin form** at
`/admin/people/autologinurl/generate`, from **custom code**
(`auto_login_url_create()`), or with the **Token** module using
`[user:auto-login-url-token]` inside email templates. The admin area also lists,
views, and bulk-deletes links, shows usage analytics, and exposes a health-check
endpoint.

> **Security note:** these links *are* credentials. Anyone who has the URL is
> logged in as that user until it expires or is used. Send them only over secure
> channels, prefer short lifetimes and single-use for sensitive flows, and be
> deliberate about who holds the two module permissions — both are marked
> security-restricted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the admin/reporting
   pages, the two permissions, and the security defaults you should review.

## Where it lives in the admin menu

- **Settings** — **People → Auto Login URL** (`/admin/people/autologinurl`).
- **Generate a link** — `/admin/people/autologinurl/generate`.
- **Manage links** — `/admin/people/autologinurl/manage` (list, view, delete,
  bulk-delete expired).
- **Usage analytics** — `/admin/people/autologinurl/usage`.
- **Health check** — `/admin/reports/auto-login-url/health`.

All of the above require the **Administer auto login url** permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). A
   random module secret is generated automatically the first time a link is
   created.
2. Review the [settings](configuration/index.md) — especially the default
   expiration, whether links should be single-use, and IP locking — and grant the
   permissions to trusted roles only.
3. Create a link the way that fits your use case:
   - **Ad hoc:** use the **Generate** form to mint a link for a chosen user.
   - **In email templates:** enable the **Token** module and drop
     `[user:auto-login-url-token]` into a mail body to render a ready-made login
     link for the recipient.
   - **In code:** call `auto_login_url_create($uid, $destination, …)` (see the
     [`agent/` API docs](../agent/api/create.md)).
4. Monitor and clean up from **Manage** and **Usage** — cron also prunes expired
   links and old analytics automatically.
