<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the classes reach the markup

`block_classes_preprocess_block(&$variables)` is the whole render-side implementation.

```php
$block = Block::load($variables['elements']['#id']);   // skipped when #id is empty
foreach (explode(' ', $classes) as $class) {
  $variables[<target>]['class'][] = Html::cleanCssIdentifier($class, []);
}
```

| Stored key | Twig variable it extends | Typical markup target |
|---|---|---|
| `block_class` | `attributes` | the block wrapper (`<div{{ attributes }}>`) |
| `title_class` | `title_attributes` | the block title (`<h2{{ title_attributes }}>`) |
| `content_class` | `content_attributes` | the content wrapper (`<div{{ content_attributes }}>`) |

Notes an agent should know:

- **Sanitisation:** each space-separated token is passed through
  `Html::cleanCssIdentifier($class, [])` with an *empty* filter map. With the default map
  removed, the usual `_ → -`, `/ → -` and `[ ] → -` substitutions do **not** apply. What still
  happens: characters that are invalid in a CSS identifier are stripped, a leading digit becomes
  `_`, and a leading `--` becomes `__`. So `my_class` survives unchanged but `1col` renders `_col`.
- **Theme requirement:** the theme's `block.html.twig` must actually print
  `title_attributes` / `content_attributes`. Core themes (Olivero, Claro, Stark) do; a stripped
  custom template that only prints `attributes` will drop the title/content classes.
- **No template, no theme hook, no library** is provided by this module — it only feeds existing
  core block template variables.
- Classes are appended, never replaced, so core's own `block`, `block-<provider>` … classes stay.
- Because the block entity is loaded per render, changing the config takes effect on the next
  request (after the usual block/render cache invalidation from saving the block).
