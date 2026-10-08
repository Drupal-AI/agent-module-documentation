# Mistral AI Provider — manual setup guide

**Mistral AI Provider** (`ai_provider_mistral`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to
[Mistral AI](https://mistral.ai/), so Mistral's hosted models become available
for chat, summarisation, translation assistance, embeddings and any other AI
operation on your site. The AI module abstracts providers — you build a feature
once and point it at whichever service you choose — and this module makes Mistral
one of those choices.

For many teams the reason to pick Mistral is not technical but a **procurement
decision**. Mistral is a French company running its models in the European Union,
so for European public bodies, healthcare organisations and anyone whose
data‑protection assessment has stalled on transfers to the United States, the
prompts — which routinely carry content and sometimes personal data — stay within
the EU and under the same regulator as the organisation sending them. Mistral
also publishes open‑weight models, so you can start on the hosted API and later
move to self‑hosting without rewriting anything above the provider layer.

This is a **release candidate** (version 1.1.0‑rc1). It depends on the AI module
and the **Key** module, and it defines an `administer ai providers` permission
that is access‑restricted. Three things belong in any AI deployment regardless of
provider: the API key is a **spending credential** (set a limit and watch it),
every **prompt is a disclosure** of whatever you send, and **model availability
changes** — so pin a model and know your fallback.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   and Key requirements, and enable the module.
2. [Configuration](configuration/index.md) — register Mistral on the AI provider
   settings and supply your API key through a Key entity.

## Where it lives in the admin menu

Provider configuration lives in the AI module's settings area under
**Configuration → AI → Providers** (`/admin/config/ai/providers`), where Mistral
appears once the module is enabled. The API key itself is a **Key** entity,
managed at **Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module, create a Key holding your Mistral API key, select that Key on
Mistral's provider settings, then choose Mistral (and a specific model) as the
provider for whichever AI operations you want it to power.
