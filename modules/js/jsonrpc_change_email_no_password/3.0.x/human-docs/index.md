# JSON-RPC Change Email No Password — manual setup guide

**JSON-RPC Change Email No Password** (`jsonrpc_change_email_no_password`) adds a
single JSON-RPC method, `user.change_email_no_password`, that lets a logged-in
user change **their own** email address **without re-entering their account
password**. It is built for decoupled and headless sites, where core's usual
requirement to confirm the current password on an email change gets in the way of
a smooth app experience. It is the decoupled counterpart to the *No Current
Password* module.

The method only ever operates on the caller's own account — it resolves the target
strictly from the current user, so there is no way to pass someone else's user ID
— and it refuses accounts that hold the **admin** role. It is gated by a dedicated
permission, and it depends on the contributed **JSON-RPC** module, exposing no
routes, forms, or admin settings of its own.

> ## Account-security consideration — read before enabling
>
> This module **deliberately removes the password re-authentication** that Drupal
> normally requires before an email change. That is the whole point, but it has a
> real consequence: **anyone holding a valid session or token for a permitted
> account can change that account's email address without proving they know the
> password.** Because an attacker who changes the email can then trigger a password
> reset to the new address, this can enable an **account takeover** if a session or
> token is compromised.
>
> This is an intentional, opt-in trade-off — not a bug — and the module includes
> two guardrails: it can only change the *caller's own* email, and it **blocks the
> `admin` role** outright. To use it safely:
>
> - Grant the *Change one's email address without a password via JSON-RPC*
>   permission **only to trusted, non-admin roles** — ideally only verified
>   accounts.
> - Keep it off any administrative role (the code already enforces this for the
>   `admin` role, but be deliberate about your own high-privilege roles too).
> - Prefer pairing it with step-up authentication or 2FA at the app layer to offset
>   the removed re-authentication.
> - Audit which roles hold the permission as part of your security review.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permission.

This module has **no configuration page** — its only setting is the permission,
described below.

## Where it lives in the admin menu

There is no dedicated settings form. The one thing you configure is the
permission, at **People → Permissions** (`/admin/people/permissions`): grant
**Change one's email address without a password via JSON-RPC** to the roles that
should be allowed to use the method — bearing the account-security consideration
above firmly in mind.

## How to use it

Once the permission is granted, a decoupled front end calls the JSON-RPC method
`user.change_email_no_password` through the JSON-RPC module's endpoint, passing the
new address in the `mail` parameter. The method sets and saves the current user's
email and returns the new value on success, or a structured error on failure.
(Email format and uniqueness are enforced by the usual entity constraints when the
account is saved.)
