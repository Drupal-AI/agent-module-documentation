# Site Version info — manual setup guide

**Site Version info** (`site_version`) lets you record a site's version number,
build number and a free‑text description, and then surface that information in two
places: on an admin‑viewable page at `/site-version`, and — optionally — through a
JSON endpoint that external tooling can poll. It is a simple, lightweight way to
answer "which build is this environment running?" for release management or an
external dashboard.

The typical use is deployment tracking. You set the version and build by hand (or
as part of a deploy process) on the settings form, and anyone with the right
permission can then read them on the page, while a dashboard or monitoring tool
can read the same data as JSON. The module also records the site's UUID and a
"changed" timestamp each time you save, and can register this site's endpoint with
a remote host so a central dashboard can discover it — this pairs with the
companion *Site Version Host* module for managing many sites in one place.

The module needs configuration to be useful: on install it generates a random
32‑character JSON API key and records the site UUID, but the version, build and
description are yours to fill in, and the JSON API is **disabled by default**. It
has no module dependencies of its own and no submodules.

A note on the JSON endpoint's security, because it is worth understanding: the
route at `/site-version/json` is technically reachable anonymously, but it returns
data **only** when the JSON API is enabled *and* the caller supplies an `api_key`
that exactly matches the stored 32‑character key — otherwise it returns an error
object. The disclosed fields (version, build, description, site name, UUID, core
version) are low‑sensitivity, but treat the API key as a secret and only hand it to
tooling you trust.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the version, build and
   description, and manage the JSON API and host registration.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Site Version**
(`/admin/config/system/site-version`), behind the `site_version admin`
permission. A companion **Host Auto Configuration** form lives at
`/admin/config/system/site-version/host-autoconfig`. The public version table is
at `/site-version` and is gated by the `site_version view` permission.
