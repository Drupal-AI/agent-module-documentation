<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a Preprocess plugin

A Preprocess plugin is a class in `src/Plugin/Preprocess/` that implements
`Drupal\preprocess\PreprocessInterface` — one method:

```php
public function preprocess(array $variables): array;
```

It receives the theme hook's `$variables` and must **return** the (modified) array. Extend
`Drupal\preprocess\PreprocessPluginBase` (which extends core `PluginBase`) so you only write
`preprocess()`.

Two required pieces of metadata: a plugin **`id`** and a **`hook`** — the theme hook to
preprocess, matching `hook_preprocess_HOOK`. It can be a base hook (`node`, `page`, `block`,
`image`, `field`) or a **suggestion** (`node__article`, `block__system_menu_block`).

## Option A — annotation (modules only)

Annotation discovery does **not** scan themes, so use this only in a module.

`src/Plugin/Preprocess/MyNodeArticle.php`:

```php
<?php

namespace Drupal\my_module\Plugin\Preprocess;

use Drupal\preprocess\PreprocessPluginBase;

/**
 * @Preprocess(
 *   id = "my_module.preprocess.node_article",
 *   hook = "node__article"
 * )
 */
class MyNodeArticle extends PreprocessPluginBase {

  public function preprocess(array $variables): array {
    $variables['content']['#attached']['library'][] = 'my_module/article';
    $variables['reading_time'] = 5;
    return $variables;
  }

}
```

The annotation object is `Drupal\preprocess\Annotation\Preprocess` (fields `id`, `hook`,
optional `class`).

## Option B — `NAME.preprocessors.yml` (modules AND themes)

The **only** way to register a preprocessor from a **theme** (annotation discovery can't see
themes). File name = `<machine_name>.preprocessors.yml` at the extension's top level. Each entry
gives a `class` and a `hook`; the class does not need an annotation:

`my_theme.preprocessors.yml`:

```yaml
my_theme.preprocess.image:
  class: \Drupal\my_theme\Plugin\Preprocess\PreprocessImage
  hook: image
my_theme.preprocess.node_article:
  class: \Drupal\my_theme\Plugin\Preprocess\PreprocessNodeArticle
  hook: node__article
```

`my_theme/src/Plugin/Preprocess/PreprocessImage.php`:

```php
<?php

namespace Drupal\my_theme\Plugin\Preprocess;

use Drupal\preprocess\PreprocessPluginBase;

class PreprocessImage extends PreprocessPluginBase {
  public function preprocess(array $variables): array {
    $variables['attributes']['loading'] = 'lazy';
    return $variables;
  }
}
```

(Themes also autoload classes from their `src/` PSR-4 namespace.)

## Discovery & activation rules

- Put classes under `src/Plugin/Preprocess/`; run `drush cr` after adding/renaming a plugin.
- **Theme plugins are conditional:** a plugin whose provider is a theme is only used when that
  theme is the **active** theme, or a **base theme** of the active theme
  (`PreprocessPluginManager::getDefinitions()`). Module plugins always apply.
- Multiple plugins may target the same hook; all matching plugins run (module plugins sort
  before theme plugins, then by id).
- The `hook` must equal the theme hook you want. For suggestions, use the double-underscore
  form (`node__article`) — the module runs plugins for both the base hook and the resolved
  suggestions (see [api/manager.md](../api/manager.md)).
