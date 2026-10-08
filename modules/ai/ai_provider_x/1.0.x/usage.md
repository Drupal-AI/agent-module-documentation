<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
X AI Provider registers X (xAI / Grok) as a provider for the Drupal AI module.

---

X AI Provider ships a single `x` AI-provider plugin that plugs into the Drupal AI module's provider
abstraction and points it at xAI's OpenAI-compatible endpoint (`https://api.x.ai/v1`). It exposes the Grok
chat models (`grok-2-latest`, `grok-2-1212`, and the vision model `grok-2-vision-1212`) for the AI module's
**chat**, **chat-with-image-vision** and **embeddings** operation types, with support for streamed chat
responses. Authentication uses a Key-module key, and models are hard-coded rather than fetched from an API.
It depends on the AI module and the Key module and lives in the "AI Providers" package. Configuration is a
single admin form at `/admin/config/ai/providers/x` gated by the AI module's `administer ai providers`
permission.

---

- Register X (Grok) as a selectable provider inside the Drupal AI module.
- Route AI-module chat calls to the Grok chat models.
- Send image-vision chat requests to `grok-2-vision-1212`.
- Attach base64-encoded images to a chat message for vision prompts.
- Stream chat completions token-by-token via the AI module's streaming API.
- Generate text embeddings through the `x` provider.
- Make Grok the default provider for the `chat` operation on first configuration.
- Make the vision model the default for the `chat_with_image_vision` operation.
- Store the xAI API key as a Key entity rather than in plain module config.
- Set the API key on the settings form at `/admin/config/ai/providers/x`.
- Restrict provider configuration to users with `administer ai providers`.
- Let the AI Automators / Agents features use Grok as their backing model.
- Power a chatbot block that answers with Grok.
- Summarize or rewrite node content with Grok via the AI module.
- Classify or extract data from text using Grok chat.
- Describe or answer questions about an uploaded image with the vision model.
- Build embeddings for a RAG / similarity search pipeline backed by xAI.
- Swap an existing OpenAI/Anthropic AI-module workflow onto Grok by changing the provider.
- Test Grok prompts from the AI module's API Explorer UI.
- Use Grok programmatically via `\Drupal::service('ai.provider')->createInstance('x')`.
- Hot-swap the API key at runtime with `setAuthentication()` for multi-tenant setups.
