<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Huggingface Provider lets the Drupal AI module use the Hugging Face Inference API for chat, embeddings, summarization, image classification and object detection.

---

Huggingface Provider (ai_provider_huggingface) registers a `huggingface` provider plugin for the Drupal AI module, exposing the many models hosted on Hugging Face through the AI module's abstracted operations. It supports five operation types — chat/text-generation, embeddings (feature-extraction), image classification, summarization and object detection — and does not ship a fixed model list: an administrator adds each model in the AI provider settings UI by giving it a Hugging Face model name (for serverless inference through `router.huggingface.co`) or a full URL to a dedicated Inference Endpoint. The model-name field autocompletes against Hugging Face's public model catalogue filtered by the relevant pipeline tag. Authentication uses a Hugging Face access token stored in a Key entity (drupal/key); the token is sent as an `Authorization: Bearer` header on each request. Chat supports streaming (Server-Sent Events) and the AI module's Fiber-based async pattern. The module depends on the ai and key modules, provides an `autocomplete huggingface model list` permission for the autocomplete route, and reuses the AI module's `administer ai providers` permission to gate its settings form.

---

- Use Hugging Face's model catalogue with the Drupal AI module.
- Run chat / text-generation against Hugging Face models.
- Generate text embeddings for semantic search or RAG.
- Summarize long text with summarization models.
- Classify images into labels with confidence scores.
- Detect objects (label, bounding box, score) in images.
- Use serverless inference via router.huggingface.co by model name.
- Point a model at a dedicated Hugging Face Inference Endpoint URL.
- Autocomplete model names filtered by pipeline tag while configuring.
- Store the Hugging Face access token in a Key entity, not plaintext.
- Stream chat responses as Server-Sent Events for real-time output.
- Use the AI module's Fiber-based async streaming pattern.
- Read prompt/completion/total token-usage metadata from responses.
- Add as many models per operation type as you need.
- Route the AI module's operations to Hugging Face on demand.
- Support multi-provider AI setups alongside other providers.
- Restrict the model autocomplete route with a dedicated permission.
- Gate provider configuration with the "administer ai providers" permission.
- Migrate configuration from the older AI-core Hugging Face submodule on install.
- Select which Hugging Face model backs each AI operation.
