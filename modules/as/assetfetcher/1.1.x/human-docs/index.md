# Asset Fetcher — manual setup guide

**Asset Fetcher** (`assetfetcher`) downloads external front‑end libraries and
**hosts them locally** instead of loading them from third‑party CDNs. When your
site (or a module) would otherwise pull a JavaScript or CSS library from a CDN,
Asset Fetcher grabs a local copy and serves that, so pages no longer make calls
out to external hosts.

There are two reasons to want this. The first is **privacy**: with the libraries
served from your own domain, visitors' browsers stop contacting third‑party CDNs,
which removes a set of external requests (and the tracking/logging that can come
with them). The second is **integrity**: the module works with Sub‑Resource
Integrity (SRI), computing SRI hashes so the assets that get served are verified.
Note that it computes those hashes over the **local files it has fetched**, not
over arbitrary user‑supplied URLs.

A word on what it fetches. Asset Fetcher retrieves the library files that Drupal's
asset/library definitions point at — so the outbound requests it makes go to those
defined library sources, not to addresses a site visitor can choose. That keeps
the egress predictable rather than open‑ended. Even so, it is a tool that makes
your server download files from the internet, so run it in an environment where
that outbound access is expected, and be aware of where the libraries are being
fetched from. It is a performance / privacy / developer tool with no content or
access role of its own, and it supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, it fetches the external libraries used by your site and
serves the local copies in their place, verifying them with SRI. Because it needs
to download from the internet, run the fetch on an environment with outbound
access; grant the module's permission only to the administrators who should manage
it. Confirm the result by checking that pages load their libraries from your own
domain rather than an external CDN.
