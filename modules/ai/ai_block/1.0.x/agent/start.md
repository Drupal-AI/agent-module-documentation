<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Block (ai_block) — agent index

One **Block plugin** whose rendered body is the text an AI chat model returns for an editor-defined
prompt. Package `AI`. Core `^10 || ^11`. License GPL-2.0-or-later. Project version 1.0.0.

Depends on core **`block`**, **`config`**, and the contrib **`ai`** module (used for provider/model
selection and the chat call). A default **chat** provider must be configured in the AI module.

- **The block plugin, its config form fields, token handling, alter hooks, and the render template** →
  [plugins/ai-block.md](plugins/ai-block.md)

## What it actually is

- One plugin: `AiBlock` (id **`ai_block`**, admin label *"AI Block"*) in
  `src/Plugin/Block/AiBlock.php`, extending core `BlockBase`. No entities, no routes, no services,
  no permissions of its own, no Drush, no config schema. It is selected/placed like any core block.
- `ai_block.module` declares one theme hook, **`ai_block_response`** (variable `output`), rendered by
  `templates/ai-block-response.html.twig` (`{{ output }}` inside `#ai-block-response`).
- `ai_block.api.php` documents two alter hooks: **`hook_ai_block_prompt_alter(&$prompt, $blockId)`**
  and **`hook_ai_block_response_alter(&$aiResponse, $blockId)`**.

## Mechanism (from source)

- `build()` reads `prompt`, `llm_model`, `usage` from block config. If `llm_model` is empty it uses the
  AI module's default chat provider (`ai.provider`→`getDefaultProviderForOperationType('chat')`); else it
  splits the `provider__model` option. It runs `\Drupal::token()->replace()` on the prompt with `node`
  (current route node) and `user` (current user), fires `hook_ai_block_prompt_alter`, then calls
  `$provider->chat(new ChatInput([new ChatMessage('user', $prompt)]), $model, ['ai_search_block'])`.
  The normalized text (`getNormalized()->getText()`) becomes the `#output` render variable.
- `blockForm()` exposes: **usage** (`every_time` / `time`), **llm_model** (from
  `getSimpleProviderModelOptions('chat')`, empty option = AI-module default), **prompt** (textarea with
  `token_element_validate` + a `token_tree_link`). `blockSubmit()` also records `block_id`/`block_offset`
  (block-config entity id, or the Layout Builder component UUID + weight/region).

## Notes / caveats

- The **usage** select (`every_time` vs `time` = "once per day") is **not wired into `build()`** — the
  plugin sets no `#cache` max-age or contexts, so output follows default block render caching regardless
  of the chosen option. The prompt uses `node`/`user` tokens but the plugin declares no matching cache
  contexts, so treat per-user/per-node variance as a caching caveat when placing the block.
- Requires the AI module to have a working **chat** provider (and its API key) configured; otherwise the
  chat call has no provider to run against.
