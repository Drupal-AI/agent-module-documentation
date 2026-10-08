# Configure — set up the Azure provider

**Route** `ai_provider_azure.settings_form` → `/admin/config/ai/providers/azure` ("Setup Azure
Models"), permission `administer ai providers` (defined by the AI module, not this one). Menu link
lives under the AI providers admin (`ai.admin_providers`).

## Prerequisites

1. An Azure AI Studio / Azure OpenAI deployment with a **Target URI** (endpoint) and a **key**.
2. The **Key** module (a hard dependency): store the Azure API key as a Key entity. Per this
   project's convention, prefer an environment-backed key:
   ```bash
   drush key:save azure_api_key --label='Azure AI API Key' --key-type=authentication \
     --key-provider=env --key-provider-settings='{"env_variable":"AZURE_API_KEY"}' --key-input=none -y
   ```
   (Or any Key entity whose value returns the API key.)

## Add a model (no models are predefined)

Because `hasPredefinedModels = FALSE`, you register each model. On the setup form pick an operation
type and add a model with these fields (`AzureProvider::loadModelsForm()`):

| Field | Key | Notes |
|---|---|---|
| Endpoint | `endpoint` | The Azure **Target URI** (the one ending in `.../completions` etc.). Base URI + query params are parsed from it per operation type. Required. |
| Key | `api_key` | A **Key** entity id (`key_select`) holding the API key. Required. |
| Type of model | `connect_header` | `api-key` (OpenAI-style header), `authorization` (generic `Authorization` header), or `other`. Required. |
| Custom Header | `custom_key_header` | Header name, required only when `connect_header` = `other`. |
| Custom Consumer | `custom_consumer` | Advanced; `2023-06-01-preview-extensions-chat-completion` swaps in `LightweightProviderClient` (for certain proxies). |
| Extra headers | `extra_headers` | Advanced; one `key:value` per line, token-aware (`user` tokens). |

Operation types you can add models for: `chat`, `embeddings`, `text_to_image`, `speech_to_text`,
`text_to_speech`.

## Where configuration is stored

- This module's own config object: `ai_provider_azure.settings` (schema
  `config/schema/ai_provider_azure.schema.yml`).
- The **model definitions** are stored by the AI module in `ai.settings` under
  `models.azure.<operation_type>.<model_id>` (read via `getModelsConfig()` / `getModelInfo()`), each
  carrying `endpoint`, `api_key`, `connect_header`, etc.

Inspect configured Azure models:

```bash
drush config:get ai.settings models
```

## Default generation parameters

Per-operation defaults (and their constraints) come from `definitions/api_defaults.yml`, e.g. chat:
`max_tokens` (default 4096), `temperature` (0–2), `frequency_penalty`, `presence_penalty`, `top_p`;
text_to_image: `n`, `size` (256/512/1024); text_to_speech: `voice`
(alloy/echo/fable/onyx/nova/shimmer), `response_format`; speech_to_text: `language`, `prompt`,
`response_format`, `temperature`. These are what `getApiDefinition()` returns.
