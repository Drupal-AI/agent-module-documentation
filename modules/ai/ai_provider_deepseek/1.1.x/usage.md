<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeepSeek Provider registers DeepSeek as a chat provider plugin for Drupal's AI module, authenticated with an API key held in a Key entity.

---

The module ships one plugin, `DeepSeekProvider` (`#[AiProvider(id: 'deepseek')]`), that plugs DeepSeek's hosted, OpenAI-compatible chat API into the `ai` module's provider abstraction. It declares a single supported operation type, `chat`, so any AI-module feature that consumes a chat provider (chatbots, content suggestions, summarisation, classification) can select DeepSeek once a key is configured. Requests are issued through the `deepseek-php/deepseek-php-client` library, which targets `https://api.deepseek.com` over HTTPS with the key sent as a Bearer token; the module keeps that key in a Key entity (the `key` module is a hard dependency) rather than in exported configuration, so it can come from an environment variable. Configuration is a single form at `/admin/config/ai/providers/deepseek` where an administrator picks which key holds the DeepSeek credential. DeepSeek's appeal among providers is cost and open weights: models are priced below the established Western APIs and the weights are published, so a site can prototype against the hosted API and later move to self-hosted inference without changing anything above the provider layer. Version 1.1.0 requires `ai (>=1.0-beta)` and `key`, on core `^10 || ^11`. Note that as a hosted service DeepSeek processes prompts on its own infrastructure, so sending prompts to it is a data-disclosure and procurement decision for sites under data-residency obligations.

---

- Add DeepSeek as an AI provider for a Drupal site.
- Give the AI module a low-cost chat backend.
- Classify support tickets or comments at volume.
- Generate alt-text drafts cheaply and in bulk.
- Summarise a large content archive.
- Prototype an AI feature affordably before committing.
- Power a chatbot built on the AI module with DeepSeek.
- Provide chat completions to AI-module submodules (assistants, agents).
- Store the DeepSeek API key in a Key entity from an environment variable.
- Select a specific DeepSeek model per AI-module use case.
- Compare provider cost by swapping DeepSeek in behind the AI abstraction.
- Add AI-assisted content tagging or metadata suggestions.
- Draft editorial summaries for a human to review.
- Add AI classification to an editorial workflow.
- Evaluate a DeepSeek model for a specific task before rollout.
- Route a high-volume, low-stakes AI workload to a cheaper provider.
- Restrict who can configure the provider via a dedicated permission.
- Plan a later migration path toward self-hosted open-weight inference.
- Hot-swap the API key at runtime for multi-tenant or per-request keys.
