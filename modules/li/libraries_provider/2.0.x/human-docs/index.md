# Libraries Provider — manual setup guide

**Libraries Provider** (`libraries_provider`) moves the decision about *how* an
external JavaScript or CSS library is served out of the module author's hands and
into the **site's** hands. Rather than accepting whatever a module or theme
hard‑coded — a particular CDN, a particular version — you get to choose: load from
a CDN, load a local copy, pin a specific version, switch a variant, or swap one
library out for a replacement.

Why does that choice matter? Loading a library from a **CDN** is convenient, but
it means every page load depends on a third party being reachable, sends your
visitors' IP addresses to that host, and needs a Content Security Policy
allowance. Loading a **local copy** is right for privacy and air‑gapped or
restricted networks, but it makes you responsible for placing the files and
keeping them updated. Neither answer is universally correct — which is exactly why
it should be a site decision.

Be aware that this is not a featherweight. Libraries Provider depends on two
architectural modules in their own right — **Hook Event Dispatcher** and
**Autoservices** — so it brings more than its own weight. It's worth reaching for
when you have a concrete requirement: a **CSP** that must enumerate hosts, a
**privacy/GDPR** position that forbids third‑party requests, or an **offline or
restricted network** where a CDN is unreachable. If none of those applies, core's
`libraries-override` in a theme handles the occasional single case with far less
machinery.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (required — it
   pulls external PHP libraries), enable it, and turn on the optional UI.
2. [Configuration](configuration/index.md) — declaring libraries in YAML, the
   per‑library options, and the point‑and‑click interface.

## Where it lives in the admin menu

The base module works from your `*.libraries.yml` declarations. The optional
**Libraries Provider UI** submodule (`libraries_provider_ui`) adds an
administrative interface for changing each library's source, version, and variant
without editing YAML — see [Configuration](configuration/index.md).

## How to use it

1. Enable the module (and the UI submodule if you want the interface).
2. In a module or theme's `*.libraries.yml`, add a `libraries_provider` section to
   the library you want the site to control (which source, which npm package,
   which version).
3. Attach that library from a module or theme as usual. Enabling a library in
   Libraries Provider does **not** load it everywhere — it still only loads on
   pages where something attaches it.
4. Use the UI (or edit the YAML) to switch a library from CDN to local, pin a
   version, or point it at a replacement.
