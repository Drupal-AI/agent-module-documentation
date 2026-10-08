<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Summarizer (ai_content_summarizer) — agent index

**Summarizes nodes and suggests titles through a built-in OpenAI/Anthropic/Gemini/Ollama provider layer.**

- **Version:** 1.0.x (1.0.1)  •  **Core:** ^10.3 || ^11 || ^12  •  **Package:** AI
- **Depends on:** node
- **Routes:** `ai_content_summarizer.settings` `/admin/config/content/ai-summarizer` (`administer ai content summarizer`); `ai_content_summarizer.bulk_summarize` `/admin/content/ai-summarize` (`use ai content summarizer`); `ai_content_summarizer.summarize_node` `/admin/content/ai-summarize/{node}` (`use ai content summarizer`, `_csrf_token: TRUE`).
- **Permissions:** `administer ai content summarizer` (restricted), `use ai content summarizer`.
- **Services:** `ai_content_summarizer.summarizer`, `ai_content_summarizer.llm_provider_manager`.  **Storage:** `ai_content_summary` table.

**Security:** trigger routes are permission-gated (`use ai content summarizer`) and the single-node route is CSRF-protected; no anonymous access. See [configure/settings.md](configure/settings.md).
