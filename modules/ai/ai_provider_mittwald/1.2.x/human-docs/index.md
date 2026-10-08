# mittwald Provider — manual setup guide

**mittwald Provider** (`ai_provider_mittwald`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to the AI service run by
[mittwald](https://www.mittwald.de/), the German managed‑hosting company. Once
enabled and configured, mittwald's models become selectable for chat and related
AI operations wherever the AI module offers a provider choice.

The AI module abstracts providers so you write an AI feature once and point it at
whichever service you choose; this module makes mittwald one of those services.
Its value is mainly for teams already hosting with mittwald who want their AI
calls to stay within that vendor relationship.

Requests send your prompt content to mittwald's API, which means both **cost** and
**data egress** — whatever you send leaves the site. The API credential is stored
through the **Key** module, backed by an environment variable, so it never lands
in exported configuration. It depends on the AI module and targets Drupal 10.3+
and 11 (version 1.1.0).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   module requirement, and enable the module.
2. [Configuration](configuration/index.md) — register mittwald on the AI provider
   settings and supply your credential through a Key entity.

## Where it lives in the admin menu

Provider configuration lives in the AI module's settings area under
**Configuration → AI → Providers** (`/admin/config/ai/providers`), where mittwald
appears once the module is enabled. The credential is a **Key** entity, managed at
**Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module, store your mittwald credential in a Key, select that Key on
mittwald's provider settings, then choose mittwald (and a model) as the provider
for the AI operations you want it to handle.
