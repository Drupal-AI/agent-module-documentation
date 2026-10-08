AI Anthropic Provider (OAuth) adds an AI-module chat provider that authenticates to Anthropic's Messages API with a long-lived `claude setup-token` (a Bearer token stored via the Key module) instead of an official API key.

---

The module registers a single AI provider plugin, `anthropic_oauth` ("Anthropic (OAuth Token)"), that lets the Drupal AI framework run chat operations against the native Anthropic API (`https://api.anthropic.com/v1/messages`) using a setup-token produced by the `claude setup-token` CLI command (prefix `sk-ant-oat01-`, valid for roughly a year, with no refresh flow — you re-run the command when it expires). Because the OpenAI-compatible endpoint does not accept these tokens, the provider calls the Anthropic API directly and translates between the AI module's `ChatInput`/`ChatMessage`/tool types and Anthropic's message and `tool_use`/`tool_result` blocks. It injects the beta headers (`claude-code-20250219,oauth-2025-04-20`) and a Claude Code identity system prompt so that Sonnet and Opus models are reachable with a setup-token, discovers available models from `GET /v1/models` (falling back to a hardcoded list), and can optionally register OpenAI external moderation for each request. The token itself is held by the Key module and only the Key entity id is stored in module configuration. The module's settings form prominently warns that third-party use of setup-tokens may violate Anthropic's Terms of Service and recommends `ai_provider_anthropic` with official API keys for production; treat this as a development, testing, and internal-tooling convenience for holders of a Claude Pro/Max/Team subscription.

---

- Use an existing Claude Pro/Max/Team subscription for Drupal AI features instead of separate pay-per-token API billing.
- Register Anthropic Claude as a selectable chat provider in the AI module without an official API key.
- Authenticate the AI module to Anthropic with a `claude setup-token` long-lived Bearer token.
- Store the setup-token securely through the Key module (env-variable or config provider) rather than in plain settings.
- Run chat operations (`getSupportedOperationTypes()` returns `chat`) against Claude models from any AI-module consumer.
- Send text prompts to Claude Opus, Sonnet, and Haiku 4.x models through the standard AI provider interface.
- Pass images to vision-capable Claude models (base64-encoded image content blocks) via chat messages.
- Use Anthropic tool/function calling — the provider converts OpenAI-style tool definitions to Anthropic `input_schema` tools and back.
- Feed tool results back to Claude (OpenAI `tool` role mapped to Anthropic `tool_result` blocks).
- Discover the current Anthropic model list automatically from `GET /v1/models`, cached (default 24h) with a hardcoded fallback.
- Set sensible default models per operation type (Opus 4.6 for complex JSON/tools/structured, Sonnet 4.6 for chat and vision).
- Tune generation with `max_tokens`, `temperature`, `top_p`, and `top_k` provider configuration.
- Filter to JSON-capable models when a caller requests the `ChatJsonOutput` capability.
- Validate a configured token from the settings page with a lightweight live `GET /v1/models` call, showing a masked status.
- Get a clear masked token status ("configured / invalid / none") and format check (`sk-ant-oat01-` prefix, 80+ chars) in the admin UI.
- Optionally enable OpenAI-based external moderation for each Anthropic request (requires `ai_provider_openai` + `ai_external_moderation`).
- Explicitly acknowledge running without moderation via a required confirmation checkbox when OpenAI moderation is off.
- Build internal AI tools, chat assistants, or content helpers on a developer workstation without provisioning an official API key.
- Map Anthropic rate-limit and quota errors to the AI module's `AiRateLimitException` / `AiQuotaException` for consistent handling.
- Recover from expired/revoked tokens by re-running `claude setup-token` and updating the Key value — no code change needed.
- Prototype with Claude models locally, then switch to `ai_provider_anthropic` and official API keys for production.
