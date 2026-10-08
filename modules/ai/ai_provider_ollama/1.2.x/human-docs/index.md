# Ollama Provider — manual setup guide

**Ollama Provider** (`ai_provider_ollama`) connects Drupal's **AI** module to a
local or self‑hosted [Ollama](https://ollama.com) server, so AI operations —
chat, embeddings, and content moderation — run against models on your own
hardware instead of a hosted, pay‑per‑token API. That keeps prompt content on
your own infrastructure, which is useful for data‑residency and GDPR constraints,
for cutting API costs during development, and for running AI features in
environments without internet access.

Once installed it registers an *Ollama* provider inside the AI module. You then
point it at your Ollama server with just a **host name** and **port** — there is
no API key. Ollama exposes an OpenAI‑compatible endpoint, so chat and embeddings
reuse the AI module's standard client, while a small internal service talks to
Ollama's native API to list the models you have pulled. In the AI module's model
table you map each operation type (chat, embeddings, moderation) to whichever
local model you want.

A few specifics worth knowing:

- **Connecting from DDEV/Docker.** When Drupal runs in a container and Ollama runs
  on your host machine, set the host to `http://host.docker.internal` and make
  sure Ollama listens beyond localhost (`OLLAMA_HOST=0.0.0.0:11434 ollama serve`).
- **No authentication.** The provider has no API key concept —
  `hasAuthentication()` is false. Anything that can reach the Ollama host/port can
  use the models, so **the network boundary is the entire access control**.
- **Moderation is model‑specific.** Only **Llama Guard 3** (`llama-guard3`) and
  **ShieldGemma** (`shieldgemma`) are supported for moderation; any other model
  throws "Model not supported for moderation."

It requires the **AI** module (`drupal/ai ^1.2.0`) and Drupal 10.2+ or 11. It adds
no permissions of its own — the settings form reuses the AI module's *Administer
AI providers* permission. This installed version is 1.2.0‑rc3.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI module.
2. [Configuration](configuration/index.md) — point Drupal at your Ollama server,
   including the DDEV/Docker case, and choose your models.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → Providers → Ollama**
(`/admin/config/ai/providers/ollama`). After configuring it, set the default
provider and model per operation type in the AI module's own settings at
**Configuration → AI → Settings** (`/admin/config/ai/settings`).
