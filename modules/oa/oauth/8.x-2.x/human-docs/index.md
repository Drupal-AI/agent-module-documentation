# OAuth 1.0 — manual setup guide

**OAuth 1.0** (`oauth`) implements the **OAuth 1.0a** standard for Drupal, acting
as an **authentication provider** so a third‑party consumer can act on a user's
behalf against your site's API. It is a support module: other modules and API
integrations that need OAuth 1.0a authentication build on top of it. On Drupal it
leverages the **OAuth PECL extension** to do the protocol work.

What makes OAuth 1.0a different from the more familiar OAuth 2.0 is worth
understanding rather than dismissing. Instead of bearer tokens, **every request is
signed** with a shared secret — so a captured request cannot simply be replayed,
and an intercepted token is not by itself usable. That design predates universal
TLS, and it is why 1.0a still shows up in some long‑lived **enterprise, financial
and government** integrations that specify it. If a partner system on the other end
requires OAuth 1.0a, a Drupal site being consumed by it needs to speak it — and that
is what this module is for.

**Honest positioning: this is a compatibility module, not a choice for new work.**
For a brand‑new integration, use **OAuth 2.0 with `simple_oauth`** instead — it is
simpler to implement correctly, has an active specification, and its one weakness
(bearer tokens being usable by whoever holds them) is answered by TLS everywhere,
now an assumption rather than an aspiration. Reach for OAuth 1.0a only when the
other side requires it.

The module provides two permissions — **access own consumers** and **oauth register
any consumers** — both restricted, which is appropriate since registering a consumer
is a grant of API access. For OAuth **2.0**, install the separate OAuth 2.0 /
`simple_oauth` module instead of this one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm the OAuth
   PECL extension, and enable the module.
2. [Configuration](configuration/index.md) — the admin form, consumer registration,
   and the permissions that gate it.

## Where it lives in the admin menu

The module's admin settings are at route `oauth.admin_form`. Consumer registration
and access are gated by the **access own consumers** and **oauth register any
consumers** permissions. See [Configuration](configuration/index.md).
