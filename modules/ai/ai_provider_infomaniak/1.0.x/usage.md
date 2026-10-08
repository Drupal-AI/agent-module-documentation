<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Infomaniak AI Provider lets the Drupal AI module use Infomaniak's Swiss-hosted AI Tools for chat, embeddings, image generation and image editing.

---

Infomaniak AI Provider (ai_provider_infomaniak) registers an `infomaniak` provider plugin for the Drupal AI module, routing AI operations to Infomaniak's OpenAI-compatible AI Tools API hosted in Switzerland. Because the endpoint is OpenAI-compatible, the plugin extends the AI module's `OpenAiBasedProviderClientBase` and talks to the API with the `openai-php/client` library. It ships a predefined catalogue of models (config object `ai_provider_infomaniak.models`) covering chat/text-generation (Llama 3.3, Granite, Mistral Small, Qwen3 VL, Gemma 3n, Apertus 70B, GPT-OSS 120B), embeddings (BGE Multilingual Gemma2, MiniLM L12 v2, Qwen3 Embedding 8B) and image generation (Flux Schnell). Authentication uses an Infomaniak API token (with the `ai-tools` scope) stored in a Key entity plus a numeric Product ID; the endpoint URL is built as `{base_url}/{product_id}/openai/v1`. The settings form offers a "Test Connection" check and a per-model editor for temperature, max tokens, top-p and frequency/presence penalties. The module depends on the ai and key modules and requires PHP 8.1+.

---

- Use Infomaniak's Swiss-hosted AI models from the Drupal AI module.
- Run chat / text generation against Infomaniak chat models.
- Generate text embeddings for semantic search or RAG.
- Generate images from text prompts (Flux Schnell).
- Edit images with image-to-image operations (with optional mask).
- Keep AI processing within Swiss / European data-sovereignty boundaries.
- Authenticate with an Infomaniak API token stored in a Key entity.
- Supply a numeric Product ID to scope requests to your AI Tools product.
- Test API credentials from the settings form before saving.
- Choose from a predefined catalogue of chat, embedding and image models.
- Tune per-model temperature, max tokens, top-p and penalties.
- Point the provider at a custom Infomaniak endpoint or proxy via Base URL.
- Set a request timeout for slower operations like image generation.
- Have default models auto-selected per operation type on save.
- Integrate with the wider AI module ecosystem (agents, RAG, etc.).
- Support multi-provider AI setups alongside other providers.
- Use vision-capable chat models (Qwen3 VL) for multimodal input.
- Restrict provider configuration to the "administer ai providers" permission.
- Use streaming chat output and the AI module's Fiber async pattern.
- Select which Infomaniak model backs each AI operation.
