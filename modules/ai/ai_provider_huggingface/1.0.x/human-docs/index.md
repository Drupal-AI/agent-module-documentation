# Huggingface Provider — manual setup guide

**Huggingface Provider** (`ai_provider_huggingface`) connects Drupal's AI module
to the **Hugging Face Inference API**. Hugging Face hosts an enormous catalogue of
models, and this provider gives the AI module access to them for the tasks it
abstracts — text generation, embeddings and more. Once enabled and given an API
token, Hugging Face appears as a selectable provider wherever the AI module offers
a provider choice.

The main appeal is breadth: rather than a single vendor's fixed model line, you
can reach the many open and community models published on Hugging Face and pick
the one that suits a specific task. Which capabilities are actually available
depends on the AI module and the models you select.

Authentication is by a **Hugging Face API token**, stored via the **Key** module
from an environment variable rather than in exported configuration. As with every
provider, prompts you send are transmitted to Hugging Face's Inference API — that
is content leaving your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — supply your Hugging Face token on the
   provider settings form and choose it for AI operations.

## Where it lives in the admin menu

This provider has its own settings form
(`ai_provider_huggingface.settings_form`), reached from the AI module's provider
settings under **Configuration → AI** (`/admin/config/ai`).

## How to use it

Create a Hugging Face account and generate an access token, enable this module,
store the token as a Key entity, and enter it on the Hugging Face provider
settings form. Then select Hugging Face for the AI operations you want on the AI
default-provider settings, choosing an appropriate model for each task. This is a
release candidate (1.0.0-rc1); requires Drupal 10.2 or 11.
