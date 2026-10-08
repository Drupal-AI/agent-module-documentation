# OpenAI Core — manual setup guide

**OpenAI Core** (`openai`) is the base integration for the OpenAI API — ChatGPT/GPT,
DALL·E, Whisper, embeddings, and moderation — in Drupal. On its own it is mostly
*plumbing*: it stores your OpenAI **API key** (and optional organization ID), wraps
the `openai-php/client` PHP library in a single reusable `openai.api` service, and
provides the shared client that every feature builds on. The actual editor tools and
integrations come from a family of submodules that sit on top of that service.

The `openai.api` service exposes typed methods over the API — listing models, chat
and legacy completions (both support streaming), DALL·E image generation,
text‑to‑speech and Whisper speech‑to‑text, a moderation check that returns a simple
flag, and embeddings. A small `StringHelper::prepareText()` utility cleans HTML and
truncates text before it is sent as a prompt to save tokens. If you install this
module but never add a key, an event subscriber warns administrators on admin pages
so features do not silently fail.

Eleven submodules provide the features: **OpenAI Content** (node‑form content tools),
**OpenAI CKEditor** (in‑editor completion), **OpenAI ChatGPT** and **OpenAI Prompt**
(explorer forms), **OpenAI DALL·E** (image generation), **OpenAI Audio** and **OpenAI
TTS** (speech), **OpenAI Embeddings** (vector search with Milvus/Pinecone), **OpenAI
DBLog** (AI log analysis), **OpenAI ECA** (workflow actions), and **OpenAI Devel**
(demo content generation). Enable just the ones you need.

OpenAI Core requires the `openai-php/client` library (installed by Composer) and
works on Drupal 10 and 11.

> **You will need an OpenAI API key.** Treat it as a secret. The module stores the
> key in ordinary Drupal configuration and does **not** use a Key entity, so for any
> real deployment you should keep the key out of exported config and inject it from
> the environment — see [Configuration](configuration/index.md) for how.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the OpenAI PHP
   client with Composer, then enable it and the submodules you want.
2. [Configuration](configuration/index.md) — entering (or securely injecting) your
   API key and organization ID, and the admin routes.

## Where it lives in the admin menu

The API settings form is at **Configuration → OpenAI → Settings**
(`/admin/config/openai/settings`), gated by the **Administer site configuration**
permission. A **Models** page and a link to OpenAI's documentation sit alongside it.

## How to use it

1. Get an API key from OpenAI.
2. Configure it on the settings form (or, better, inject it from the environment —
   see Configuration).
3. Enable the submodule(s) that provide the features you actually want — each adds
   its own routes, permissions, and forms on top of the shared `openai.api` service.

Developers can call `openai.api` directly from custom code to run chat, generate
embeddings, moderate content, and more. See [Configuration](configuration/index.md)
to get set up.
