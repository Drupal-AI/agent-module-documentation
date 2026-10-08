# Decoupled Cookie Auth — manual setup guide

**Decoupled Cookie Auth** (`decoupled_cookie_auth`) smooths over the rough edges
you hit when a **decoupled (headless) front end** uses Drupal's **cookie
(session) authentication** rather than tokens. When your JavaScript front end and
your Drupal backend live on related domains and share a session cookie, several of
Drupal's built‑in flows — registration, login redirects, and the password‑reset
journey — assume a traditional, Drupal‑rendered site. This module rewires those
flows so they land on your front end instead.

For the browser to exchange the session cookie between the two, Drupal should be
hosted on a **subdomain of the front end**. For example, with a front end at
`https://www.myfrontend.com`, Drupal would live at something like
`https://app.myfrontend.com`, and you set a shared `cookie_domain` (such as
`.myfrontend.com`) in your `services.*.yml`.

Once configured, the module: automatically logs a user in after they register via
the core JSON user‑registration endpoint (provided email verification is off);
redirects the password‑reset one‑time‑login journey to your front end's
password‑reset page, passing the `pass-reset-token` along; handles the
"already logged in" and "account blocked" edge cases by redirecting to your front
end with a query flag; redirects password‑reset‑request URLs to their front‑end
counterparts; and rewrites the `[site:login-url]` token (used in welcome emails)
to point at your front‑end login page. It can also enable **email‑only
registration**, auto‑generating a unique username from the email address so your
front end can register users with just an email and password. Every one of these
behaviours is covered by the module's own tests, and its privileged actions are
constrained to the current user's own account and to core's registration route —
it makes no external HTTP calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form for your front
   end's domain and paths, plus the `services.*.yml` cookie‑domain step and the
   related REST/mail_login setup.

## Where it lives in the admin menu

The module's settings form is at
**`/admin/config/decoupled_cookie_auth/configuration`** (it requires the
**Administer site configuration** permission). See
[Configuration](configuration/index.md) for the full walkthrough, including the
`services.*.yml` change that the admin form cannot make for you.
