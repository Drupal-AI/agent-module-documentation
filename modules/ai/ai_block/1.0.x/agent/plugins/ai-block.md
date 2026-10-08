<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "AI Block" block plugin

## Install & enable

```bash
composer require drupal/ai_block
drush en ai_block -y
```

Dependencies: core **`block`** + **`config`**, and the contrib **AI** module (`drupal/ai`). Before the
block can produce anything, configure a default **chat** provider in the AI module
(`/admin/config/ai/providers` + the operation-type defaults) or select a specific model on the block.

## The plugin

`AiBlock` (`src/Plugin/Block/AiBlock.php`), attribute-less annotation `@Block(id = "ai_block")`, admin
label *"AI Block"*. Extends `Drupal\Core\Block\BlockBase` and implements
`ContainerFactoryPluginInterface`. Injected services (via `create()`): `ai.provider`
(`AiProviderPluginManager`, property `$aiProviderManager`) and `module_handler`.

There is **no** field type, widget, formatter, route, permission, Drush command or config schema — the
module is just this one placeable block plus a theme hook and two alter hooks.

## Place & configure it

UI: *Structure → Block layout → Place block → AI Block* (or add it as a block in a Layout Builder
section). The block config form (`blockForm()`) has three inputs:

| Form key | Type | Meaning |
|---|---|---|
| `usage` | select | `every_time` ("Every page load (might be costly)") or `time` ("Once per day (cache)"). **Stored but not acted on** in `build()` — see caveat. |
| `llm_model` | select | Provider/model to use, from `AiProviderPluginManager::getSimpleProviderModelOptions('chat')`. Empty option = *"Default from AI module (chat)"*. Stored as a `provider_id__model_id` string. |
| `prompt` | textarea | The chat prompt. Validated with `token_element_validate`; a `token_tree_link` (node/user, restricted tokens shown) is rendered beside it. |

`blockSubmit()` saves `prompt`, `llm_model`, `usage`, and additionally records placement identity:
- Stock Block layout: `block_id` = the block-config entity id, `block_offset` = ''.
- Layout Builder: `block_id` = the component UUID, `block_offset` = `"{weight}/{region}"`.

These `block_id` values are the second argument passed to both alter hooks.

## Render flow (`build()`)

1. Resolve model: if `llm_model` is empty, `AiProviderPluginManager::getDefaultProviderForOperationType('chat')`
   supplies `provider_id`/`model_id`; otherwise the stored `provider__model` string is split on `__`.
   `loadProviderFromSimpleOption()` loads the provider instance.
2. Token-replace the prompt: `\Drupal::token()->replace($prompt, ['node' => <current route node>, 'user' => <current user>])`.
3. `moduleHandler->alter('ai_block_prompt', $prompt, $config['block_id'])` — lets modules rewrite the final prompt string.
4. Call the model: `$provider->chat(new ChatInput([new ChatMessage('user', $prompt)]), $model, ['ai_search_block'])`.
   The tag array `['ai_search_block']` is passed to the AI module for logging/tagging.
5. `$response = $output->getNormalized()->getText() . "\n"`.
6. `moduleHandler->alter('ai_block_response', $output, $config['block_id'])` — note it alters the raw
   `$output` object, after `$response` was already extracted.
7. Return `['#theme' => 'ai_block_response', '#output' => $response, '#settings' => $this->configuration]`.

## Output template

`ai_block.module` `hook_theme()` declares `ai_block_response` (one variable, `output`, default NULL).
`templates/ai-block-response.html.twig`:

```twig
<div id="ai-block-response">
  <div class="ai-block-output">
    {{ output }}
  </div>
</div>
```

The model text is printed with `{{ output }}` (standard Twig auto-escaping). Override the template with a
theme-level `ai-block-response.html.twig` to change the wrapper markup or classes.

## Alter hooks (`ai_block.api.php`)

```php
function hook_ai_block_prompt_alter(&$prompt, $blockId) {
  if ($blockId == 'olivero_aiblock') {
    $prompt = str_replace('[my custom token]', time(), $prompt);
  }
}

function hook_ai_block_response_alter(&$aiResponse, $blockId) {
  // e.g. convert Markdown in the response to HTML.
}
```

Use `hook_ai_block_prompt_alter` to inject your own placeholders/data into the prompt (e.g. views data,
custom `[…]` tokens) keyed on `$blockId`. Use `hook_ai_block_response_alter` to post-process the model
output; it receives the AI response object.

## Caveat: the caching option is inert

`build()` never sets `#cache` max-age/contexts and never branches on `usage`. Whether you pick "Every page
load" or "Once per day", the block follows Drupal's default block render caching. Because the prompt can
depend on `node`/`user` tokens but no matching cache contexts are declared, plan cache behaviour yourself
(e.g. via a custom cache context, or by keeping prompts context-free) if per-node/per-user output matters.
