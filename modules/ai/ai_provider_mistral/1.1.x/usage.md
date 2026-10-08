<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mistral AI Provider registers Mistral as a provider for Drupal's AI module, so any AI feature on the site can run chat, embeddings and moderation through Mistral's EU-hosted models.

---

This is a thin provider plugin: it implements the `ai` module's `ChatInterface`, `EmbeddingsInterface` and `ModerationInterface`, and nothing above the provider layer needs to know Mistral is behind them. Chat covers streaming, multi-turn conversations, tool/function calling, structured JSON-schema output and multimodal input (images and documents are sent inline as base64), with `max_tokens`, `temperature` and `top_p` as tunable parameters; embeddings run through `mistral-embed`; moderation defaults to `mistral-moderation-latest` and returns per-category flags and scores. The chat and moderation model lists are fetched live from Mistral's `/models` endpoint and filtered by the capabilities the caller asks for (vision, function calling, JSON output), then cached for 24 hours. Requests are made by the third-party `partitech/php-mistral` PHP library over a PSR-18 HTTP client with TLS verification left at its secure default; the bearer credential is the Mistral API key, which the module never stores in configuration itself — it stores only a reference to a **Key entity** and resolves the actual secret server-side at request time via the Key module. Version **1.1.0-rc1** is a release candidate requiring `ai ^1.2.0`, `key ^1.18` and PHP 8.2+; core requirement is `^10.2 || ^11`. Configuration lives at `/admin/config/ai/providers/mistral` behind the `administer ai providers` permission (`restrict access: true`) and holds two values: the key selector and an optional advanced **Custom API Host** that overrides the default `https://api.mistral.ai` endpoint (useful for proxies or mock servers). Three considerations apply to any AI provider: the key is a spending credential, so cap it at Mistral and watch usage; a prompt is a data disclosure that leaves the site, so treat personal data and unpublished content in prompts as a transfer; and model names change, so pin a model and plan for it being withdrawn. The provider also exposes helper methods for Mistral's Files API (upload, signed URL, list, retrieve, delete) for OCR, batch and fine-tuning workflows, though those are not first-class AI operation types.

---

- Add Mistral as an AI provider for the whole `ai` module family.
- Run chat completions through `mistral-large-latest` or another chat model.
- Stream chat responses token-by-token to the UI.
- Call tools / functions from a Mistral chat model.
- Get structured JSON output constrained by a JSON schema.
- Send images to a vision-capable Mistral model (multimodal chat).
- Send a document inline to a Mistral chat model.
- Generate text embeddings with `mistral-embed` for search or RAG.
- Moderate user-submitted text with `mistral-moderation-latest`.
- Meet an EU data-residency requirement with a French provider.
- Avoid US data transfers for AI prompts.
- Store the Mistral API key in a Key entity backed by an environment variable.
- Point AI features at a proxy or mock server via the Custom API Host override.
- List only the chat models that support vision or function calling.
- Set the default chat and embeddings model when configuring the provider.
- Summarise or rewrite content for editors using an EU model.
- Add AI-assisted translation with European hosting.
- Power a RAG / vector-search feature with Mistral embeddings.
- Cap and monitor AI spend against a single API key.
- Upload files to Mistral for OCR, batch or fine-tuning workflows.
- Plan a migration path from the hosted API to self-hosted open-weight models.
- Support a GDPR-constrained or public-sector AI assessment.
