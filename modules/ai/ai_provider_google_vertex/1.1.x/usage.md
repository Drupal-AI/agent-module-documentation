<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Vertex is an AI provider plugin that lets the Drupal AI module use chat, embeddings and translation models from Google Vertex AI (for example Gemini), authenticating with a Google Cloud service account.

---

Google Vertex (ai_provider_google_vertex) registers a `google_vertex` provider plugin for the Drupal AI module so that AI operations — chat/completion, embeddings and text translation — can be routed to Google Vertex AI in your own Google Cloud project. It authenticates using a service-account credential JSON that is stored in a Key entity (drupal/key), and at request time it exchanges those credentials for a short-lived OAuth2 bearer token (via the google/auth library) and calls the regional Vertex AI REST API. Rather than shipping a fixed model list, it lets an administrator add models dynamically on the provider settings page by supplying a Google Cloud Project ID, a Location/region and a Vertex model id (plus an optional Vertex AI Search datastore for grounding). Gemini models additionally accept image, document and video inputs where the model supports them, and function-calling tools are translated into Vertex's `function_declarations` format. Text translation is handled through two hardcoded model families exposed by the provider: Translation LLM (TLLM) and Neural Machine Translation (NMT). The module depends on the ai and key modules and the google/cloud-ai-platform Composer package, and streaming responses additionally require gRPC for PHP.

---

- Use Google Vertex AI (Gemini and other Model Garden models) with the Drupal AI module.
- Run chat/completion operations against Vertex from any AI-module consumer.
- Generate text embeddings through Vertex embedding models.
- Perform machine translation via Vertex Translation LLM (TLLM) or Neural Machine Translation (NMT).
- Authenticate to Google Cloud using a service-account JSON credential.
- Store the service-account credential in a Key entity instead of plaintext config.
- Add models dynamically by entering Project ID, Location and Vertex model id.
- Target a specific Google Cloud region (for example europe-west4 or us-central1).
- Ground chat responses on a Vertex AI Search datastore (BigQuery, Firestore, etc.).
- Send image, document and video inputs to Gemini models that support them.
- Use function-calling tools with Vertex chat models.
- Read prompt-feedback and token-usage metadata returned by Vertex.
- Route the AI module's abstracted operations to Google-backed models.
- Select which Vertex model backs each AI operation type in your site.
- Use high token limits offered by Gemini models.
- Support multi-provider AI setups alongside other provider modules.
- Configure everything from the provider settings form under AI providers.
- Restrict configuration to users with the "administer ai providers" permission.
- Enable streaming chat output (requires gRPC for PHP and a streaming-capable web server).
- Keep Google Cloud credentials out of exported configuration.
