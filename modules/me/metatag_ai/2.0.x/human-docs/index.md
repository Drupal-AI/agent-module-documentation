# Metatag AI Generator — manual setup guide

**Metatag AI Generator** (`metatag_ai`) adds a **"Generate Metatag"** button to
the node edit form. When an editor clicks it, the module sends the node's title
and body to an AI provider and asks it to write SEO metadata — a meta title,
description, abstract, and keywords — then drops those values straight into the
node's Metatag field. The editor reviews them and saves the node as usual.

The module is a bridge between two other projects: it uses the **AI** module to
talk to a chat provider (OpenAI, Anthropic, or any provider you've configured in
AI), and it writes into a field supplied by the **Metatag** module. Because of
that, the button only appears once you have an AI provider set up and running,
the node's content type has been opted in, and the current user holds the right
permission. You control which content types get the button, which Metatag field
to populate, and — per interface language — the system prompt the AI is given, so
multilingual sites can generate metadata tuned to each language.

Everything is admin‑controlled: the prompts, the provider/model choice, and the
content‑type selection all live in one settings form. A developer can also call
the generator service directly from code to produce or save metadata
programmatically.

> **About the AI key.** This module doesn't ask you for an API key — the AI
> module owns that. Following this project's convention, store the provider's key
> in an environment variable and reference it from a **Key** entity (or directly
> from settings), then configure the provider under **Configuration → AI**. Never
> hard‑code or commit an API key.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — choose content types, the Metatag
   field, an AI provider, and the per‑language system prompt.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Metatag AI**
(`/admin/config/content/metatag-ai`). The AI provider it relies on is configured
separately under **Configuration → AI** (`/admin/config/ai`). The button itself
appears on the node add/edit form of any content type you enable.
