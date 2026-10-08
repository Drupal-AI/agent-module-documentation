# AnythingLLM Provider — manual setup guide

**AnythingLLM Provider** (`ai_provider_anythingllm`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to an **AnythingLLM** instance.
AnythingLLM is a self-hostable LLM and RAG (retrieval-augmented generation)
application — you run it on your own server or workstation and it fronts whatever
model you have configured behind it. This provider lets the AI module route its
operations (chat and completions) to that instance instead of to a public cloud
vendor.

The appeal is control over where your data goes. Because AnythingLLM can be
self-hosted, prompts and content can stay entirely on infrastructure you own,
which is often the deciding factor for sensitive material. You point the provider
at your AnythingLLM endpoint's URL and give it an API key; the key is stored
through Drupal's **Key** module rather than in plain configuration.

The module has no access-control role of its own — it simply provides the
connection. Make sure the endpoint you point it at is one you trust and that the
connection is over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your AnythingLLM API key and
   set the endpoint URL.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`).

## How to use it

Stand up an AnythingLLM instance and note its base URL and an API key. Enable this
module, store the key as a Key entity, enter the endpoint URL and key on the
provider's settings form, then choose **AnythingLLM** wherever the AI module offers
a provider choice.
