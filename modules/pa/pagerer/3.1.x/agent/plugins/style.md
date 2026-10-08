<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `@PagererStyle` plugin type

Pagerer discovers pager **style** plugins via the `pagerer.style.manager` service
(`Drupal\pagerer\Plugin\PagererStyleManager`, extends `DefaultPluginManager`).

- Discovery directory: `src/Plugin/pagerer/` (namespace `Drupal\<module>\Plugin\pagerer`).
- Interface: `Drupal\pagerer\Plugin\PagererStyleInterface`; base class:
  `Drupal\pagerer\Plugin\pagerer\PagererStyleBase`.
- Annotation: `Drupal\pagerer\Plugin\Annotation\PagererStyle` (annotation-based, not attributes).
- Alter hook: `hook_pagerer_style_plugin_info_alter()`. Cache key `pagerer_style_plugins`.

## Annotation fields

```php
/**
 * @PagererStyle(
 *   id = "my_style",
 *   title = @Translation("My pager style"),
 *   short_title = @Translation("My"),
 *   help = @Translation("What this style does."),
 *   style_type = "base"          // "base" or "composite" (multipane is composite)
 * )
 */
```

`style_type` filters which panes/contexts can use the plugin:
`PagererStyleManager::getPluginOptions('base'|'composite')` returns the id → short_title map used
in the preset forms.

## Built-in styles

| id | style_type | Summary |
|---|---|---|
| `standard` | base | Like core's pager theme |
| `basic` | base | Like Views' mini pager (current/total + prev/next) |
| `progressive` | base | Links to progressively more distant pages (+10/+20/+100) |
| `adaptive` | base | Adaptive-logic page links |
| `multipane` | composite | Combines base styles across left/center/right panes |

## Implementing a style

Extend `PagererStyleBase` and implement the pager item building (see `Standard`, `Basic`,
`Progressive`, `Adaptive` in `src/Plugin/pagerer/`). Override `buildConfigurationForm()` to add
style options and `buildPagerItems()` to produce the render array. Ship a
`config/install/pagerer.style.my_style.yml` with a `default_config:` block and a matching
`config/schema` `pagerer.style_config.my_style` type so preset panes can store per-instance
config. The style manager merges `pagerer.style.<id>:default_config` into instance config in
`createInstance()`, falling back to the `basic` style if the id is unknown.

## Rendering directly (developer API)

The `Drupal\pagerer\Pagerer` value object (extends core `Pager`) carries the element index,
route and adaptive keys; combined with `pagerer.style.manager->createInstance($style_id, $config)`
it lets custom code build a Pagerer pager outside the core-override/Views paths. See the
`pagerer_example` submodule's controller for a worked multi-pager example.
