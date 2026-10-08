<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds SiliconFlow's inference API as a Drupal AI provider, supporting chat, embeddings, and text-to-image, with model names entered per operation and autocompleted from SiliconFlow.

---

`ai_provider_siliconflow` registers a single `AiProvider` plugin (`siliconflow`) that extends the Drupal AI module's `AiProviderClientBase` and calls SiliconFlow's OpenAI-style REST API (base `https://api.siliconflow.cn/v1`) through a small dedicated API client service (`SiliconflowApi`). It supports `chat`, `embeddings`, and `text_to_image` operation types. Models are not hard-coded: an admin adds SiliconFlow model names (or dedicated endpoint URLs) per operation on the settings form, aided by a permission-gated autocomplete controller that queries SiliconFlow's model list. The access token is stored in a Key module entity. Configuration is at `/admin/config/ai/providers/siliconflow` (route gated by `administer ai providers`). It depends on the `ai` and `key` modules.

---

- Use SiliconFlow as a chat backend for the Drupal AI module.
- Generate text-to-image output via SiliconFlow models.
- Produce text embeddings via SiliconFlow.
- Add arbitrary SiliconFlow model names per operation type.
- Point an operation at a dedicated SiliconFlow endpoint URL instead of a shared model.
- Autocomplete SiliconFlow model names while configuring (permission-gated).
- Store the SiliconFlow access token in a Key entity (env or file provider).
- Migrate configuration from the older `provider_siliconflow` AI submodule automatically on install.
- Power AI Assistants / agents with SiliconFlow models.
- Offer SiliconFlow as one of several providers in per-operation defaults.
- Classify images through SiliconFlow (image-classification operation in code).
- Select image size / batch parameters for text-to-image (fixed defaults in the API client).
- Feed SiliconFlow embeddings into RAG/vector workflows.
- Switch an existing AI-module site to SiliconFlow without code changes.
- Grant the autocomplete permission to trusted roles that configure models.
- Restrict who can list SiliconFlow models via the dedicated permission.
- Call the provider programmatically via `ai.provider` → `createInstance('siliconflow')`.
- Handle rate-limit errors surfaced by the AI framework.
- Use the `SiliconflowApi` service directly for lower-level inference calls.
- Expose SiliconFlow models to any module that consumes the AI framework.
