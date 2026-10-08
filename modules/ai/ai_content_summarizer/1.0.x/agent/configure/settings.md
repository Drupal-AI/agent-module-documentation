<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Content Summarizer

Route: `/admin/config/content/ai-summarizer` — permission `administer ai content summarizer`.

Config object `ai_content_summarizer.settings`:
- `active_provider` — one of `openai`, `anthropic`, `gemini`, `ollama`.
- `provider_settings` — per-provider map. Each provider's `buildConfigForm()` exposes `api_key` (textfield), plus `model` and (OpenAI/Ollama) `base_url`. Keys are saved into config and preserved across provider switches.
- `enabled_content_types` — content types eligible for summarization.
- `source_fields` — comma-separated field machine names used as the summary source (default `body`).
- `auto_summarize_on_save` — generate on node create/update via `hook_node_presave`.
- `generate_title_suggestions` — also produce up to 5 alternative titles.
- `summary_max_length` — hard character cap (50–2000).
- `summary_prompt`, `title_prompt` — templates; node text is appended automatically.

Providers (`src/LlmProvider/*`): OpenAI POSTs `/v1/chat/completions`, Anthropic POSTs `/v1/messages`, Gemini calls `generativelanguage.googleapis.com` with `?key=`, Ollama POSTs `/api/generate`. All use Guzzle with default TLS verification.

Manual use: `/admin/content/ai-summarize` lists eligible nodes with Summarize/Regenerate links (`use ai content summarizer`); results are stored in `ai_content_summary` and shown on the node view.
