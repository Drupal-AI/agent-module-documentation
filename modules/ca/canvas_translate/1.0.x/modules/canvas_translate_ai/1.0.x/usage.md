Canvas Translate AI adds optional AI machine translation to Canvas Translate, pre-filling translation drafts with suggestions from a Drupal AI provider for human review.

---

Canvas Translate AI is a submodule of Canvas Translate that plugs the contrib `ai` module into the translation workspace. It exposes two POST endpoints (one for pages, one for config layouts) that take the editor rows the SPA already holds — `{key, format, source}` items — and return a suggested target value per key. The `AiTranslator` service prefers the AI module's dedicated `translate_text` operation and, if no provider is configured for it, falls back to the general `chat` operation with a translation system prompt (so a site with only a chat provider such as OpenAI still gets machine translation). The suggestions go straight back to the SPA, which applies them to the current translation draft; the submodule never loads or writes Canvas content and never publishes. When enabled, the parent's editor shows AI controls (a bulk "AI translate" action and per-row suggestions); the parent detects the submodule by module presence, keeping itself free of any hard dependency on Drupal AI. A single request is capped (200 items, 20000 chars per string) and provider failures degrade to a friendly error rather than a 500.

---

- Pre-fill an empty translation draft with AI-suggested target values for a Canvas page.
- Suggest a translation for a single editor row on demand.
- Machine-translate the strings of a content template or page region (config layout).
- Use the AI module's dedicated Translate Text provider when one is configured.
- Fall back to a Chat provider (e.g. OpenAI) with a translation prompt when no Translate Text provider exists.
- Preserve embedded HTML markup in rich-text rows by sending them verbatim to the provider.
- Keep every AI suggestion in the draft for human review before it is ever published.
- Cap a bulk translate request to protect against runaway token cost / long-held connections.
- Reject translating into an unknown language or into the source language.
- Enable AI controls in the Canvas Translate editor simply by turning on this submodule.
- Turn AI assistance off site-wide by uninstalling the submodule, leaving the human workflow intact.
- Get a clear "set up a provider" message when no AI provider is configured yet.
- Surface transient provider errors (rate limit, quota, timeout) as a retryable message.
