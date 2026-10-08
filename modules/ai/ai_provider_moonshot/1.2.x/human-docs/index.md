# Moonshot AI Provider — manual setup guide

**Moonshot AI Provider** (`ai_provider_moonshot`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to
[Moonshot AI](https://www.moonshot.ai/) (the company behind the Kimi models), so
its models become available for chat and related AI operations anywhere the AI
module offers a provider choice.

The AI module abstracts providers — you build an AI feature once and route it to
whichever service you pick — and this module makes Moonshot one of those options.
It authenticates to the Moonshot API with an **API key**, so store that key as a
secret rather than typing it into plain configuration, and remember that prompts
you send leave the site (data handling matters for sensitive content).

The module has its own settings form for the connection and key, depends on the
AI module, and targets Drupal 10.3+ and 11 (version 1.2.1). It has no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   module requirement, and enable the module.
2. [Configuration](configuration/index.md) — open the settings form, supply your
   API key as a secret, and pick a model.

## Where it lives in the admin menu

The provider has a dedicated settings form under **Configuration → AI**
(`/admin/config/ai`), and a direct **Configure** link appears next to the module
on the **Extend** page (`/admin/modules`). API keys are best stored as **Key**
entities at **Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module, store your Moonshot API key as a secret, enter/select it on
the provider's settings form, then choose Moonshot (and a model) as the provider
for the AI operations you want it to power.
