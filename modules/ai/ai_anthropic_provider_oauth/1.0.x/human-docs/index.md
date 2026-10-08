# AI Anthropic Provider (OAuth) — manual setup guide

**AI Anthropic Provider (OAuth)** (`ai_anthropic_provider_oauth`) lets the Drupal
**AI** module talk to Anthropic's Claude models using an **OAuth setup token**
instead of a normal API key. The token is the kind produced locally by the
`claude setup-token` command, which makes this a convenient way to wire up Claude
during development without provisioning a full API key.

It is explicitly a **development / personal‑use** provider. The module's own
description warns that third‑party use of setup tokens may violate Anthropic's
Terms of Service, and recommends the official **`ai_provider_anthropic`** module
for production sites. Reach for this one only for local experimentation.

The setup token is a credential and must be treated like one. It is stored through
the **Key** module (a hard dependency), backed by an environment variable — never
hard‑coded, never committed, and kept out of your configuration export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, store
   the setup token securely, enable it, and select it in the AI module.

## Where it lives in the admin menu

This module has no settings page of its own. It registers an Anthropic provider
inside the **AI** module, so you select and use it from the AI module's provider
settings (**Configuration → AI**), pointing it at the Key that holds your setup
token.

## How to use it

1. Generate a setup token locally with `claude setup-token`.
2. Store that token in an environment variable and wrap it in a **Key** entity
   (see [Installation](installation/index.md) for the exact steps).
3. In the AI module's settings, choose this OAuth Anthropic provider for the
   operations you want (for example chat) and point it at your Key.
4. Keep it to development environments — switch to `ai_provider_anthropic` for
   production.
