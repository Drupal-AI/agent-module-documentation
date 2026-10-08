# `render_block()` Twig function + BlockViewBuilder service

## The Twig function

Source: `src/Twig/RenderBlock.php` (service `twig_blocks.twig.render_block`, tagged `twig.extension`).

```twig
{# Render a placed block by its config Block entity ID #}
{{ render_block('block_id') }}

{# Override settings inline (label + any block plugin setting) #}
{{ render_block('block_id', {label: 'Example'|t, some_setting: 'example'}) }}
```

- Signature: `render_block(string $block_id, array $configuration = [])`, registered with
  `is_safe: ['html']` (output is not auto-escaped).
- `$block_id` is the **config `block` entity ID** (a placed block), e.g. `bartik_search` or your
  theme's block machine name — not a bare plugin ID.
- Implementation: `Block::load($block_id)`; if `$configuration` is non-empty it does
  `array_merge($block->get('settings'), $configuration)`, `$block->set('settings', …)` and
  **`$block->save()`**; then renders with `entityTypeManager->getViewBuilder('block')->view($block)`
  and returns `['#markup' => $renderer->render($markup)]`. Returns an empty array if the block ID
  doesn't load.

> Side effect: passing `$configuration` **persists** the merged settings to the block config entity
> (a DB write on render). Do not feed per-request dynamic values here — they become the block's saved
> settings. For non-persistent rendering by plugin ID, use the service below.

## The BlockViewBuilder service (render a block *plugin* by ID)

Source: `src/View/BlockViewBuilder.php`, service id `twig_blocks.block_view_builder`. Not wired into
the Twig function; call it from custom PHP when you want to render a **block plugin** without a placed
config entity or any config write.

```php
/** @var \Drupal\twig_blocks\View\BlockViewBuilder $builder */
$builder = \Drupal::service('twig_blocks.block_view_builder');
$build = $builder->build('system_powered_by_block', ['label' => 'Powered by'], TRUE);
```

`build(string $id, array $configuration = [], bool $wrapper = TRUE): array`:

- Creates the block plugin via `plugin.manager.block` with `$configuration`
  (defaults `label_display` to visible).
- If the plugin is context-aware, gathers runtime contexts (`context.repository`) and applies them
  (`context.handler`).
- Runs `$block_plugin->access($current_user, TRUE)`; only builds content when allowed.
- Handles `TitleBlockPluginInterface` (resolves the current route title, adds the `url` cache
  context).
- Puts plugin output under `$build['content']`; when `$wrapper` is TRUE and content is non-empty,
  wraps it with `#theme => 'block'` and the standard `#configuration/#plugin_id/#base_plugin_id/…`
  properties, hoisting `#attributes` and `#contextual_links` to the top level.
- Applies cacheability from the access result and the plugin, and sets default `#cache.keys`
  (`twig_blocks_block`, the id, a hash of the configuration, the wrapper flag).

No permissions or config; `access()` is enforced per block plugin.
