<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks

Declared in `ai_search_block.api.php`, invoked from `AiSearchBlockHelper`.

- `hook_ai_search_block_prompt_alter(string &$prompt): void` — alter the final aggregation prompt
  string just before it is sent to the LLM. Invoked in `fullEntityCheck()` via
  `$moduleHandler->alter('ai_search_block_prompt', $message)`. Use it to inject custom tokens.
- `hook_ai_search_block_entity_html_alter(MarkupInterface|string &$rendered_entity, EntityInterface $entity): void`
  — alter a source entity's rendered HTML before it is converted to markdown. Invoked in
  `cleanupHtml()`.
- `hook_ai_search_block_entity_markdown_alter(string &$rendered_entity, ?EntityInterface $entity): void`
  — alter the markdown that will be placed into the prompt for an entity/chunk. Invoked in
  `cleanupMarkdown()`.

Prompt placeholders available in `aggregated_llm` (substituted in `fullEntityCheck()` /
`getPrePromptDrupalContext()`): `[question]`, `[entity]`, `[is_logged_in]`, `[user_name]`,
`[user_roles]`, `[user_id]`, `[user_language]`, `[user_timezone]`, `[page_path]`, `[page_language]`,
`[site_name]`, `[date_today]`, `[date_yesterday]`, `[date_tomorrow]`, `[time_now]`. The marker
`---! SPLIT !---` splits the prompt into a system message and a user message.

Theme hooks (`Hook/AiSearchBlockHooks::theme()`): `ai_search_block_response`
(vars `output`, `wrapper_id`) and `ai_search_block_wrapper` (var `rendered_form`).
