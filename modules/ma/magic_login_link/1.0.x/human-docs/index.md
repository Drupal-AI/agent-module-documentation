# Magic Login Link — manual setup guide

**Magic Login Link** (`magic_login_link`) offers **passwordless login via secure,
time‑sensitive magic links**. It adds a *"Login with Magic Link"* section to the
standard Drupal login form: a user enters their email or username, receives a
one‑time login URL by email, and clicking it signs them in — no password needed.
It keeps the core `/user/login` form intact rather than replacing it, and it has
**zero configuration** and **zero dependencies** beyond core User: install it, and
it is ready to use.

> **Security model — this module is built the right way.** Magic Login Link is a
> deliberate, positive contrast to weaker one‑time‑code implementations, and the
> details are what make it safe:
>
> - **Unguessable, user‑bound token.** The link's token is generated with core's
>   **`user_pass_rehash()`** — the very same secure HMAC Drupal uses for its
>   password‑reset links, computed over the user id, a timestamp, the user's last
>   login, and the password hash. It is therefore unguessable and **tied to the
>   specific user**, not a short code an attacker could brute‑force.
> - **Single‑use.** The token is stored in Drupal's State API and **deleted
>   immediately on a successful login**, which prevents replay.
> - **Short expiry.** Links are time‑limited (defaulting to **15 minutes**) and are
>   ignored by the controller once they expire.
> - **Timing‑safe comparison.** Tokens are compared with **`hash_equals()`**.
> - **Flood control.** Login‑link requests are rate‑limited — by default **50 per
>   hour per IP** and **5 per hour per user**.
> - **Reduced enumeration.** URLs use the account **UUID** rather than the numeric
>   user id, to mitigate user enumeration.
>
> The login route is intentionally open (`_access: TRUE`) because the **token
> itself is the credential** — exactly as with core's own password‑reset route.
> The residual risk is inherent to any magic link: once a link is emailed, account
> security reduces to **email‑account security plus link delivery**, so use a
> **TLS‑secured mail** path, serve login over **HTTPS**, and rely on the short
> expiry.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. No configuration is required.

There is **no configuration page** — the module is ready to go the moment it is
enabled.

## Where it lives in the admin menu

Magic Login Link adds no admin settings page. Its effect is on the login form at
`/user/login`, where a **"Login with Magic Link"** option appears.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the site can **send email** — the links are delivered using Drupal's
   default mail system. For reliable delivery over SMTP or an API (SendGrid,
   Mailgun, and so on), pair it with a mailer module such as **Symfony Mailer**.
3. Go to `/user/login`. Users enter their email or username, click **"Login with
   Magic Link"**, and receive a one‑time login URL.

### Recommended companions

- **Symfony Mailer** — for reliable, TLS‑secured email delivery of the links.
- **Flood Control** — while this module already throttles requests internally, the
  Flood Control module adds a UI to manage login‑attempt limits globally.
