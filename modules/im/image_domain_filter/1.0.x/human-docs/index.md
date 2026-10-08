# Image Domain Filter — manual setup guide

**Image Domain Filter** (`image_domain_filter`) adds a **"Restrict images to
trusted sites" text filter** that limits which hosts an embedded `<img>` may load
from. You give it a list of allowed domains, enable it on the text formats used for
untrusted input, and images from any other host are no longer permitted in that
filtered text.

Drupal core already ships a *Restrict images to this site* filter, but that one only
allows images hosted on your own site — which breaks the moment you serve
user-uploaded files off-site through a CDN, S3, or Cloudflare. Image Domain Filter
fills that gap: it lets you keep the security benefit of an allowlist while still
allowing images from the specific external hosts you trust. In doing so it helps
mitigate tracking pixels, mixed-content warnings, and unwanted third-party image
inclusion in user-generated content.

Note this is a **defensive filter, not a fetcher** — it inspects and restricts image
URLs in text; it never downloads the images server-side, so it introduces no
server-side request risk of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enable the filter on a text format and
   set your list of trusted image hosts.

## Where it lives in the admin menu

There is no standalone settings page. Like all Drupal text filters, this one is
configured **per text format** under **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`), where you enable it and
enter the host allowlist.
