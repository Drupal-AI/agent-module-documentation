<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Translator machine-translates content entities, taxonomy terms and interface strings into a site's languages via any OpenAI-compatible API, while preserving human translations.

---

AI Content Translator is a small, self-hosted machine-translation tool. Point it at any OpenAI-compatible chat-completions endpoint (OpenAI, Azure OpenAI, or a local model such as Ollama / LM Studio / vLLM), choose a model, and translate nodes (recursing into referenced Paragraphs), taxonomy terms and `{{ 'string'|t }}` interface strings from the UI. Every enabled language except the site default is automatically a translation target. Translations the module generates are fingerprinted in a key-value store, so any translation a person authors or edits is treated as human work and is never overwritten by a normal run — regenerating an existing translation requires an explicit overwrite toggle on the bulk form. There are three UI entry points: a per-node "Translate with AI" box, a "Translate (AI)" column on each node's Translations tab, and a bulk "Run translations" admin page; long runs use the Batch API. The prompt is one configurable template with an `@language` token plus an optional per-language glossary, and optional model parameters (`reasoning_effort`, `verbosity`, `temperature`) are sent only when set. The API token is stored in State (not exported with configuration), with a `settings.php` value taking precedence for production. Source text is sent to the configured endpoint, so pick one whose data-handling terms suit your content or run a local model.

---

- Translate a single node into selected languages from the "Translate with AI" box on the node edit form.
- Translate one node into a target language from the "Translate (AI)" column on its Translations tab.
- Bulk-translate a whole content type (or all content types) from the Run translations page.
- Bulk-translate a taxonomy vocabulary's terms.
- Bulk-translate the site's interface (Twig) strings.
- Translate into one target language or all target languages at once.
- Recurse into referenced Paragraphs so structured content is translated as a whole.
- Preserve human-authored or human-edited translations automatically (fingerprint protection).
- Explicitly overwrite existing translations (including human ones) with the overwrite toggle when needed.
- Use OpenAI, Azure OpenAI, or a local OpenAI-compatible server (Ollama, LM Studio, vLLM).
- Keep the API token out of configuration exports by storing it in State.
- Override the token from `settings.php` for production deployments.
- Customise the translation prompt template with an `@language` token.
- Enforce preferred terminology with an optional per-language glossary (JSON).
- Send `reasoning_effort` / `verbosity` for GPT-5-family models only when set.
- Set a `temperature` for models that support it.
- Raise the request timeout for large content or slow reasoning models.
- Auto-detect target languages: every enabled language except the site default.
- Show a progress bar for long translation runs via the Batch API.
- Gate translating with the `translate content with ai` permission and admin with `administer ai content translator`.
- Extract and register new interface strings from theme and custom-module Twig templates.
- Publish generated taxonomy-term translations automatically.
- Complement TMGMT or the AI module's translation features as a lightweight single-purpose alternative.
- Run a local model to keep source content on-premise.
