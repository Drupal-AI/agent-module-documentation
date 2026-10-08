# Protected Pages Extra — manual setup guide

**Protected Pages Extra** (`protected_pages_extra`) lets administrators require a
password to view any path on the site — a single page, several pages under one
password, or whole sections via wildcards such as `/news/*`. A visitor who doesn't know
the password is redirected to a login form instead of seeing the content. It is a
modern, config‑entity and HTTP‑middleware reimplementation of the classic Protected
Pages module.

Each protected page is a **config entity**, so your protection is exportable with
`drush cex` and survives deployments. Enforcement runs in an HTTP middleware that
normalizes the request path (handling language prefixes and URL aliases) and matches it
against your entries — exact internal path first, then alias, then wildcards. Unlocks
are stored per session with a configurable expiry, and you can choose a **per‑page
password, a global password, or either**.

The 1.2.x branch adds serious hardening and convenience over a basic password gate:
**brute‑force rate limiting** on two axes (per‑IP and per‑page‑per‑IP) with a
configurable **IP allowlist**; **email notifications** with URL and wildcard tokens;
**config_translation** support for login and email strings; correct **cache handling**
(protected responses are marked `private, no-store` and cached pages are evicted when a
path becomes protected); and a **one‑step migration** from the legacy `protected_pages`
module.

Protection is an admin‑configured gate that works independently of Drupal's
role/permission access. It is governed by granular permissions, of which
`bypass protected page access check` is the most sensitive — grant it, and the
administration permissions, only to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add protected pages, choose password
   modes, tune flood control and the IP allowlist, and set the permissions.

## Where it lives in the admin menu

The overview and management screens are at **Configuration → System → Protected Pages
Extra** (`/admin/config/system/protected-pages-extra`), with a separate settings form
at `/admin/config/system/protected-pages-extra/settings`. Permissions are assigned on
**People → Permissions**. See [Configuration](configuration/index.md).
