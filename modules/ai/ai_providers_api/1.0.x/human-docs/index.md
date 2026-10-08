# AI Providers API — manual setup guide

**AI Providers API** (`ai_providers_api`) is a **provider plugin system** — a
developer framework for defining and managing AI providers. It gives an
application a common plugin interface so it can register and use several AI
providers side by side, either separately from or alongside the core AI module's
own provider system. It was originally built for an LMS (learning management)
context, but the framework itself is general‑purpose.

This is plumbing for developers, not a click‑through feature. There is no
front‑end page and no ready‑made settings screen: a developer defines provider
plugins against the interface this module supplies, and the module manages
registering and selecting between them. If you are looking for a turnkey way to
add a specific vendor (OpenAI, Anthropic, Yandex, Zhipu, …), you probably want
that vendor's own provider module for the core AI framework instead.

Provider credentials used by plugins built on this API should be stored
securely — backed by an environment variable or secret store, never in plain
configuration. Administration of the provider system is gated by the
**`administer ai providers`** permission, so only trusted roles can manage it.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Because this module is a framework, "using it" means building on it:

1. **Install and enable** the module (see [Installation](installation/index.md)).
2. **Grant the permission.** At **People → Permissions**, give the
   *Administer AI providers* permission only to trusted administrative roles.
3. **Define provider plugins** in your own code against the interface this module
   exposes, storing each provider's credential in an environment variable rather
   than plain config.
4. **Register and select** providers through the common interface so your
   application can route AI calls to whichever provider it needs.
