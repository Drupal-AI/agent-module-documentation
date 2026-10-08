<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Summarizer produces AI summaries and SEO title suggestions for nodes, using its own pluggable LLM provider layer (OpenAI, Anthropic, Gemini, Ollama).
---
The module ships a small provider abstraction (`LlmProviderManager` + `LlmProviderInterface`) with implementations for OpenAI, Anthropic (Claude), Google Gemini and local Ollama. `ContentSummarizer::summarizeNode()` extracts text from configured source fields, builds a prompt from a configurable template, calls the active provider over Guzzle, truncates to a max length, and stores the result in the `ai_content_summary` table. Optional title suggestions are parsed from a second prompt. Summaries can be generated manually or auto-generated on node save (`hook_node_presave`), and rendered on node view.

Operate it from `/admin/config/content/ai-summarizer` (`administer ai content summarizer`): choose the provider, enter its API key, select enabled content types, source fields, prompts and behaviour. Manual runs use `/admin/content/ai-summarize` (bulk list) and the per-node summarize route (`use ai content summarizer`, CSRF-protected). These are cost-bearing external calls; every trigger route is behind the `use ai content summarizer` permission.
---
- Generate an AI summary for a single node on demand.
- Bulk-list content with per-row Summarize/Regenerate links.
- Auto-summarize nodes when they are created or updated.
- Produce alternative SEO-friendly title suggestions.
- Choose OpenAI as the summarization provider.
- Choose Anthropic (Claude) as the provider.
- Choose Google Gemini as the provider.
- Run fully local inference through Ollama.
- Point OpenAI at an Azure/OpenAI-compatible base URL.
- Select which content types are eligible for summarization.
- Configure which source fields feed the summary text.
- Edit the summary prompt template.
- Edit the title-suggestion prompt template.
- Cap the summary length in characters.
- Render the stored summary on the node page.
- Store summaries per language in the `ai_content_summary` table.
- Restrict configuration to administrators, use to editors.
- Regenerate a summary after content changes.
- Switch providers without losing other providers' saved settings.
- Review which model produced each stored summary.
- Delete summaries automatically when their node is deleted.