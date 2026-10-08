# Cloudflare AI Gateway — manual setup guide

**Cloudflare AI Gateway** (`cloudflare_ai_gateway`) was a Drupal client for the
Cloudflare AI Gateway: it stored each gateway as configuration, built the
gateway's request URLs and `cf-aig-*` control headers, and exposed its live model
catalogue.

> **This project is obsolete and no longer maintained separately.** Its code has
> been consolidated — moved in unchanged — into the broader **Cloudflare AI**
> module, which also adds the other Cloudflare AI‑group resources (Vectorize, a
> vector database for semantic search, and AI Search, a managed
> retrieval‑and‑generation pipeline). **Install Cloudflare AI instead.**

For any new site, do not install this module. Use
[Cloudflare AI](../../cloudflare_ai/1.0.x/human-docs/index.md), whose guide covers
installation and configuration in full. The gateway configuration entity and the
AI provider it powers are unchanged in Cloudflare AI, so the **Cloudflare AI
Gateway Provider** keeps working once its dependency points at Cloudflare AI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — why you should not install this, and
   what to install instead.

There is **no configuration page** documented here: all functionality, including
configuration, now lives in the Cloudflare AI module.

## What to do instead

Require Cloudflare AI:

```bash
composer require drupal/cloudflare_ai
```

Then follow the [Cloudflare AI manual setup
guide](../../cloudflare_ai/1.0.x/human-docs/index.md) to add a credential set and
your AI Gateway (and, if you want them, Vectorize and AI Search resources).
