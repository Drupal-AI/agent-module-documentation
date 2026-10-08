<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search Block Log Tag (ai_search_block_log_tag) — agent index

Submodule of `ai_search_block`. AI-classifies logged search questions into a controlled per-block
tag vocabulary, asynchronously on cron.

## Dependencies
- `ai_search_block_log` (which requires `ai_search_block`). Core `^10.2 || ^11 || ^12`.

## Provides
- Service `ai_search_block_log_tag.service` (`Service/AiSearchBlockLogTagService`):
  `queueLogForTagging($logId)` and `processLogTagging($logId)` (calls the model, stores matching tags).
- QueueWorker plugin `ai_search_block_log_tag_worker`
  (`Plugin/QueueWorker/AiSearchBlockLogTagWorker`).
- DB table `ai_search_block_log_tag` (`hook_schema` in `.install`): `id`, `ai_search_block_log_id`,
  `tag`.
- Hooks (`Hook/AiSearchBlockLogTagHooks`): `hook_cron` (claims + processes a batch of queue items),
  `hook_entity_update` (queues a log when its `response_given` is first populated),
  `hook_entity_delete` (removes a log's tag rows).
- Controller `AiSearchBlockLogTagController::graphsTags()` → route
  `ai_search_block_log_tag.graphs.tags` (`/admin/config/ai/ai_search_block_log/graphs/tags`,
  `_permission: administer ai_search_block_log`).
- Config form `AiSearchBlockLogTagSettingsForm` (route `ai_search_block_log_tag.settings`) and bulk
  process form `AiSearchBlockLogTagProcessForm` (route `ai_search_block_log_tag.process`), both
  `_permission: administer ai_search_block_log_tag`.
- Permission `administer ai_search_block_log_tag` (`restrict access: true`). Config
  `ai_search_block_log_tag.settings` (`blocks` per-block enabled+tags, `tagging_prompt`, `ai_model`,
  `cron_batch_size`).

## Solution doc
- Tagging pipeline, config & routes: [agent/services/tagging.md](services/tagging.md)
