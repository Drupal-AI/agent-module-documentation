# OpenAI Compatible Provider — manual setup guide

**OpenAI Compatible Provider** (`ai_provider_openai_compatible`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to **any service that speaks the
OpenAI API** — DeepSeek, self‑hosted or local LLMs, and other OpenAI‑compatible
gateways — by pointing it at a configurable **base URL**. Rather than targeting one
named vendor, it is the general‑purpose adapter for the many providers that expose
an OpenAI‑style `/v1` endpoint.

The AI module abstracts providers so you build an AI feature once and route it to
whichever backend you choose; this module lets that backend be anything
OpenAI‑compatible. You supply two things: the **base URL** of the endpoint and an
**API key**.

Because the base URL is admin‑configured, point it only at trusted endpoints and
use HTTPS. Store the API key as a secret, and remember that prompts leave the site
for a cloud endpoint — while a **self‑hosted or local** endpoint keeps that data
in‑house. It depends on the AI module, has its own settings form, and targets
Drupal 10.3+ and 11 (version 1.2.1).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   module requirement, and enable the module.
2. [Configuration](configuration/index.md) — set the base URL, supply the API key
   as a secret, and pick a model.

## Where it lives in the admin menu

The provider has a dedicated settings form under **Configuration → AI**
(`/admin/config/ai`), and a direct **Configure** link appears next to the module
on the **Extend** page (`/admin/modules`). API keys are best stored as **Key**
entities at **Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module, enter the base URL of your OpenAI‑compatible endpoint, supply
the API key as a secret, then choose this provider (and a model name the endpoint
serves) for the AI operations you want it to power.
