<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle class + OOP hook — the worked example

Everything this module does, and how to reproduce it in your own module.

## Install / enable

```
composer require drupal/bundle_classes   # pulls drupal/bca ^1.1.1
drush en bundle_classes
```

Only needed to *run* the demo. For real projects, do **not** enable this module — create your own
module (conventionally named `bundle_classes`) and copy the two classes below. It requires `bca`
(the `#[Bundle]` attribute provider) and core `^10.5 || ^11.2 || ^12`. No config, no permissions,
no routes are installed.

## 1. The bundle class — `src/Entity/Node/Article.php`

```php
#[Bundle(entityType: 'node', bundle: 'article')]
final class Article extends Node {
  public function getLastUpdatedDate(): array {
    $lastUpdated = $this->get('changed')->view([
      'type' => 'timestamp',
      'label' => 'inline',
      'settings' => [
        'date_format' => 'custom',
        'custom_date_format' => 'j F Y - g:ia',
      ],
    ]);
    $lastUpdated['#title'] = new TranslatableMarkup('Last updated');
    return $lastUpdated;
  }
}
```

- `#[Bundle]` comes from `Drupal\bca\Attribute\Bundle` (the `bca` module). It declares which
  entity type + bundle this class serves.
- The class **extends the base entity class** (`Drupal\node\Entity\Node`). Any method you add is
  then available on loaded article nodes and in Twig via `{{ node.getMethodName }}`.
- `getLastUpdatedDate()` returns a render array built by `FieldItemList::view()` on the node's
  `changed` field — no manual markup, so it is render-array-safe. `#title` is a `TranslatableMarkup`.

## 2. Registering the class — `src/Hook/BundleClassesHooks.php`

```php
class BundleClassesHooks {
  #[Hook('entity_bundle_info_alter')]
  public static function entityBundleInfoAlter(array &$bundles): void {
    if (isset($bundles['node']['article'])) {
      $bundles['node']['article']['class'] = Article::class;
    }
  }
}
```

- Uses Drupal's **OOP hook** system (`Drupal\Core\Hook\Attribute\Hook`). Registered as an autowired
  service in `bundle_classes.services.yml`:

  ```yaml
  services:
    Drupal\bundle_classes\Hook\BundleClassesHooks:
      class: Drupal\bundle_classes\Hook\BundleClassesHooks
      autowire: true
  ```

- `bundle_classes.module` keeps a `#[LegacyHook]` shim
  (`bundle_classes_entity_bundle_info_alter()`) that delegates to the service, for older hook
  discovery. There are **no** other global functions.
- The `isset()` guard means the class is only bound when the article bundle exists; other bundles
  keep the default `Node` class.

## 3. Using it from a template

The bundled demo theme's `node--article.html.twig` prints the method's output directly:

```twig
{{ node.getLastUpdatedDate }}
```

See [../modules/bundle_class_demo/1.0.x/agent/start.md](../../modules/bundle_class_demo/1.0.x/agent/start.md).

## 4. Verifying it — `tests/src/Kernel/ArticleBundleClassTest.php`

Kernel test (`#[Group('bundle_classes')]`, `#[RunTestsInSeparateProcesses]`) with three cases:
`Node::load()` of an article returns an `Article` instance; a `page` node does **not**;
`getLastUpdatedDate()['#title']` casts to the string `"Last updated"`. Use it as a template for
asserting your own bundle classes are applied.

## Operating notes

- Nothing to configure. The behaviour is purely code-driven; enabling the module + the demo theme is
  enough to see the "Last updated" line appear on article nodes.
- To extend: add more `#[Bundle]` classes under `src/Entity/<EntityType>/` and register each in the
  hook's `entityBundleInfoAlter()` (or add more `#[Hook]` methods).
