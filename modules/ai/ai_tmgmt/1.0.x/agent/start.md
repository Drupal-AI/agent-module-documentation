<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Translator (ai_tmgmt) — agent index

Adds one **TMGMT translator plugin** (`id: ai`) backed by the **AI** module's chat
providers, so any LLM the site has configured (OpenAI, Ollama, Anthropic, …) can machine-
translate content inside TMGMT's job/review workflow. Pure glue: no HTTP of its own — all
provider calls go through `ai.provider` / the `ai_translate` submodule.

- Depends on `drupal/ai ^1.0.4` and `drupal/tmgmt ^1.16`. Core `^10 || ^11`.
- Newest release is **1.0.0-beta6** (no stable release on the 1.0.x branch yet).
- No settings page of its own. Configure via TMGMT's translator collection —
  `configure: entity.tmgmt_translator.collection` (`/admin/tmgmt/translators`).
- No permissions, no drush commands, no config/install. Provides config **schema**.

Solution docs:
- **Set up / configure the AI translator (form, config object, drush/PHP)** → [configure/translator.md](configure/translator.md)
- **The `@TranslatorPlugin` + queue worker + translation flow (prompt, chunking, batch/queue)** → [plugins/translator.md](plugins/translator.md)
- **Why translated HTML/URLs are preserved (PreGenerateResponseEvent subscriber)** → [events/pre-request.md](events/pre-request.md)

Key facts (real machine names):
- TMGMT translator plugin id: `ai` (class `Drupal\ai_tmgmt\Plugin\tmgmt\Translator\AiTranslator`, UI `Drupal\ai_tmgmt\AiTranslatorUi`).
- Queue worker plugin id: `ai_translator_worker` (cron `time = 120`); state key `ai_tmgmt.queue.suspend_until`.
- Config entity: `tmgmt.translator.<name>` with `plugin: ai`; schema `tmgmt.translator.settings.ai`.
- Settings keys: `model_selection_type` (`ai_translate` | `ai_tmgmt`), `chat_model`, `tokenizer_model`, `advanced.prompt`, `advanced.max_tokens`, `advanced.rate_limit_delay`, `advanced.max_attempts`.
- Prompt tokens: `%source%`, `%target%`, `%source_code%`, `%target_code%`.
- Services: `ai_tmgmt.hook` (implements `hook_entity_delete` to purge queue items for deleted jobs/items), `ai_tmgmt.pre_request_event_subscriber`.
- AI-module services consumed: `ai.provider`, `ai.tokenizer`, `ai.text_chunker`; and, in `ai_translate` mode, `ai_translate.text_extractor` + `ai_translate.text_translator`.
