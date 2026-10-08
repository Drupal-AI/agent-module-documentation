# Magic Link — manual setup guide

**Magic Link** (`magic_link`) adds a **passwordless "magic link" login** option to
Drupal's core login form. A visitor clicks *"Send me a magic link"*, enters their
email address, and receives a one‑time login URL; clicking it signs them in
without a password. The request UI is **HTMX‑powered**, so it slots into the core
`/user/login` form without a full page reload, and the whole experience preserves
Drupal's standard login page rather than replacing it.

It is a good fit for sites that want frictionless, password‑free sign‑in while
keeping Drupal's security practices intact. You can customise the link's expiry,
the email template (with token support), and an optional default destination after
login. The module also ships a Drush command for generating links during
development.

> **Security model — this is a login credential in an email.** Magic Link's token
> design is **sound**, and it is worth understanding what protects an account:
>
> - **Unforgeable token.** The login token is an **HMAC‑SHA256 signature keyed
>   with the site's secret hash salt** (`Settings::get('hash_salt')`), computed
>   over the user id, an **expiration timestamp**, and a random nonce. Without the
>   hash salt the signature cannot be forged.
> - **Constant‑time verification.** The token is verified by recomputing the HMAC
>   and comparing with **`hash_equals()`**, which avoids timing side‑channels.
> - **Expiring and single‑use.** Expired tokens are rejected, and token state is
>   held in a key‑value expirable store (one‑time by default, with an optional
>   persistent‑link mode for development).
> - **CSRF protection** is in place around the request lifecycle.
>
> The residual risks are the ones inherent to any magic link: the emailed link is
> a **login credential**, so serve login over **HTTPS**, keep the **expiry short**,
> and treat links like passwords — never share or log them in plaintext. Once a
> link is issued, account security depends on the security of the user's email
> inbox until the link expires.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its HTMX dependency, and check permissions.
2. [Configuration](configuration/index.md) — set the link expiry, customise the
   email template, and choose the post‑login destination.

## Where it lives in the admin menu

Magic Link's settings are at **Configuration → People → Magic Link**
(`/admin/config/people/magic-link`).

## How to use it

1. Install and enable the module and the HTMX module (see
   [Installation](installation/index.md)).
2. Set the link expiry and customise the email template (see
   [Configuration](configuration/index.md)). Make sure outbound email is
   configured.
3. On the core login page (`/user/login`), users click **"Send me a magic link"**,
   enter their email, and receive a one‑time login URL. The module validates the
   token, logs them in, and redirects to the configured destination.
