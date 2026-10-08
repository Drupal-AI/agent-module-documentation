# Cloudflare API — manual setup guide

**Cloudflare API** (`cloudflare_api`) is a lightweight, standalone client for the
Cloudflare v4 management API (`api.cloudflare.com/client/v4`). It is a developer
building block, not a feature you configure through the UI: it authenticates with
a Cloudflare account ID and API token, depends only on the PSR HTTP interfaces,
and has no other module dependencies.

It exists as the foundation of a small Cloudflare module suite. Other modules —
the [Cloudflare SDK](../../cloudflare_sdk/1.0.x/human-docs/index.md), the
Cloudflare AI Gateway client, and the AI Gateway Provider — build on top of it.
You normally install it because one of those modules requires it, rather than on
its own.

Because it is a typed HTTP client library, **there is no settings page and no
admin UI**. Credentials are supplied in code (or, more usually, by the higher‑level
Cloudflare SDK, which resolves them from `settings.php` / environment variables) —
they are never committed to configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it is a client library with
no settings form. In practice you use it through the Cloudflare SDK, which
provides the credential model described in that module's guide.

## How to use it

Cloudflare API provides a typed client class you call from PHP, giving it an
account ID and an API token. On its own it does nothing visible; it becomes useful
when a feature module (or your own code) calls it to talk to Cloudflare. If you
are setting up a Cloudflare feature such as AI Gateway or Vectorize, follow that
module's guide — it will pull this client in automatically and hand it credentials
through the Cloudflare SDK.
