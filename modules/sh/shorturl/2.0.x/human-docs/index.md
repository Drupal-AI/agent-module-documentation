# Short URL — manual setup guide

**Short URL** (`shorturl`) is a full URL shortener built into your Drupal site. It
turns long links into short, tidy aliases on your own domain, generates QR codes for
them, tracks how often they are visited, and exposes a REST API so other systems can
create and expand links programmatically. It is the kind of tool you reach for when a
campaign, a printed poster, or a QR code needs a link that is short, memorable, and
under your control rather than a third party's.

Under the hood, each short URL is a content entity (a node) with one of three **slug
modes**: a custom vanity slug like `promo`, a random base36 slug like `k9m2x7`, or a
sequential auto-increment slug like `42`. Redirects are handled through the
**Redirect** module — they are created and kept in sync automatically whenever a short
URL is saved or deleted. Visits are counted by a lightweight HTTP middleware that
records the hit without a full Drupal bootstrap on cached requests, so tracking stays
fast, and each short URL node gets a statistics dashboard with traffic charts,
referrer analysis, and country-of-origin mapping.

This module needs a little configuration to suit your site — how long random slugs
should be, which redirect status code to use, whether to track visits, and so on —
but it works sensibly out of the box once enabled. It ships granular permissions: you
control who may use each slug mode, who may view statistics, who may use the API, and
who may administer the whole thing. Optional extras include country detection via the
**Smart IP** module and multi-domain support via the separate **Domain Short URL**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies.
2. [Configuration](configuration/index.md) — the settings form, slug modes,
   permissions, the REST API, and QR codes.

## Where it lives in the admin menu

The settings form sits at **Configuration → Short URL settings**
(`/admin/config/shorturl/settings`). Short URLs themselves are managed through a
pre-configured admin listing (Views integration), and each short URL node carries its
own statistics dashboard.
