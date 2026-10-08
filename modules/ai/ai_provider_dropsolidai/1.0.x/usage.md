Guides a Drupal site through installing, configuring and testing the full Dropsolid AI stack (LiteLLM gateway provider, optional vector database and tracing) from one setup wizard.

---

AI Provider: Dropsolid AI is a configuration hub for connecting Drupal's AI ecosystem to the Dropsolid AI platform, a managed OpenAI-compatible LLM gateway. Rather than shipping its own AI provider plugin, it delivers a vertical-tab setup wizard at /admin/config/ai/providers/dropsolidai that walks a site builder through the components of a complete AI deployment: the LiteLLM AI provider (the actual chat/completions connection to the Dropsolid gateway), an optional PostgreSQL/PGVector vector database for embeddings and RAG, optional LangFuse tracing and analytics, and Dropsolid-specific AI extras. Each tab offers install commands, a link to the relevant module's own settings, and an AJAX "test connection" button that reads the component's configuration (with API keys and database passwords resolved from Key entities), attempts a real connection, and reports success or a friendly error. The module tracks each component's configured/tested state in its own config object, and signposts a future one-click Dropsolid SSO auto-setup (currently a placeholder). It requires the AI module and ai_provider_litellm.

---

- Set up a Dropsolid AI connection for Drupal through one guided wizard instead of configuring each module separately.
- Install and configure the LiteLLM AI provider that fronts the Dropsolid OpenAI-compatible gateway.
- Live-test the LiteLLM connection and see how many models are available before relying on it.
- Add an optional PostgreSQL/PGVector vector database for embeddings and semantic search.
- Test the vector database connection with a ping from the setup screen.
- Enable optional LangFuse tracing and analytics for AI request observability.
- Test LangFuse connectivity across its bearer-token, basic-auth or key-pair auth methods.
- Install Dropsolid-specific AI extras (ai_dropsolid) such as custom tokenizers and reranking models.
- Get copy-paste composer/drush commands for each required and optional module.
- Jump directly to each component module's own admin settings from the wizard.
- Track which components are configured and which have passed a connection test.
- Store all provider and database secrets in Key entities rather than plaintext configuration.
- Diagnose LiteLLM auth failures, budget-exceeded errors and missing model lists from readable messages.
- Use the Dropsolid gateway as a drop-in OpenAI-compatible endpoint for any AI feature (AI Search, chatbot, content tools).
- Build RAG chatbots and AI Search on Dropsolid's managed PGVector database.
- Keep AI data sovereign by routing all model calls through the managed Dropsolid platform.
- Cache connection-test results briefly to avoid repeated live calls while configuring.
- Prepare for one-click Dropsolid SSO auto-setup once that feature ships.
- Export the module's per-component setup status through Drupal configuration management.
