# Tarte au citron - ClickDimensions — manual setup guide

**Tarte au citron - ClickDimensions** (`tarte_au_citron_clickdimensions`) is an
add-on for the **Tarte au citron** cookie-consent manager that registers
**ClickDimensions** — a Microsoft Dynamics marketing/tracking service — as a
consent-gated service. With it enabled and configured, the ClickDimensions tracking
script only loads once a visitor accepts it in the Tarte au citron banner, so your
site stays compliant with GDPR/cookie-consent rules for that tracker.

Under the hood the module provides a single Tarte au citron service plugin
(`ClickDimensions`). Its settings add two fields — a required **Account key** and
an optional **Domain** — which are stored in Tarte au citron's service
configuration and passed to the front-end tracking library. The module itself
declares no routes, permissions, or config schema of its own: all the storage,
consent handling, and the settings screen live in the parent Tarte au citron
module. It depends on the **Tarte au citron** module.

Because the account key and domain are entered by administrators (who already
control the site's JavaScript), the values injected into the tracking script are
trusted configuration, not visitor input — so this is not an added XSS surface
beyond what an administrator can already do.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its Tarte au citron dependency.
2. [Configuration](configuration/index.md) — enabling the ClickDimensions service
   and entering the account key and domain.

## Where it lives in the admin menu

This add-on has no page of its own. You enable and configure the ClickDimensions
service from the parent module's services screen at
**Configuration → Tarte au citron → Services**
(`/admin/config/tarte_au_citron/services`).
