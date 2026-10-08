# Cloudflare Images — manual setup guide

**Cloudflare Images** (`cloudflare_images`) offloads your image files to the
**Cloudflare Images** product and rewrites their delivery URLs so they are served
from Cloudflare's global CDN (`imagedelivery.net`) instead of your own file
system. It is aimed at sites that already have a Cloudflare Images subscription
and want transparent CDN delivery, resizing and caching without changing how
editors author content.

It works quietly in the background. When an image‑bundle media entity is saved,
the module pushes the file to the Cloudflare Images API; when the entity is
deleted, it removes the image from Cloudflare too. At render time it rewrites
local image URLs to the Cloudflare delivery URL. Crucially, all of this only
happens when the current request host matches a **site host** you configure — so
you can limit the offloading to your live/production stage and leave local and
staging environments serving images normally.

A few limits are worth knowing before you rely on it. There is **no local
fallback**: if a Cloudflare URL is wrong or the asset is missing, the rewritten
URL simply 404s. Only the `public` image variant is served — signed/private URLs
and other variants are not configurable in this version. There is no admin screen
for browsing or bulk‑migrating already‑uploaded images; syncing happens
incrementally as entities are saved. And uploads run in a shutdown function, so a
failed upload won't block the entity save but also won't be surfaced to the editor.

> **Security note.** In this version the Cloudflare **API token is stored in plain
> module configuration** (`cloudflare_images.settings`), alongside the account hash.
> Treat your exported configuration as sensitive and review it before committing —
> it contains those secrets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form: site host, site
   name, account ID, account hash and API token.

## Where it lives in the admin menu

Configure it at **Configuration → Cloudflare Images → Settings**
(`/admin/config/cloudflare_images/settings`), which requires the **Administer site
configuration** permission.
