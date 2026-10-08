# Google Vertex (AI provider) — manual setup guide

**Google Vertex (AI provider)** (`ai_provider_google_vertex`) connects Drupal's
AI module to **Google Vertex AI** (Vertex AI Studio), Google Cloud's managed
platform for large models. Once enabled and authenticated, Vertex becomes the
backend for AI operations the module abstracts — chat/completion, embeddings and
more — and appears wherever the AI module offers a provider choice.

What makes this provider different from the simple API-key providers is
**authentication**. Vertex is a Google Cloud service, so you do not authenticate
with a single API string. Instead you use a **Google Cloud service-account
credential** (a JSON key), and you tell Drupal which **project** and **region
(location)** to run against. Everything else — which models are available, which
operations run through Vertex — follows from your Google Cloud setup and the AI
module.

The credential is sensitive and is handled through the **Key** module: store the
service-account JSON as a Key entity backed by the environment (or another secure
provider), never as plaintext configuration. As with any provider, prompts sent to
Vertex leave your site to Google.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — supply the service-account
   credential, project and region on the provider settings form.

## Where it lives in the admin menu

This provider has its own settings form
(`ai_provider_google_vertex.settings_form`), reached from the AI module's provider
settings under **Configuration → AI** (`/admin/config/ai`).

## How to use it

In Google Cloud, enable the Vertex AI API and create a service account with access
to it, then download its JSON key. Enable this module, store that JSON as a Key
entity, and on the Vertex provider settings form supply the key plus your Google
Cloud **project ID** and **region**. Then select Vertex for the AI operations you
want on the AI default-provider settings. Requires Drupal 10.3 or 11.
