<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Azure OpenAI Augmentor registers Azure OpenAI Chat and Completions plugins with the Augmentor framework so Drupal AI transforms can be powered by Azure-hosted OpenAI models.

---

Azure OpenAI Augmentor is a thin provider module for the Augmentor framework. It contributes two `@Augmentor` plugins — `azure_openai_chat` (conversational responses via the chat endpoint) and `azure_openai_completions` (text completions) — implemented on top of the `openai-php/client` library. Each plugin extends the module's `AzureOpenAIBase` class, which adds Azure-specific configuration (a resource/deployment **base URL**, an **API version**, and a **prompt** template) on top of Augmentor's shared label / API-key / debug fields. The API key is selected from a Key-module key entity and injected as the `api-key` HTTP header at request time; the deployment base URL and `api-version` query parameter target a specific Azure OpenAI model. Augmentors are created and configured from Augmentor's admin list at `webservices > augmentors`, so this module ships no routes, permissions, config schema, or services of its own. It requires the Augmentor module and Drupal 9.3+, 10, or 11.

---

- Add Azure OpenAI as a provider option within the Augmentor framework.
- Configure an `azure_openai_chat` augmentor for conversational responses.
- Configure an `azure_openai_completions` augmentor for text completions.
- Point an augmentor at a specific Azure deployment via its base URL.
- Pin the Azure API version (e.g. `2023-09-15-preview`) per augmentor.
- Store the Azure API key in a Key entity rather than in plain config.
- Reuse a single Key-module key across multiple augmentors.
- Build a prompt template with an `{input}` placeholder for the source text.
- Summarize node/field content through an Azure-backed Augmentor action.
- Classify or tag content using Azure completions.
- Generate draft copy or alt text from existing field values.
- Rewrite or normalize text via a chat augmentor with a fixed system prompt.
- Choose the chat message role (`user` or `assistant`) per augmentor.
- Tune completion `temperature` and `max_tokens` in advanced settings.
- Clean input HTML/whitespace automatically before sending to Azure.
- Truncate long inputs (default 10,000 chars) to control token usage.
- Power Augmentor field/entity actions with Azure OpenAI instead of public OpenAI.
- Run enterprise AI workloads against Microsoft-hosted OpenAI models.
- Keep AI traffic within an Azure tenant/region for compliance needs.
- Swap models by editing the deployment base URL without code changes.
- Enable per-augmentor debug logging via the inherited debug toggle.
- Support Drupal 9.3, 10, and 11 sites already running Augmentor.
