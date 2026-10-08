Adds DXPR AI (the DXAI Kavya multi-provider gateway) as an AI provider for the Drupal AI module, with chat, image generation, image editing and native text translation.

---

DXPR AI Provider implements a single `dxpr` provider plugin for the drupal/ai framework, connecting Drupal to the DXAI Kavya platform — an OpenAI-compatible gateway that fronts several upstream models (OpenAI, Claude, Gemini, xAI, MistralAI) with automatic failover, optional Perplexity web research, EU-resident routing and long-form generation. It supports four operation types: chat (streamed and non-streamed, with tools, vision and structured-JSON output), text-to-image and image-to-image (returning WebP), and a native translate_text operation whose content-aware prompt engine keeps HTML markup intact, translates specific attributes/elements, handles RTL languages and guards against prompt injection. The provider builds an openai-php client over Drupal's HTTP client (base URI defaults to kavya.dxpr.com/v1, overridable per site), authenticating with a Bearer token drawn from a Key entity. It adds DXPR-specific request fields (provider priority, allowed HTML tags/classes, web_search) and applies an em-dash post-processing mode (four intensity levels, with per-language overrides) to reduce the "AI slop" tell in generated text. Its settings form — gated by the `administer ai providers` permission — shows the account's credit balance and monthly usage, lets operators order providers, and validates the API key against the live endpoint. Requires the AI, Key and DXPR Builder modules.

---

- Use DXPR/Kavya as the site's chat model for AI-assisted authoring with automatic multi-provider failover.
- Keep AI content generation running when a single upstream provider is down or rate-limited.
- Generate long-form (10,000+ word) content in one request without hitting per-provider limits.
- Generate images from a text prompt (text-to-image) returning WebP output.
- Edit or transform an existing image with a prompt (image-to-image).
- Translate text natively via the translate_text operation instead of the generic ai_translate fallback.
- Preserve HTML markup exactly while translating only text content and selected attributes.
- Translate accessibility attributes (alt, title, placeholder, aria-label, and more) inside HTML.
- Handle right-to-left target languages (Arabic, Hebrew, Farsi, etc.) during translation.
- Reduce the em-dash "AI tell" in generated text with configurable post-processing intensity.
- Override the em-dash mode per language for multilingual sites.
- Route requests through kavya-m1-eu to keep data within EU boundaries.
- Send images alongside text for vision-based chat analysis.
- Produce structured JSON output from chat for downstream integrations.
- Call functions/tools from chat requests routed through DXPR.
- Stream chat responses token-by-token, preserving DXPR extra fields (e.g. word_count).
- Prioritize or reorder upstream AI providers from the settings form.
- Enable built-in web research to reduce hallucinations in generated content.
- Store the DXPR API key securely in a Key entity rather than plaintext config.
- Monitor the account credit balance and monthly usage from the provider settings page.
- Get a free-tier warning when the account is out of quota or on the free plan.
- Point the provider at an alternate DXPR-compatible host by overriding the base URL.
- Be warned on the AI settings page when the DXPR provider is installed but not yet configured.
