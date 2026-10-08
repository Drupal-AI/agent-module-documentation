# AI Model Registry — manual setup guide

**AI Model Registry** (`ai_model_registry`) is a Drupal-native **catalogue of AI
model information**. It gives your site one place to record what each
provider/model can do and what it costs — capabilities (chat, embeddings,
structured output, tool use, vision), price per 1,000 tokens, governance
attributes (data residency, whether inputs are used for training, a risk level),
lifecycle (an end-of-life date), whether the model is self-hosted, and any extra
free-form metadata. Each entry is a configuration entity describing one
provider/model pair, keyed as `provider_id__model_id`.

The point is to stop other modules from hard-coding provider details. Governance,
routing, budget, and dashboard modules — for example **AI Policy Gateway** — read
this catalogue instead of maintaining their own list, so there is a single source
of truth. A repository service normalises every record into a predictable shape,
and a plugin type (**ModelMetadataAdapter**) lets you feed entries from an
external source such as a remote gateway, a provider API, or a spreadsheet
without editing this module.

It is deliberately standalone and safe: it stores metadata only. It never calls a
provider and holds no API keys, and managing the catalogue is restricted to
administrators. Four seed entries (OpenAI, two Ollama, LM Studio) ship as default
configuration to get you started.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the model catalogue entity UI: add,
   edit, and delete model records under Configuration → AI.

## Where it lives in the admin menu

The catalogue is managed at **Configuration → AI → AI Model Registry**, a
standard entity list with add/edit/delete forms, gated by the restricted
**Administer AI Model Registry** permission (`administer ai_model_registry`).

## How to use it

Populate the catalogue with the models your site actually uses — starting from
the seeded examples — filling in each one's capabilities, cost, governance, and
lifecycle fields. Then enable the governance/budget modules that consume it; they
will make their decisions from these records rather than from hard-coded provider
knowledge. Because the entries are configuration, you can export them and deploy
the same catalogue across environments.
