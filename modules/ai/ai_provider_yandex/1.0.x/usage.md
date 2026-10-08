<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
YandexGPT Provider registers YandexGPT as a chat provider for the Drupal AI module.

---

YandexGPT Provider adds a single `yandex` AI-provider plugin to the Drupal AI module, exposing Yandex
Cloud's **YandexGPT** foundation models for the `chat` operation type. It reuses the AI module's
OpenAI-compatible base client, pointing it at Yandex Cloud's endpoint
(`https://llm.api.cloud.yandex.net/v1`) and prefixing each model id with a `gpt://<catalog-id>/...`
URI. Two settings are required: an **API key** (stored via the Key module) and a **catalog / folder
identifier** that scopes the models to your Yandex Cloud folder. Configuration is a single admin form
at `/admin/config/ai/providers/yandex` gated by `administer ai providers`. It depends on the AI module
and the Key module and lives in the "AI Providers" package. The project is minimally maintained with no
further development planned.

---

- Register YandexGPT as a selectable provider in the Drupal AI module.
- Offer the YandexGPT Lite and Pro models for the `chat` operation.
- Select between latest / RC variants of Lite and Pro (`yandexgpt-lite/latest`, `yandexgpt/rc`, etc.).
- Route AI-module chat calls to Yandex Cloud's foundation-models endpoint.
- Scope requests to a specific Yandex Cloud folder via the catalog identifier.
- Authenticate to Yandex with a Key-module key.
- Configure the API key and catalog id at `/admin/config/ai/providers/yandex`.
- Restrict provider configuration to users with `administer ai providers`.
- Back a chatbot block or content-generation workflow with YandexGPT.
- Summarize, translate or rewrite content through YandexGPT.
- Use YandexGPT as the model behind AI Automators / Agents.
- Swap an existing AI-module chat workflow onto YandexGPT by changing the provider.
- Keep the Yandex credential out of exported config by storing it as a Key entity.
- Select `yandex` programmatically via `\Drupal::service('ai.provider')->createInstance('yandex')`.
- Test YandexGPT prompts from the AI module's API Explorer.
- Serve Russian-language AI features with a regionally hosted model.
- Provide a fallback / alternative LLM alongside other AI-module providers.
