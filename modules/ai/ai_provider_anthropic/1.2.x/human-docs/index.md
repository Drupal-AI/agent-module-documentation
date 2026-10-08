# Anthropic Provider — manual setup guide

**Anthropic Provider** (`ai_provider_anthropic`) is the Anthropic (Claude) plugin
for the **AI** (AI Core) module. It registers Anthropic as an AI provider so
Drupal can call Anthropic's API for chat and text generation with Claude models —
anywhere AI Core needs a chat model, such as the AI Chatbot, AI CKEditor
integration, automators, and AI Agents. It is part of the wider **AI** ecosystem
and only makes sense installed alongside AI Core; you never call it directly, you
go through AI Core's provider service so the vendor choice stays config‑driven.

The module supports exactly one operation type — **chat** — so Claude is available
for chat, chat with image vision, tool/function calling, and structured‑JSON
responses, but not for embeddings, image generation, or speech. You authenticate
by selecting a **Key** entity (from the Key module) on the settings form; only the
Key's id is stored in configuration, never the raw API key. The list of available
Claude models is fetched live from Anthropic and cached, so new model releases
appear automatically. When you save your key, the module also seeds sensible AI
Core defaults — pointing chat and vision at a Claude Sonnet model and the complex
JSON / tool‑calling / structured‑response operations at a Claude Opus model — but
only for operation types that don't already have a provider.

One thing to plan for: Anthropic has no built‑in content moderation. The settings
form lets you route each prompt through OpenAI's moderation (via the AI External
Moderation module) instead, and if you choose to run without moderation it makes
you explicitly acknowledge that doing so risks getting your account banned. The
module depends on the **AI** module (`^1.2.0`) and the **Key** module (`^1.18`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the provider
plugin, model handling, and calling Claude from code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (which
   pulls in AI Core and Key) and enable it.
2. [Configuration](configuration/index.md) — create the API Key, fill in the
   settings form, handle moderation, and make Anthropic your default provider.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → AI Providers → Anthropic
Authentication** (`/admin/config/ai/providers/anthropic`). You choose which
provider and model AI Core uses per operation type on AI Core's own settings form
at **Configuration → AI → Settings** (`/admin/config/ai/settings`).

## How to use it

Create a Key entity holding your Anthropic API key, select it on the Anthropic
settings form, decide on moderation, and then set Anthropic as the default
provider in AI Core. The full walkthrough is on the
[Configuration](configuration/index.md) page.
