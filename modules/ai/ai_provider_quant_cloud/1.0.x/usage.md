<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers the Quant Cloud platform (QuantCDN / QuantGov Cloud) as a Drupal AI provider, exposing AWS Bedrock chat, embeddings, image generation and a managed vector database through Quant's Dashboard API.

---

Quant Cloud AI Provider is a connector module for the `ai` (Drupal AI) framework. It implements the AI provider plugin `quant_cloud`, which routes chat, embeddings, text-to-image and image-to-image operations to Quant Cloud's Dashboard API (`/api/v3/organisations/{orgId}/ai/...`). Behind that API sit AWS Bedrock foundation models — Anthropic Claude, Amazon Nova / Titan, Cohere — so a site gets multi-model access without holding cloud credentials or managing inference infrastructure. Authentication is either OAuth2 (a one-click "Connect to Quant Cloud" flow that stores the returned token in a Key entity) or a manually created access-token Key; every request is Bearer-authenticated over HTTPS and scoped to a chosen organization. Models are discovered dynamically from the API and cached for one hour, with a small hard-coded fallback list. The bundled submodule `ai_provider_quant_cloud_vdb` adds an AI Search / Search API vector-database backend on top of the same API, and the main module also ships a direct `QuantCloudVectorDbClient` service for collection and document operations without Search API. Requires the `ai` and `key` modules; supports Drupal 10.3+, 11 and 12.

---

- Add Quant Cloud as a selectable AI provider (`quant_cloud`) anywhere the AI module offers a provider choice.
- Run multi-turn chat completions against Claude and Nova models via the Dashboard API.
- Stream chat responses in real time over Server-Sent Events for AI Explorer / chatbots.
- Call models with function/tool definitions and consume returned tool-use requests.
- Request structured JSON output validated against a JSON Schema.
- Send multimodal chat input (images, and — via attachment blocks — video/documents) to Nova/Claude.
- Generate text embeddings (Titan v1/v2, Cohere v3) for semantic search and RAG.
- Generate images from text prompts with Amazon Nova Canvas (text-to-image).
- Transform images: variations, inpainting, outpainting, and background removal (image-to-image).
- Configure default model, temperature and max tokens on the settings form.
- Authenticate with a one-click OAuth2 flow that stores the access token in a Key entity.
- Alternatively authenticate with a manually created access-token Key from the Quant dashboard.
- Switch between the QuantCDN and QuantGov Cloud platforms.
- Select the active organization from a dropdown populated by the dashboard API.
- Index Drupal content into a managed vector database via the AI Search submodule.
- Offload embedding generation to Quant's servers ("server-side embeddings") for faster indexing.
- Run semantic vector search over indexed content through Search API.
- Manage vector collections (create, list, get, delete) directly with the `vectordb_client` service.
- Upload documents with automatic server-side embedding, then query by text or by vector.
- Delete indexed documents by id, by metadata field, or purge a whole collection.
- Provide chat/embeddings capacity to consumer modules such as AI Automators, AI Chatbot, or custom code.
- Tune request and streaming timeouts, and toggle request/response logging for debugging.
