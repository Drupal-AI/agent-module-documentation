<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alibaba Cloud Model Studio AI Provider adds Alibaba Cloud's Qwen models (via the DashScope / Model Studio API) as a provider for the Drupal AI module.

---

Alibaba Cloud Model Studio AI Provider is a provider plugin (`alibabacloud`) for the Drupal AI (`ai`) module. It implements the AI module's Chat and Embeddings operation types so Qwen models become selectable anywhere the AI ecosystem (AI Chatbot, AI CKEditor, AI Search, assistants, etc.) offers a provider choice. It supports two API modes — OpenAI-compatible (`.../compatible-mode/v1`) and DashScope native (`.../api/v1`) — and two regions, Singapore/international (`dashscope-intl.aliyuncs.com`) and Beijing/China (`dashscope.aliyuncs.com`). Chat supports non-streaming and SSE streaming, tool/function calling, structured JSON-schema responses, images, and tunable parameters (temperature, top-p, penalties, max tokens, plus native-mode repetition penalty and Qwen3 "thinking" options). Embeddings use the compatible-mode endpoint with text-embedding v1–v4 models. The API key is stored as a Key entity (Key module dependency) and the provider is configured at `/admin/config/ai/providers/alibabacloud` (permission: `administer ai providers`).

- Add Alibaba Cloud Qwen models as an AI-module provider.
- Route AI Chatbot / assistant conversations through Qwen.
- Generate article drafts, summaries, and rewrites with `qwen-plus` or `qwen-max`.
- Use `qwen-coder` for code generation and review inside editorial tools.
- Produce text embeddings (`text-embedding-v1`…`v4`) for semantic search / RAG.
- Choose OpenAI-compatible mode to reuse OpenAI-style request/response handling.
- Choose DashScope native mode for Qwen-specific features (thinking mode, incremental output).
- Switch between the Singapore and Beijing regional endpoints per account/latency.
- Stream chat responses token-by-token with Server-Sent Events.
- Optionally include token-usage info in the streaming response (compatible mode).
- Pass tool/function definitions and receive tool-call outputs.
- Constrain responses to a JSON Schema for structured output.
- Send images alongside chat text to multimodal Qwen models.
- Tune temperature, top-p, presence/frequency penalties, and max tokens per request.
- Set a per-request timeout (10–300 seconds) for API calls.
- Store the API key as a Key entity instead of plain config.
- Set Alibaba Cloud as the default provider per operation type in AI settings.
- Pick default chat and embeddings models (defaults: `qwen-plus`, `qwen-max`, `text-embedding-v4`).
- Validate the key and connection from the settings form before saving.
- Get a runtime status warning when the API key is missing or invalid.
- Back multilingual translation workflows with Qwen models.
- Complement or replace other AI providers (OpenAI, Anthropic, DeepSeek) in a multi-provider site.
