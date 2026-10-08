<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Baidu Provider registers Baidu's Qianfan LLM API (ERNIE and related models) as a chat provider for the Drupal AI module.

---

Baidu Provider is a provider plugin (`baidu`) for the Drupal AI (`ai`) module. It implements the AI module's Chat operation type and calls Baidu's Qianfan serverless endpoint (`https://qianfan.baidubce.com/v2/chat/completions`), so Baidu's ERNIE 4.5 family plus a few third-party models (DeepSeek-V3.1, Kimi-K2-Instruct) become selectable anywhere the AI ecosystem offers a provider choice. It supports only chat (no embeddings, no streaming capability declared) and exposes a fixed, code-defined model list. The API key is stored as a Key entity (Key module dependency) and configured at `/admin/config/ai/providers/baidu` (permission: `administer ai providers`); it is sent to Baidu as an `Authorization: Bearer` header. The module is intentionally minimal: one settings form, one HTTP client service, one provider plugin, and no config schema, permissions, or Drush commands of its own.

- Add Baidu ERNIE models as an AI-module chat provider.
- Route AI Chatbot / assistant conversations through Baidu Qianfan.
- Select ERNIE 4.5 Turbo, Speed, Lite, or Tiny models per operation.
- Use vision-capable ERNIE 4.5 Turbo VL variants for image chat.
- Access DeepSeek-V3.1 and Kimi-K2-Instruct through the same provider.
- Make Baidu models selectable wherever the AI module offers a provider choice.
- Store the Baidu API key as a Key entity instead of plain config.
- Back the key with an environment variable via a Key provider.
- Configure the provider at the Baidu settings form.
- Depend on the AI module (`ai` >= 1.0-beta) and Key module.
- Support Drupal 10 and 11.
- Send chat prompts to Baidu's Qianfan API for completion.
- Complement or replace other AI providers in a multi-provider site.
- Generate article drafts, summaries, and rewrites with ERNIE.
- Power multilingual (esp. Chinese-language) content workflows.
- Serve site assistants grounded in Baidu's LLMs.
- Choose a fast/lightweight model (ernie-tiny/lite/speed) for low-latency tasks.
- Choose a flagship model (ernie-4.5-turbo-128k) for complex reasoning.
- Set Baidu as the default chat provider in AI settings.
- Keep the integration surface small (chat-only, no extra services).
