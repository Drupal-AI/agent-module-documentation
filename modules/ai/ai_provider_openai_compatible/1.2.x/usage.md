<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAI Compatible Provider adds a configurable AI-module provider for any endpoint that speaks the OpenAI API (DeepSeek, SiliconFlow, Kimi, and other OpenAI-compatible services).

---

`ai_provider_openai_compatible` lets a site point the [AI module](https://www.drupal.org/project/ai)
at any OpenAI-compatible API by setting a base endpoint URL and an API key. Unlike a vendor-specific
provider, the models are fully admin-defined: an administrator lists one or more models — each with a
model id, label, the operation types it supports (chat, embeddings, translate_text, …), a set of
capabilities, and per-model YAML parameters (temperature, max_tokens, top_p, …). The API key is held
through the **Key module** rather than in plain config. The module ships with DeepSeek `deepseek-chat`
and `deepseek-reasoner` as example defaults and documents endpoints for DeepSeek, SiliconFlow, Zhipu
AI, Alibaba Cloud (Tongyi Qianwen), 01.AI (Yi) and Moonshot AI (Kimi). Supports Drupal 10.3+ and 11.

---

- Connect the AI module to any OpenAI-compatible API endpoint.
- Use DeepSeek `deepseek-chat` and `deepseek-reasoner` out of the box.
- Point the provider at SiliconFlow, Zhipu AI, Kimi, Tongyi Qianwen, or Yi.
- Set the base API endpoint URL from an admin form.
- Store the API key securely via the Key module (no plaintext config).
- Define custom models with an id, label, and human-readable name.
- Choose which operation types each model supports (chat, embeddings, translate_text, …).
- Declare per-model capabilities (JSON output, tools/function calling, structured response, vision).
- Set per-model parameters (temperature, max_tokens, top_p) as YAML.
- Add or remove model entries with AJAX in the settings form.
- Run chat completions against a self-selected OpenAI-compatible service.
- Expose translate_text or embeddings when a model declares them.
- Filter selectable models by operation type and required capabilities.
- Seed the default provider models for chat and embeddings automatically.
- Switch providers by only changing the endpoint and API key.
- Reuse OpenAI-style AI-module flows against a cheaper or regional API.
- Configure models from config (config/install seeds DeepSeek examples).
- Validate the endpoint URL and model config before saving.
- Support Drupal 10.3, 11 sites running the AI module and Key module.
