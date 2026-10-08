<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API reference — `block_plugin.view_builder`

A single service renders any `@Block` plugin (custom blocks, `views_block:*`, `system_menu_block:*`,
`system_branding_block`, the search form block, etc.) into a render array, **without** a placed block
config entity. No routes, no Twig functions, no render elements, no plugins, no UI, no config — it is
purely a developer service.

## Obtaining the service

```php
// Service id.
$viewBuilder = \Drupal::service('block_plugin.view_builder');

// Or by typed autowire / interface (registered as an alias):
// Drupal\block_plugin_view_builder\BlockPluginViewBuilderInterface
```

Service definition: `block_plugin.view_builder` →
`Drupal\block_plugin_view_builder\BlockPluginViewBuilder`, aliased from
`Drupal\block_plugin_view_builder\BlockPluginViewBuilderInterface`.

## Interface — `BlockPluginViewBuilderInterface`

```php
public function view(string $pluginId, array $configuration = [], array $contexts = []): array;
public function viewPlugin(\Drupal\Core\Block\BlockPluginInterface $plugin, array $contexts = []): array;
```

- **`view($pluginId, $configuration, $contexts)`** — instantiates the plugin via the block manager
  (`$this->blockManager->createInstance($pluginId, $configuration)`) and delegates to `viewPlugin()`.
  `$pluginId` is a block plugin id (e.g. `'system_powered_by_block'`, `'views_block:frontpage-block_1'`).
  `$configuration` is the block plugin configuration array (block settings such as `label`,
  `label_display`, plus any plugin-specific keys). Returns a render array.
- **`viewPlugin($plugin, $contexts)`** — same, when you already hold a `BlockPluginInterface` instance.

## What the returned render array contains

`viewPlugin()` builds `$build[$plugin->getPluginId()]` with:

- `#cache.keys` — `['block_plugin_view_builder', <plugin_id>, '[configuration]=' . sha256(json(config)), '[contexts]=' . sha256(json(encoded contexts))]`, so identical calls hit the render cache.
- `#cache.contexts` — the plugin's own `getCacheContexts()` (plus `'url'` for title blocks).
- `#cache.tags` — `Cache::mergeTags(['block_view'], $plugin->getCacheTags())`.
- `#cache.max-age` — `$plugin->getCacheMaxAge()`.
- Either a `#lazy_builder` callback (`block_plugin.view_builder:lazyBuilder`) for normal blocks so
  they are placeholdered and rendered lazily, **or** — for a `TitleBlockPluginInterface` block — an
  eagerly built `#pre_render`-able array (title blocks cannot be built lazily; the current route/
  request title is resolved via the title resolver and `'url'` is added to cache contexts).
- `hook_block_build` / `hook_block_build_BASE_ID` and `hook_block_view` /
  `hook_block_view_BASE_ID` alters are invoked, matching core's `BlockViewBuilder` behaviour.

## Access (important, and handled correctly)

`viewPlugin()` calls `$plugin->access($this->account, TRUE)` (returns an `AccessResultInterface`)
**before** building. If access is not allowed, **no content is built** and only the access cacheable
metadata is returned. The access result's cacheable metadata is always applied to `$build`
(`$cacheableMetadataAccess->applyTo($build)`), so the fragment varies/caches per the plugin's access
rules. Access is evaluated against **`@current_user`**, i.e. the user of the current request.

Note: this checks the **block plugin's own access** (the plugin's `blockAccess()` — e.g. a menu
block's or view's access). It does **not** apply any placed-block **visibility conditions** (there is
no block config entity), by design. If a site expressed "admins only" via a placement condition rather
than the plugin, rendering the plugin directly will not reproduce that restriction — supply the block
id yourself accordingly.

## Contexts (for context-aware block plugins)

Pass `$contexts` keyed by context name. For a `ContextAwarePluginInterface` plugin the service merges
in runtime contexts (`context.repository->getRuntimeContexts()`) and applies the mapping
(`context.handler->applyContextMapping()`).

Because normal blocks render through a `#lazy_builder` (which only accepts scalar args), contexts are
JSON-encoded for the lazy builder and rebuilt later:

- **Entity contexts** (`entity:node`, `entity:user`, …) are stored as `{data_type, entity_id}` and
  **reloaded by id** in the lazy builder via the entity type manager.
- **Scalar / null contexts** (`string`, `integer`, …) are passed through as `{data_type, value}`.
- A context holding a **non-entity object** throws `\LogicException` — it cannot survive the lazy
  builder round-trip.

```php
use Drupal\Core\Plugin\Context\Context;
use Drupal\Core\Plugin\Context\EntityContextDefinition;

$build = \Drupal::service('block_plugin.view_builder')->view('my_context_block', [], [
  'node' => new Context(new EntityContextDefinition('entity:node'), $node),
]);
```

## Static helpers / callbacks (advanced)

- `BlockPluginViewBuilder::buildPreRenderableBlock($plugin, $moduleHandler, $contexts)` — static;
  returns the `#theme => 'block'` render array with a `::preRender` callback and `#block => $plugin`.
- `lazyBuilder($blockPluginId, $configuration, $encodedContexts)` — the `#lazy_builder` callback
  (trusted). Rebuilds the plugin and calls `buildPreRenderableBlock()`.
- `preRender($build)` — trusted `#pre_render`; calls `$plugin->build()`, moves `#attributes` /
  `#contextual_links` up, drops empty output, mirroring core `BlockViewBuilder::preRender()`.

`trustedCallbacks()` returns `['lazyBuilder', 'preRender']` (class implements
`TrustedCallbackInterface`).

## Scope / non-goals

Renders **block plugins**, not `block_content` **entities** — for those use core's
`BlockViewBuilder` (the module explicitly does not target block content entities).
