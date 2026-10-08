<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Providers API is a lightweight plugin system for sending prompts to LLM providers (Claude, Gemini, Ollama) through one common interface, with a settings UI and a JS response-streaming API.

---

AI Providers API gives developers a small, opinionated way to talk to LLMs from Drupal without the weight of a larger AI framework. It defines an `AiProvider` plugin type, a plugin manager, an `AiService` entry point with `prompt()` and `streamPrompt()` methods, and ships three provider plugins out of the box: Claude, Gemini and Ollama. Providers are enabled and configured (API key, model, optional endpoint override) on an admin settings form gated by the `administer ai providers` permission. A JavaScript library (`ai_streaming_api`) plus a `/ai/stream` POST endpoint let pages stream a model's reply word-by-word into the DOM; that endpoint is access-controlled by the `hook_ai_stream_access($body, $account)` hook, which denies by default unless an implementing module (such as LMS AI) explicitly allows the request. It is built for Drupal 11 and is intended as a simpler alternative to the `drupal/ai` package for developers who want minimal ceremony.

---

- Send a one-shot prompt to an LLM with `AiService::prompt($provider_id, $prompt)`.
- Stream an LLM reply with `AiService::streamPrompt()` and render it progressively.
- Use Claude (Anthropic) as the backing provider.
- Use Google Gemini as the backing provider.
- Use a local/self-hosted Ollama server as the backing provider.
- Enable and configure providers at `/admin/ai-providers/settings`.
- Override the model per call via the `options['model']` argument.
- Override a provider's API endpoint URL from the admin form.
- Add a custom provider by extending `AiProviderBase` and adding the `#[AiProvider]` attribute.
- Stream AI replies into a page element with the `ai_streaming_api` JS behavior.
- Gate the `/ai/stream` endpoint with a custom `hook_ai_stream_access` implementation.
- Build an LMS/tutoring feature that grades or answers using an LLM.
- Attach extra POST parameters to a streamed request via `extraParams`.
- Keep a per-integration prompt/response history and send it back as context.
- Restrict provider administration to the `administer ai providers` permission.
- Alter prompts before dispatch with `hook_ai_providers_api_prompt_alter`.
- Provide a common interface so calling code is provider-agnostic.
- Learn AI integration patterns from a deliberately small codebase.
- Swap between hosted (Claude/Gemini) and local (Ollama) models without code changes.
- Return only enabled providers to callers via the plugin manager.
- Use it as the AI backend for another contrib module (e.g. LMS AI).
