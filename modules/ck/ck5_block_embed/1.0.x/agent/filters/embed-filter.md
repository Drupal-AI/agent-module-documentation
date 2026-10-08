<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Embed blocks" filter and the embed plugin type

## The filter: `src/Plugin/Filter/Ck5BlockEmbed.php`
- `@Filter` id **`ck5_block_embed`**, title "Embed blocks",
  `type = TYPE_TRANSFORM_REVERSIBLE`, `weight = 100`, marked `@internal`. Injects `renderer` and
  `plugin.manager.ck5_block_embed`.
- `process($text, $langcode)`:
  1. `preg_match_all('/<ck5-block-embed(.*?)>/is', $text, $matches)` — finds every opening
     `<ck5-block-embed …>` tag. Returns early if none.
  2. For each match, regex-extracts `data-plugin-config="([^"]+)"` (JSON, `html_entity_decode` +
     `json_decode`) and `data-plugin-id="([^"]+)"`. Skips the tag if no plugin id.
  3. `createInstance($plugin_id, $plugin_config)` on the embed plugin manager, calls `->build()`,
     and renders the result inside a `RenderContext` via `executeInRenderContext(... renderer->render())`.
  4. On any `\Exception`, substitutes a translated error string naming the plugin id and message.
  5. `str_replace($match, $render, $text)` — swaps the placeholder for the rendered HTML.
  6. Returns `new FilterProcessResult($text)`.
- The filter renders whatever block, view, or theme-region block the `data-plugin-id` +
  `data-plugin-config` placeholder names, in the order they appear in the text, and returns the
  combined HTML as a `FilterProcessResult`.

## The custom embed plugin type
- Manager `Ck5BlockEmbedPluginManager` (service `plugin.manager.ck5_block_embed`, parent
  `default_plugin_manager`): namespace `Plugin/Ck5BlockEmbed`, interface `Ck5BlockEmbedInterface`,
  annotation `@Ck5BlockEmbed` (`id`, `title`/`label`, `description`), alter hook
  `ck5_block_embed_info`, cache key `ck5_block_embed_plugins`.
- `Ck5BlockEmbedPluginBase` implements `Ck5BlockEmbedInterface` (extends `PluginFormInterface`,
  `ConfigurableInterface`): `id()`, `label()`, `build(): array`, `getAttachments()`, `isInline()`,
  `buildConfigurationForm()`, `massageFormValues()`, config get/set with `defaultConfiguration()`.
  `submitConfigurationForm()` in the base is documented "never called".

### `content_block` — `Plugin/Ck5BlockEmbed/ContentBlock.php`
- Config: `block_id` (a `block_content` entity id).
- `build()`: `BlockContent::load($block_id)`, then
  `entityTypeManager->getViewBuilder('block_content')->view($block_content)`. Fallback markup if the
  id is empty or the entity is missing.
- Picker `buildConfigurationForm()`: `BlockContent::loadMultiple()` grouped by block-content type —
  lists **every** custom block on the site.

### `view_block` — `Plugin/Ck5BlockEmbed/ViewBlock.php`
- Config: `block_id` = JSON `{view_id, display_id}`.
- `build()`: `Views::getView($view_id)`, `setDisplay($display_id)`, `render()`. Returns the render
  array (or the string "View not found."). Note it calls `render()` directly — it does **not** call
  `$view->access($display_id)`, so the view display's access plugin is not evaluated on this path
  (query-level protections such as node access grants still apply to node data).
- Picker: `Views::getAllViews()`, offering every `block` display whose `page.path` is empty.

### `theme_block` — `Plugin/Ck5BlockEmbed/ThemeBlock.php`
- Config: `block_id` = JSON `{theme, block_id}` naming a `block` config entity.
- `build()`: loads the `block` entity, verifies `$block->getTheme() == $theme`, then
  `getViewBuilder('block')->view($block)` wrapped in `renderer->renderRoot()` and returned as
  `#markup`.
- Picker: loads all `block` entities of the site default theme (`system.theme:default`), grouped by
  region label (`system_region_list`). Includes core/contrib/custom blocks placed in that theme.
- `submitConfigurationForm()` here (unlike the base) writes `block_id` back into configuration.

## Enabling
Both pieces are required on a text format at
`/admin/config/content/formats/manage/{format}`:
1. Drag the **Embed Block** button onto the CKEditor 5 toolbar.
2. Enable the **Embed blocks** filter. The CKEditor plugin `conditions: { filter: ck5_block_embed }`
   means the button is unavailable until the filter is on.
There is no other settings form and no config schema shipped by the module; the placeholder markup
and plugin config live inside the field's stored text, not in module config.
