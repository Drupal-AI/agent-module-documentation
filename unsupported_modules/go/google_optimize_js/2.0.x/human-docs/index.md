# Google Optimize JS — manual setup guide

**Google Optimize JS** (`google_optimize_js`) conditionally injects the Google
Optimize `optimize.js` snippet into the page head on the pages you choose, so you can
run Google Optimize A/B tests and experiments on a Drupal site. It was designed as a
lightweight drop‑in for sites that load Google Analytics through Tag Manager and saw
unacceptable page flickering even with the anti‑flicker snippet — attaching
`optimize.js` directly in the head helps address that.

Behind the scenes an inclusion service decides, per request, whether the snippet
should be attached, using the current path, path alias, path matcher and admin‑route
context against the container ID and page‑visibility rules you configure. It depends
only on core's **Path alias** module.

> **Deprecated — Google Optimize was sunset on 30 September 2023.** The product no
> longer exists, so this module is no longer recommended, maintained, or supported,
> and the maintainers advise uninstalling it. This guide is kept for reference and
> for anyone maintaining an existing installation; do not adopt it for new work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (for reference / existing sites only).
2. [Configuration](configuration/index.md) — set the container ID and choose which
   paths get the snippet.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Google Optimize**
(`/admin/config/system/google_optimize`), gated by the **Administer Google Optimize**
permission. That permission controls only *who can configure the snippet* — it does
not restrict content. Because the snippet runs client‑side, treat the container ID as
public.
