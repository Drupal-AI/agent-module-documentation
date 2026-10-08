# NanoBanana Provider — manual setup guide

**NanoBanana Provider** (`ai_provider_nanobanana`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to
[Google Gemini](https://ai.google.dev/)'s **image‑generation** models —
specifically Gemini 2.5 Flash Image and Gemini 3 Pro Image (the family nicknamed
"Nano Banana"). It exposes those models to the AI provider abstraction so other
modules — such as **NanoBanana Editor** — can generate and manipulate images
through Gemini.

Unlike the text/chat providers in this family, NanoBanana is about **image
generation**. It authenticates with a **Google API key** stored through the Key
module (backed by an environment variable), and each generation sends your
prompts and images to Google, so expect both **cost** and **data egress**.

It depends on the AI module and the Key module and targets Drupal 10.3+ and 11.
This is an early release (version 1.0.0‑beta1), so test it before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   and Key requirements, and enable the module.
2. [Configuration](configuration/index.md) — register the provider on the AI
   settings and supply your Google API key through a Key entity.

## Where it lives in the admin menu

Provider configuration lives in the AI module's settings area under
**Configuration → AI → Providers** (`/admin/config/ai/providers`), where
NanoBanana appears once enabled. The Google API key is a **Key** entity, managed
at **Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module, store your Google API key in a Key, select that Key on the
NanoBanana provider settings, then use an image‑capable feature (for example
NanoBanana Editor) with NanoBanana selected as the provider to generate images
via Gemini.
