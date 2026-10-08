<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Translator (`ai_tmgmt`) exposes a single TMGMT translator plugin (id `ai`) that machine-translates job-item text with whatever chat provider the **AI** module has configured, so LLM translation happens inside TMGMT's established job / review / acceptance workflow.

---

TMGMT is Drupal's mature translation-management framework: jobs, job items, review, acceptance, and one translator plugin per service. This module adds a translator backed by the AI module's provider abstraction, which means any configured LLM — hosted (OpenAI, Anthropic, …) or local (Ollama) — can drive translation without new tooling. Two methods are offered on the translator's TMGMT settings form (`/admin/tmgmt/translators`, plugin `ai`): a **basic prompt** (`ai_tmgmt`) that builds a system prompt from a template with `%source%`/`%target%`/`%source_code%`/`%target_code%` tokens and calls the selected `chat_model`, or **AI Translate module prompts** (`ai_translate`) that delegate to the `ai_translate` submodule's per-language prompts and context. Source text is flattened via `tmgmt.data`, chunked by token count (`ai.tokenizer` / `ai.text_chunker`, or a DOM-aware splitter for HTML), and queued on the `ai_translator_worker` queue; a UI submit runs a batch immediately, continuous jobs run on cron, and the worker handles rate-limit backoff (state `ai_tmgmt.queue.suspend_until`) and per-item retries (`max_attempts`) before aborting a job item. There is no admin page of its own and no permissions or drush commands — provider, model catalogue and API credentials all live in the AI module. Requirements are `ai ^1.0.4` and `tmgmt ^1.16`, core `^10 || ^11`; the newest release is 1.0.0-beta6 (no stable on 1.0.x yet). LLM translations are drafts that pass through TMGMT's review step, hosted providers bill per token so job size is a cost, and a locally hosted model keeps content in-house.

---

- Machine-translate content with an LLM inside TMGMT.
- Use a local Ollama model so content never leaves the building.
- Choose the chat model per translator (basic-prompt method).
- Use the AI Translate submodule's per-language prompts (advanced method).
- Tweak translation tone/style by editing the prompt template.
- Translate one or many nodes through TMGMT sources.
- Drive translation from TMGMT jobs and review before acceptance.
- Route some languages to AI and others to human vendors.
- Translate a backlog cheaply with automated jobs.
- Provide first-draft translations for editors to post-edit.
- Reuse one AI provider across translation and other AI tasks.
- Handle large fields via token-based chunking without hitting model limits.
- Preserve HTML structure and links through the translation round-trip.
- Process translations on cron for large or continuous jobs.
- Back off automatically when the provider rate-limits (HTTP 429).
- Retry transient provider failures and abort cleanly on repeated errors.
- Estimate cost by sizing jobs against a tokenizer model.
- Migrate off the legacy TMGMT OpenAI module.
- Test an LLM's quality per language pair before committing.
- Keep the existing TMGMT review/acceptance workflow unchanged.
- Add AI translation to a multilingual site without new infrastructure.
