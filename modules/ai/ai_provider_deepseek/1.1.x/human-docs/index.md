# DeepSeek Provider — manual setup guide

**DeepSeek Provider** (`ai_provider_deepseek`) connects Drupal's AI module to
**DeepSeek**, whose distinguishing features are **cost** and **openness**.
DeepSeek's hosted models are priced well below the established Western APIs, and
its model weights are published — so you can prototype against the hosted API and
later move to self-hosting the same models without changing anything above the
provider layer. For high-volume, low-stakes work (classifying support tickets,
drafting alt text, summarising a large archive), the cost per token can decide
whether a feature is affordable at all.

Once enabled and given an API key, DeepSeek appears as a selectable provider
wherever the AI module offers a provider choice. The API key is held in a **Key**
entity from an environment variable rather than exported configuration.

There is one consideration specific to this provider that should be raised
explicitly: **jurisdiction**. DeepSeek is a Chinese company processing in China,
so prompts sent to the hosted API leave the EU and the UK, and several European
regulators and public bodies have issued guidance restricting its use. For a site
handling personal data, unpublished content, or anything under a data-residency
policy, that is a procurement and data-protection decision to settle **before**
configuring the module — and the self-hosting route is precisely what makes the
model usable where the hosted API is not.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — register DeepSeek, supply the API
   key securely, and choose it for AI operations.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including DeepSeek, are configured
from the **Providers** area under that section (`/admin/config/ai/providers`).

## How to use it

Settle the jurisdiction question first. Then get a DeepSeek API key, enable this
module, store the key as a Key entity, register DeepSeek on the AI providers page,
and select it for the operations you want on the AI default-provider settings.
Because the weights are open, keep in mind you can later move the same workload to
self-hosted inference. Requires Drupal 10 or 11.
