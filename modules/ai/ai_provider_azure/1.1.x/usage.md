Microsoft Azure AI is a provider plugin for the Drupal AI module: it lets the AI module talk to Azure AI Studio / Azure OpenAI (and OpenAI-compatible endpoints behind a proxy) for chat, embeddings, text-to-image, text-to-speech and speech-to-text, using per-model endpoints and a Key-module-stored API key.

---

The module registers a single AI provider plugin, `azure` (`#[AiProvider(id: 'azure')]`,
`AzureProvider extends AiProviderClientBase`), so it appears wherever the AI module lets you pick a
provider. It has **no predefined models** (`hasPredefinedModels = FALSE`) — you add each model
yourself at `/admin/config/ai/providers/azure` (route `ai_provider_azure.settings_form`, permission
`administer ai providers`, provided by the AI module), giving the model an **Endpoint** (the Azure
"Target URI" ending in `.../completions`, etc.), an **API key** selected from a **Key** entity
(`key_select`), and a **connect header type** (`api-key` for OpenAI-style, `authorization` for a
generic Authorization header, or `other` with a custom header name). Advanced options include a
**custom consumer** (`2023-06-01-preview-extensions-chat-completion`, which swaps in a lightweight
client) and free-form **extra headers** (token-aware, one `key:value` per line). Under the hood it
uses the `openai-php/client` library, deriving the base URI and query params from the endpoint per
operation type (`chat/completions`, `embeddings`, `images/generations`, `audio/translations`,
`audio/speech`). Supported operation types are `chat`, `embeddings`, `text_to_image`,
`speech_to_text`, `text_to_speech`; the only advertised capability is streamed chat
(`StreamChatOutput`). Default per-operation parameters (max_tokens, temperature, voices, image sizes,
etc.) come from `definitions/api_defaults.yml`. The module's own config object is
`ai_provider_azure.settings`; the actual model definitions are stored by the AI module in
`ai.settings` under `models.azure.*`. It defines no permissions, plugin types, or Drush of its own.
(Live calls require valid Azure credentials — an endpoint + working Key.)

---

- Use Azure OpenAI GPT models for chat/completions through the Drupal AI module.
- Generate text embeddings via an Azure embeddings deployment for search or RAG.
- Produce images with an Azure DAL-E / images deployment (text-to-image).
- Do text-to-speech and speech-to-text through Azure audio deployments.
- Point the AI module at a private Azure AI Studio deployment via its Target URI endpoint.
- Store the Azure API key securely as a Key entity instead of in plain config.
- Connect to OpenAI-compatible endpoints behind a proxy using the custom-consumer option.
- Add multiple Azure models (one per deployment) each with its own endpoint and key.
- Use an Authorization: Bearer header instead of the OpenAI api-key header when required.
- Add custom/extra HTTP headers (e.g. for a gateway) with token substitution.
- Enable streamed chat responses from Azure in the AI module (StreamChatOutput capability).
- Set default generation parameters (max_tokens, temperature, top_p) for Azure chat.
- Choose a TTS voice (alloy, echo, fable, onyx, nova, shimmer) and audio format for Azure speech.
- Select image sizes (256/512/1024) for Azure image generation.
- Use Azure as the default provider for a given AI operation type in the AI module.
- Run the AI module's chat/agent features against enterprise Azure-hosted models.
- Swap providers (OpenAI ↔ Azure) without changing calling code, via the AI module abstraction.
- Route different operation types to different Azure deployments/endpoints.
- Keep API keys out of version control by referencing environment-backed Key entities.
- Provide region-specific or compliance-bound LLM access by using an Azure endpoint.
- Test a custom Azure gateway by configuring the endpoint, header type, and extra headers.
