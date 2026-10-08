<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Moonshot AI (Kimi) as a selectable chat provider for the Drupal AI module, talking to Moonshot's OpenAI-compatible API.

---

`ai_provider_moonshot` registers a single `AiProvider` plugin (`moonshot`) that extends the Drupal AI module's `AiProviderClientBase` and drives the OpenAI PHP SDK against Moonshot's OpenAI-compatible endpoint (default `https://api.moonshot.cn/v1`). It supports the `chat` operation type only, including image input (base64 data URLs), tool/function calling, and structured JSON-schema responses. The API key is held in a Key module entity and the API host is set on the provider settings form (`/admin/config/ai/providers/moonshot`, gated by the `administer ai providers` permission). It depends on the `ai` and `key` modules plus `openai-php/client`. Once configured, Moonshot/Kimi models become available to every AI-module feature.

---

- Use Moonshot AI (Kimi) as the chat backend for the Drupal AI module.
- Generate chat completions with Kimi models (`kimi-k3`, `kimi-k2.7-code`, `kimi-k2.7-code-highspeed`, `kimi-k2.6`).
- Send images alongside text in a chat message (vision, base64 data URLs).
- Call Moonshot with tool/function-calling payloads.
- Request structured JSON-schema-constrained responses.
- Power AI Assistants / agents with Kimi models.
- Use the Kimi high-context code models for code assistance.
- Point the provider at the default Moonshot (China) host.
- Point the provider at an alternate Moonshot-compatible host.
- Store the Moonshot API key in a Key entity (env or file provider).
- Set the default chat model for the site's AI operations.
- Offer Moonshot as one of several providers in per-operation defaults.
- Switch an existing AI-module site to Moonshot without code changes.
- Feed Kimi output into CKEditor AI tools or chat blocks.
- Combine text + image messages for multimodal prompts.
- Route tool responses (role `tool`) back to the model.
- Handle rate-limit errors surfaced by the AI framework.
- Use Moonshot for content generation, summarization, or translation via the AI module.
- Select Moonshot per-feature while keeping other providers for other operations.
- Expose Kimi models to any custom module that calls `ai.provider`.
