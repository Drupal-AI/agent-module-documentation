# Cloudflare Worker Purge — manual setup guide

**Cloudflare Worker Purge** (`cloudflare_worker_purge`) lets a site using the
**Purge** module send its cache‑invalidation requests to a **custom Cloudflare
Worker** rather than to Cloudflare's Purge API directly. The point of doing this
is to enable purging **by cache tag without a Cloudflare Enterprise account** —
the Worker (for example the "Cache Tag" Worker) handles the tag‑based
invalidation that the standard API otherwise reserves for Enterprise plans.

Behind Cloudflare, changed content has to be cleared from the edge, and this
module fits into the Purge pipeline to make that happen through your Worker. One
technical quirk to be aware of: Cloudflare strips the `Cache-Tag` header before it
reaches a Worker, so this module renames it to **`X-Cache-Tag`** so the Worker can
read it.

> **This module is obsolete and unsupported.** Its development status is *Obsolete*
> and it is no longer maintained. For new work, prefer the actively maintained
> [Cloudflare Purger](../../cloudflare_purger/1.0.x/human-docs/index.md), which
> integrates cache‑tag purging with the Purge module directly. Only use Cloudflare
> Worker Purge if you specifically need the Worker‑based approach on a non‑Enterprise
> plan.

It needs **Cloudflare credentials** (an API token and your Worker configuration).
A Cloudflare token can purge — and, depending on its scope, reconfigure — your
CDN, so keep it out of plain configuration (use an environment variable or Key
entity) and scope it as narrowly as possible.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** documented for this module; it operates
within the Purge module's pipeline and needs your Worker and Cloudflare
credentials. See "How to set it up" below.

## How to set it up

1. Deploy a Cloudflare **Worker** that performs cache‑tag purging (such as the
   Cache Tag Worker) on your zone.
2. Enable this module alongside the **Purge** module and configure Purge to use
   it, so Drupal's invalidations are sent to your Worker. Remember the header is
   sent as **`X-Cache-Tag`** (Cloudflare strips the original `Cache-Tag` header
   before the Worker sees it), so your Worker must read `X-Cache-Tag`.
3. Provide the Cloudflare credentials the module needs. Keep the API token in an
   environment variable or a Key entity rather than plain config, and scope it to
   the minimum required — a token that can purge your CDN is sensitive.

Because the module is obsolete, weigh moving to
[Cloudflare Purger](../../cloudflare_purger/1.0.x/human-docs/index.md) before
investing in this approach.
