<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Renderer (block_renderer) — agent index

A developer utility that renders a **block plugin** or a **block_content entity** to a render array,
wrapped in a themed container `<div>` (based on core's block template). Lets you reuse blocks in code
without placing them in a region. Package `3sign`. Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 8.x-1.0-alpha6. No dependencies, no UI, no config, no permissions, no routes,
no Drush.

- **The service, both methods, the theme hook, and how to call it** → [api/service.md](api/service.md)

## What it actually is (from source)

- One service: `block_renderer` → `Drupal\block_renderer\BlockRenderer`
  (`src/BlockRenderer.php`), constructed with `@entity_type.manager`, `@plugin.manager.block`,
  `@current_user` (`block_renderer.services.yml`).
- Two public methods:
  - `renderPluginBlock($id, array $config = [])` — `createInstance($id, [])` on the block plugin
    manager, checks `$block->access($currentUser)`, and only then calls `$block->build()`.
  - `renderContentBlock($id, array $config = [])` — loads the `block_content` entity by id and
    renders it via `getViewBuilder('block_content')->view($block)`.
  - Both pass the result through `theme()`, which returns a `#theme => 'block_renderer'` build,
    bubbling the content's `#attributes` up and appending classes `block` + `block-<id>`
    (`Html::cleanCssIdentifier`).
- One theme hook `block_renderer` (`hook_theme()` in `block_renderer.module`) →
  `templates/block-renderer.html.twig` (label `<h2>`, `content` block, wrapper attributes).
- `hook_help()` provides a near-empty help page. No `.install`, no `config/`, no schema,
  no `.permissions.yml`, no `.routing.yml`.

## How to use

```php
$r = \Drupal::service('block_renderer');
$build = $r->renderPluginBlock('system_powered_by_block');      // by plugin id
$build = $r->renderContentBlock(5, ['#attributes' => ['class' => ['my-block']]]); // by block_content id
return $build; // a render array
```

It returns a render array — return it from a controller/hook or run it through the renderer.
The module ships **no HTTP endpoint**; the id is supplied by your calling code, not by a request.
