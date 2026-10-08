# One Time Login — manual setup guide

**One Time Login** (`onetimelogin`) lets permitted administrators generate
secure, single‑use, expiring login links for users — a link someone can click to
log in without a password, for onboarding, support access, or account recovery.
Beyond the admin UI it also offers a full REST API, Drush commands, an OpenAPI/
Swagger interface, usage statistics, and the ability to revoke outstanding links,
so it suits both click‑through and programmatic workflows.

It is built the right way, on top of Drupal core's own mechanism: each login
token is produced with core's `user_pass_rehash()` — the same cryptographically
strong, user‑specific token core uses for its password‑reset and one‑time‑login
links — and the module wraps it with a short URL (`/s/{hash}`), IP binding, an
expiry, single‑use enforcement, and revocation. A security review found this a
sound, security‑conscious implementation.

The generation side is well‑guarded: it requires the **`access one-time login`**
permission, validates that the target account is active, checks a CSRF token,
applies **rate limiting** per user and IP to curb abuse, and logs each attempt
with its IP for an audit trail.

**What to keep in mind when adopting it.** Generating a login link is, in effect,
the power to log in *as* another user, so:

- **Restrict the `access one-time login` permission tightly** — grant it only to
  fully trusted staff.
- **Keep the expiry short**, so a leaked link is useful for as little time as
  possible.
- **Treat generated links as sensitive bearer credentials** — whoever holds a
  link can log in as that user until it expires or is used.
- **Use revocation** to invalidate any link you no longer want outstanding.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set expiration, single‑use, rate
   limits, and optional email delivery, and grant the permission carefully.

## Where it lives in the admin menu

The settings form is registered as `onetimelogin.settings` — reach it from the
**Extend** page (**Configure** next to *One Time Login*) or the **Configuration**
section of the admin menu. Generate links from a contextual link on user
profiles, from the REST API, or with the Drush commands below. Interactive API
docs live at `/api/docs/onetimelogin` and the OpenAPI spec at
`/api/v1/onetimelogin/openapi.json`.

## How to use it

- **From the UI:** open a user's profile and use the one‑time‑login contextual
  link to generate a URL (permission‑gated).
- **From Drush:** `drush otl:generate`, `drush otl:check`, `drush otl:revoke`,
  `drush otl:statistics`.
- **From the API:** the generate, check, revoke, list, and statistics endpoints,
  documented via the Swagger UI above.

Deliver generated links over a secure channel, and revoke any that are no longer
needed.
