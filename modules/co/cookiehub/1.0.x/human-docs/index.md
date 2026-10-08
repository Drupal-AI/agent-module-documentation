# Cookiehub — manual setup guide

**Cookiehub** (`cookiehub`) integrates the third‑party **CookieHub** cookie‑consent
service into your site. It injects the CookieHub loader script into every page's
`<head>` (except on paths you exclude), so the consent banner appears and, if you
turn it on, CookieHub's automatic cookie blocking holds scripts back until the
visitor consents. It also ships a **cookie‑declaration** field type, widget, and
formatter so an editor can place a cookie‑declaration block on a page (for example a
dedicated cookie‑policy page — note that CookieHub's declaration feature needs a
premium subscription).

The module does nothing until you configure it: you register an account at
cookiehub.com, add your domain, obtain your **8‑digit CookieHub code**, and enter it
on the settings form. From there you toggle the banner on, optionally enable
automatic cookie blocking, optionally switch on development mode, and list any paths
where the banner should be suppressed. Administration is gated by the dedicated
**`administer cookiehub configuration`** permission.

Because CookieHub is a **third‑party script loaded on nearly every page** (from
`cookiehub.net` or, in dev mode, `dash.cookiehub.com`), that origin is added to your
pages — allow it in any Content‑Security‑Policy you run. Your CookieHub code is a
plain 8‑digit account identifier (configuration), not a secret; keep it to that
format. As with any consent banner, real compliance depends on scripts actually
respecting consent — turn on automatic cookie blocking (or otherwise gate your
trackers) rather than relying on the banner alone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your CookieHub code and switch on
   the banner.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → Web services → Cookiehub**
(`/admin/config/services/cookiehub`).
