# Cloudflare AI — manual setup guide

**Cloudflare AI** (`cloudflare_ai`) makes Cloudflare's AI‑group services
first‑class, provisionable resources inside Drupal and provides the clients to use
them. Cloudflare's AI group is a set of hosted building blocks: an **AI Gateway**
that sits in front of AI providers and adds caching, logging, cost analytics and
fallbacks; and **Vectorize**, a vector database for semantic search. This module
is the layer that lets Drupal provision and talk to them.

> **This release (1.0.0‑alpha3) ships the AI Gateway and Vectorize** resources
> only. Cloudflare's AI Search (formerly AutoRAG) is part of the project's broader
> vision but is **not** provided by this version — there is no AI Search entity,
> client or menu item in the code you install here.

It's most often used as the foundation for the **Cloudflare AI Gateway
Provider**, which connects the gateway to the Drupal AI module so every AI feature
on your site can route through Cloudflare. But its Vectorize client can also be
called directly from your own code. Each resource — a gateway, a Vectorize index —
becomes a configuration entity that other modules can reference.

This module has **no user‑facing AI features on its own** — it provides the
clients and the configuration that other modules (or your code) build on. It
depends on the [Cloudflare SDK](../../cloudflare_sdk/1.0.x/human-docs/index.md)
and [Cloudflare API](../../cloudflare_api/1.0.x/human-docs/index.md) modules: the
SDK provides the credential framework and shared HTTP client, and the API module
is the standalone Cloudflare v4 client this module calls. Credentials (account ID
and token) are resolved from `settings.php` through the SDK and are **never stored
in configuration**. Note that Workers AI needs no configuration here — it is
stateless inference reached through the AI Gateway, not a resource you provision.

> **Note:** This module absorbed the former standalone *Cloudflare AI Gateway*
> module, which is now obsolete. If you were using that module, move to this one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with its SDK and
   API dependencies) with Composer and enable it.
2. [Configuration](configuration/index.md) — add a credential set, then add AI
   Gateway and Vectorize resources.

## Where it lives in the admin menu

The resources live under **Configuration → Web services**: *Cloudflare AI
Gateways* and *Cloudflare Vectorize*. Credential sets themselves are managed by the
Cloudflare SDK at **Configuration → Web services → Cloudflare credentials**.
