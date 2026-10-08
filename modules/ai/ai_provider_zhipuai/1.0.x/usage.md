<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zhipuai Provider registers Zhipu AI's GLM chat models as a provider for the Drupal AI module.

---

Zhipuai Provider is an AI provider plugin for the `drupal/ai` framework. It adds a `zhipuai` provider exposing Zhipu AI's GLM chat models (glm-4.5 and its air/x/airx/flash variants) so they can be selected wherever the AI module offers a provider choice. The API credential is held in a Key entity (via the `key` module) and selected on the provider's settings page at `/admin/config/ai/providers/zhipuai` (permission `administer ai providers`). Requests are made by a small Guzzle-based client (`ZhipuaiClient`) to Zhipu's serverless endpoint `https://open.bigmodel.cn/api/paas/v4`, authenticating with a Bearer token. The module ships its own client rather than reusing openai-php because GLM responses omit the `object` property openai-php expects. Depends on `ai` and `key`.

---

- Add Zhipu AI (GLM) as an AI provider on a Drupal site.
- Make glm-4.5 available for chat operations through the AI module.
- Offer the glm-4.5-flash model for cheaper/faster chat.
- Offer glm-4.5-air / glm-4.5-x / glm-4.5-airx variants.
- Store the Zhipuai API key in a Key entity rather than plain config.
- Select the credential key on the provider settings form.
- Route AI module chat calls to Zhipu's serverless API.
- Complement other configured AI providers in a multi-provider site.
- Let AI-module features (chat, agents, assistants) use GLM models.
- Configure the provider from *Configuration → AI → Providers → Zhipuai*.
- Restrict provider configuration to holders of `administer ai providers`.
- Use GLM models for content generation workflows built on the AI module.
- Swap providers per operation without changing calling code.
- Provide a GLM backend for RAG/chat features that consume `ai`.
- Keep the API credential out of exported configuration (Key module).
- Use a purpose-built client that tolerates GLM's response shape.
- Point Chinese-market sites at a locally-available LLM provider.
- Add Zhipu chat support to assistants that call multiple providers.
