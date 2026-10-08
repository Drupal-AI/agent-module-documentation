<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tagging pipeline, config & routes

## Trigger → queue → worker
1. `AiSearchBlockLogTagHooks::entityUpdate()` (`hook_entity_update`) fires when an
   `ai_search_block_log` row is saved. When `response_given` transitions from empty to non-empty
   (answer just completed), it calls `service->queueLogForTagging($id)`.
2. `AiSearchBlockLogTagService::queueLogForTagging()` adds `{log_id}` to the
   `ai_search_block_log_tag_worker` queue.
3. `hook_cron()` claims up to `cron_batch_size` (default 10) items and runs the worker.
4. `AiSearchBlockLogTagWorker::processItem()` → `service->processLogTagging($id)`.

## Classification (`AiSearchBlockLogTagService::processLogTagging()`)
- Loads the log; reads the per-block config `blocks[<block_id>]` — tagging must be `enabled` and have a
  `tags` list, else it returns early.
- Builds the prompt: `tagging_prompt` (or `getDefaultPrompt()`), substituting `[user_question]` (the
  logged question) and `[configuration_tags]` (the block's tag list).
- Loads the provider: explicit `ai_model` (`provider__model`) if set, else the AI module's default
  chat provider. Temperature 0. Calls `$provider->chat()` through `drupal/ai`.
- Parses the comma-separated response; **only tags that case-insensitively match the configured set
  are stored** (unknown/hallucinated tags are dropped). `NONE` → no tags. Idempotent: it first
  `DELETE`s existing tags for the log, then inserts the matched ones into `ai_search_block_log_tag`.

The stored `tag` value is always taken from the configured tag list (`$tags[$matched_index]`), not
from the raw model text — so the tag table only ever contains admin-defined strings.

## Config (`ai_search_block_log_tag.settings`)
`blocks` (map of block_id → {enabled, tags[]}), `tagging_prompt`, `ai_model`, `cron_batch_size`.
Edited via `AiSearchBlockLogTagSettingsForm` (route `ai_search_block_log_tag.settings`,
`/admin/config/ai/ai_search_block_log/config_log_tag`). Bulk-tag historical logs via
`AiSearchBlockLogTagProcessForm` (route `ai_search_block_log_tag.process`). Both require
`administer ai_search_block_log_tag`.

## Dashboard
`AiSearchBlockLogTagController::graphsTags()` (route `ai_search_block_log_tag.graphs.tags`,
`_permission: administer ai_search_block_log`) queries unique tags and per-day per-tag counts
(joining `ai_search_block_log_tag` to `ai_search_block_log`) via the DB API with bound conditions,
day-caches the build, and renders `ai_search_block_log_tag_graphs` (charts via
`js/tag-graphs.js`). Tags/labels are rendered through Twig autoescape.

## Schema (`ai_search_block_log_tag.install`)
`hook_schema` defines table `ai_search_block_log_tag` (`id`, `ai_search_block_log_id`, `tag`) with a
foreign-key reference to the log table; `update_9001` creates it if missing.
