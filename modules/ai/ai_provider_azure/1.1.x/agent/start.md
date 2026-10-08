# Microsoft Azure AI (ai_provider_azure) — agent index

A **provider plugin for the Drupal AI module** (`drupal/ai`) that connects it to Azure AI Studio /
Azure OpenAI (and OpenAI-compatible endpoints). Registers one AI provider, `azure`. No models are
predefined — you add each model (endpoint + Key + header type) yourself. No permissions/plugins/Drush
of its own. Live calls need real Azure credentials.

- **Set up the provider: add a model, endpoint, Key-module API key, header type, settings & config keys** →
  [configure/setup.md](configure/setup.md)
- **The provider plugin API: operation types, capabilities, how the AI module calls it** →
  [api/provider.md](api/provider.md)

Key facts:
- Provider plugin id `azure` (`#[AiProvider(id: 'azure')]`, `AzureProvider extends AiProviderClientBase`).
- Configure route `ai_provider_azure.settings_form` → `/admin/config/ai/providers/azure`,
  permission `administer ai providers` (from the AI module).
- Requires `ai` + `key`; library `openai-php/client`. `hasPredefinedModels = FALSE`.
- Operation types: `chat`, `embeddings`, `text_to_image`, `speech_to_text`, `text_to_speech`.
  Capability: `StreamChatOutput`.
- Own config object `ai_provider_azure.settings`; model definitions live in the AI module's
  `ai.settings` → `models.azure.<operation_type>.<model_id>`.
- API key is a **Key** entity chosen via `key_select`; per-model **Endpoint** is the Azure Target URI.
