# JSON:API Security — manual setup guide

**JSON:API Security** (`jsonapi_security`) adds a layer of "secure by default"
hardening on top of Drupal core's JSON:API. Core already enforces entity and
field access, but on a decoupled or API-exposed site you often want firmer,
global guardrails than the per-resource defaults provide. This module supplies
that policy layer: query limits, collection-access restrictions, an API-wide
read-only mode, and extra protection for the super-user account — with a separate
submodule for two-factor authentication.

It is a **security-positive** module. It only *adds* controls and audit logging;
it does not loosen anything. Think of it as complementing — not replacing — the
resource and field access you configure in core JSON:API (and modules like
JSON:API Extras). The protections it layers on are:

- **Query depth limiting** — caps how deeply `include` queries can chase
  relationship chains (default depth 2), with per-resource overrides for cases
  that legitimately need deeper nesting, such as menu hierarchies.
- **Collection access control** — an optional global switch that blocks the
  entity collection endpoints (for example `/jsonapi/user/user`) unless the
  requester could reach the matching administrative listing (like
  `/admin/people`), with configurable per-resource-and-role exceptions.
- **Strict read-only mode** — an optional switch that rejects `POST`, `PATCH`,
  and `DELETE` with `405 Method Not Allowed`, plus an allowlist for the specific
  resources and methods you do want to accept writes.
- **UID 1 (super-user) protection** — by default hides UID 1's data over
  JSON:API (returning `404`) and blocks basic-auth login as UID 1 (returning
  `401`), each overridable from `settings.php`.
- **Two-factor integration** — the optional `jsonapi_security_tfa` submodule
  requires users to have TFA enabled before they can use JSON:API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally add the two-factor submodule.
2. [Configuration](configuration/index.md) — the policy switches (query depth,
   collection access, read-only mode) and the `settings.php` options for UID 1.

## How to use it

Enable the module, then work through the policy settings to match your site's
exposure — start strict and open up specific resources through the exception
lists rather than the other way around. Keep the security logging somewhere you
can monitor it, and remember these controls sit *on top of* proper JSON:API
resource and field configuration; they are a safety net, not a substitute for it.
