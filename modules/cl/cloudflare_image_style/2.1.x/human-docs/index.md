# Cloudflare Image Style — manual setup guide

**Cloudflare Image Style** (`cloudflare_image_style`) serves your styled images
from Cloudflare's image‑resizing CDN in production, while falling back to Drupal's
normal image styles on non‑production and local environments where the CDN is not
in play. It's aimed at the common situation where a live site sits behind
Cloudflare and you want the performance of Cloudflare's on‑the‑fly image resizing,
but you still need images to render locally where there is no CDN.

The clever part is that it works **per image style**. Cloudflare's resizing
service has a cost, so rather than pushing everything through it, you opt in one
image style at a time. For a style you have flagged, the module rewrites the
rendered image URL to Cloudflare's `/cdn-cgi/image/<effect>/…` form. On an
environment that isn't behind Cloudflare, the same URL is served locally: a path
processor and a fallback controller regenerate the derivative through Drupal's
normal image pipeline instead.

There is no central settings page — configuration lives **on each image style's
own edit form**, where the module adds two fields. It depends only on core's
**Image** module and needs no API keys of its own (the CDN itself is configured in
your Cloudflare account). One caveat: because the fallback regenerates
derivatives in PHP, it is a little heavier on non‑CDN environments — that's the
price of keeping images working everywhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the two fields the module adds to
   each image style's edit form.

## Where it lives in the admin menu

The module adds no page of its own. You configure it per style at **Configuration
→ Media → Image styles → *(a style)* → Edit**
(`/admin/config/media/image-styles/manage/<style>`).
