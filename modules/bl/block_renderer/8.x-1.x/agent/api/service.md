<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_renderer service — API

Service id `block_renderer`, class `Drupal\block_renderer\BlockRenderer` (`src/BlockRenderer.php`).
Definition in `block_renderer.services.yml`:

```yaml
services:
  block_renderer:
    class: Drupal\block_renderer\BlockRenderer
    arguments: ['@entity_type.manager', '@plugin.manager.block', '@current_user']
```

Enable with `drush en block_renderer`. No config, no permissions, no routes — pure code API. Get it
with `\Drupal::service('block_renderer')` or inject `@block_renderer`.

## Methods

### `renderPluginBlock($id, array $config = [])`
- `$id` = a **block plugin id** (e.g. `system_powered_by_block`, `system_menu_block:main`).
- Does `pluginManagerBlock->createInstance($id, [])` — **empty configuration**; you cannot pass stored
  block settings through this method.
- Calls `$block->access($this->currentUser)` and only builds if allowed. The check accepts either a
  bool or an `AccessResultInterface`:
  `is_object($r) && $r->isAllowed() || is_bool($r) && $r` (`&&` binds tighter than `||`, so this is
  `(object && allowed) || (bool && true)` — correct). If denied, `$content` stays `[]` and an empty
  wrapper is returned.
- `// @todo Cache tags/contexts?` — the method does **not** attach the block's cache metadata to the
  build, so callers relying on per-block cacheability should add it themselves.

### `renderContentBlock($id, array $config = [])`
- `$id` = the **integer id** of a `block_content` entity (not its UUID).
- Loads `entityTypeManager->getStorage('block_content')->load($id)` and, if found, renders it with
  `getViewBuilder('block_content')->view($block)`. Returns an empty wrapper if no such entity.

### Both methods
- Call `setDefaultAttributes($id, $config)` first, adding classes `block` and
  `block-<id>` (`Html::cleanCssIdentifier('block-' . $id)`) to `$config['#attributes']['class']`.
- Return `theme($content, $config['#attributes'])`, a private helper that builds:
  ```php
  ['#theme' => 'block_renderer', '#attributes' => [...], '#content' => $content]
  ```
  It bubbles any `$content['#attributes']` up onto the wrapper (then unsets them from content) and
  appends the classes from `$config['#attributes']['class']`.
- **Return value is a render array** — return it from a controller/hook, or render it to markup.

## `$config` argument
- Only `#attributes` is consumed (via the class merge). Example:
  `['#attributes' => ['class' => ['cta', 'wide']]]`. Other keys are ignored.

## Theme
- `hook_theme()` (`block_renderer.module`) registers `block_renderer` with variables `content` and
  `attributes`, rendered by `templates/block-renderer.html.twig` (a copy of core's block template:
  wrapper `<div{{ attributes }}>`, optional `<h2>{{ label }}</h2>`, `{% block content %}{{ content }}`,
  plus `title_prefix`/`title_suffix` for contextual links). Override it from your theme to change markup.

## Notes
- No submodules, no events, no hooks beyond `hook_help` + `hook_theme`.
- `renderContentBlock` renders whatever `block_content` id you pass through the entity view builder;
  `renderPluginBlock` gates on the plugin's own `access()`. Choose the method that matches your intent
  and pass ids from trusted server-side code (the module exposes no route that would let a request
  choose the id).
