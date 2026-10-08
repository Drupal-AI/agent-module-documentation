# GDPR One Trust Implementation — manual setup guide

**GDPR One Trust Implementation** (`gdpr_onetrust`) embeds the **OneTrust** consent
banner into your Drupal site and, through its **`onetrust_cookie_blocking`**
submodule, holds tracking scripts back until the visitor has consented to the
relevant category. OneTrust is the enterprise consent product: organisations that
have bought it usually already have a legal team, a cookie register, and a scanning
schedule built around it, and they expect Drupal to slot in. You provide the
OneTrust account identifier and the module renders that account's banner.

Consent is really two jobs, and this matters:

1. **Show a banner and record the choice** — the visible half.
2. **Not load the tracker until the answer is yes** — the half that actually
   determines compliance. A banner over an analytics script that has already fired
   collects consent for something that already happened. **The blocking submodule
   is the part worth having.**

Two things to verify rather than assume:

- **Which scripts are actually blocked.** Anything a theme or another module attaches
  through Drupal's own asset system is *not* governed by the blocker unless it's
  deliberately wired in.
- **Caching.** A consent decision is per‑visitor, but a page cached with a script
  tag baked into it will serve that script to everyone. Check your caching setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and add the blocking submodule.
2. [Configuration](configuration/index.md) — enter your OneTrust identifier.

## Where it lives in the admin menu

The settings form is at **Configuration → System → GDPR OneTrust**
(`/admin/config/system/gdpr-onetrust`). Access is gated by a permission spelled
**`One Trust Access`** (with a space and capitals — unusual for a permission
machine name, and worth knowing if you write a role's config by hand).
