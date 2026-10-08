# Configuration

There is no single "Configure" link for this module. Everything is under
**Configuration → People → miniOrange OAuth Client**
(`/admin/config/people/mo-oauth-client/…`) and needs the **miniOrange
Administrator Privilege** (`mo_administrator`) permission. Start at the **Client
Configuration** list and click **Add** to create a connection.

## Step 1 — Create an IdP connection

Each connection is its own configuration entity (`mo_client_config`). On the
Add/Edit form you provide, at minimum:

- **App name** — a human-readable label (the entity's machine ID is derived from
  it).
- **Login protocol** — **OAuth** (raw OAuth 2.0) or **OpenID** (OpenID Connect).
- **Grant type** — one of Authorization Code, Authorization Code with **PKCE**,
  Implicit, Resource-Owner Password, or Refresh Token. Authorization Code (with
  or without PKCE) is the standard choice for server-side SSO.
- **Client ID** and **Client Secret** — the credentials from your IdP app. Keep
  the secret out of version control (see
  [Installation](../installation/index.md#keep-the-client-secret-out-of-version-control)).
- **Authorize endpoint**, **Access token endpoint**, and **Userinfo endpoint** —
  the provider URLs. For OpenID you can also set a **JWKS endpoint**; an optional
  **group info endpoint** is available for role/group data.
- **Scope** — the scopes to request (for example `openid email profile`).

The form also shows the **callback / redirect URI** you must register at your
IdP. It has the form:

```
https://<your-site>/mo-oauth-client/callback/<connection-id>
```

Copy that into your IdP application's list of authorized redirect URIs.

## Step 2 — Test the connection

The Add/Edit flow includes a **Test Connection** action. It runs the full
authorization → token → userinfo round-trip and shows you the **raw attributes**
the IdP returns, **without logging anyone in**. Use it to discover the exact
claim names (for example `email`, `preferred_username`) before you set up
attribute mapping.

## Step 3 — Map attributes to Drupal

Attribute mapping is a required step, edited from the connection's tabs:

- **Attribute Mapping** (required) — map the IdP's email/login claim to the
  Drupal field used to match or create the account. On the **free tier** this
  match field must be **email** (`mail`). Additional rows can map further claims
  onto user fields.
- **Role / Group / Profile Mapping** (paid tiers) — assign Drupal roles from IdP
  attributes or groups, map profile fields, and set a default role for new
  users.

Remember: on the free tier only **existing** users (matched by email) can log
in. Auto-creating accounts requires a license.

## Step 4 — Per-connection behavior

The connection's client settings control what happens around login:

- **Auto-create user** / **disable new user** (licensed) — whether first-time IdP
  users get a Drupal account.
- **Post-login redirect** — send users to a chosen destination, or back to where
  they started.
- **Role-based restriction** — limit which users may SSO by role/attribute.
- **Single Logout (SLO)** — log the user out of the IdP when they log out of
  Drupal, with an optional logout URL.
- **Token expiry handling** — tie the Drupal session to the IdP token's lifetime
  and choose what happens when it lapses (log out or renew), and optionally
  revoke the token at the IdP.

Enable **Login with OAuth** on the connection (after Test Connection passes)
before real logins are accepted, and optionally turn on **Display login link** to
show a "Login with <IdP>" link on the Drupal login form.

## Step 5 — Site-wide login enforcement (optional)

Under **Module Settings** (`/mo-oauth-client/settings/module`, some options are
premium-tier) you can:

- **Force Authentication** / **Replace Drupal login page** — redirect users to
  the IdP for login automatically.
- Add a **login link** or block for the IdP.

If you enable enforced redirection, note the anti-lockout escape hatch: the
option confusingly labelled **"Enable backdoor access"** is *not* a security
bypass — it simply lets an admin still reach any URL by appending
`?mo_force_stop_redirect=true`, so you don't lock yourself out.

## Other screens

- **Login Reports** (`/mo-oauth-client/login-reports`) — an audit log of every
  SSO attempt (initiated / success / failed).
- **Import / Export** (`/mo-oauth-client/configuration/import-export`) — move the
  module's configuration between environments.
- **Setup guide** (`/mo-oauth-client/setup-guide`) — provider-specific help.

## Security notes

- The two SSO runtime routes (the login entry point and the callback) are
  intentionally **anonymous** — the IdP must be able to reach the callback. The
  session-bound `state` check is the request-forgery defense, so don't add your
  own access check that would break the round-trip.
- The `mo_administrator` permission is powerful (it exposes client credentials
  and controls authentication for everyone). Grant it only to trusted roles.
