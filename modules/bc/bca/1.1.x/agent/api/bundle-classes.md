<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring bundle classes with bca

A **bundle class** is a per-bundle PHP subclass of an entity type's class (e.g. an `Article` class
extending `Node`) so bundle-specific logic can live as methods. bca lets that class declare which
entity type + bundle it serves, in place of `hook_entity_bundle_info_alter()`.

## Where the class must live
Discovery scans `src/Entity/` (constant `BundlePluginManager::SUBDIR = 'Entity'`,
`src/BundlePluginManager.php:19`) of **enabled** modules, recursively — so both
`Drupal\my_module\Entity\Article` and `Drupal\my_module\Entity\Node\Article` are found. The class
must extend the entity type's class (the manager's plugin interface is
`Drupal\Core\Entity\EntityInterface`, `src/BundlePluginManager.php:26`). Rebuild caches
(`ddev drush cr`) after adding, moving, or removing a declaration — definitions are cached under key
`bca_bundle_classes`.

## Attribute form (preferred; needs Drupal 10.2+ / PHP 8.1+)
`Drupal\bca\Attribute\Bundle` (`src/Attribute/Bundle.php`). Constructor params:
- `entityType` (string, **required**) — target entity type id, e.g. `node`, `user`, `taxonomy_term`.
- `bundle` (`?string`, optional) — bundle id. Defaults to `entityType` when omitted (`$this->bundle
  ??= $this->entityType;`), which is the right default for bundle-less entities like `user`.
- `label` (`?TranslatableMarkup`, optional) — overrides the bundle's admin label. Pass a
  `new TranslatableMarkup('...')` instance (an attribute cannot take `@Translation`).

```php
namespace Drupal\my_module\Entity\Node;

use Drupal\bca\Attribute\Bundle;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\node\Entity\Node;

#[Bundle(
  entityType: 'node',
  bundle: 'article',
  label: new TranslatableMarkup('Article'),
)]
class Article extends Node {}
```

For an entity type without bundles, omit `bundle` (it falls back to `entityType`):

```php
use Drupal\bca\Attribute\Bundle;
use Drupal\user\Entity\User;

#[Bundle(entityType: 'user')]
class BcaUser extends User {}
```

## Annotation form (deprecated — pre-10.2 / pre-1.1.0 compatibility)
`Drupal\bca\Annotation\Bundle` (`src/Annotation/Bundle.php`). **Keys differ from the attribute:**
`entity_type` (snake_case), `bundle` (defaults to `entity_type` via `parse()`), and `label`
(`@Translation(...)`).

```php
namespace Drupal\my_module\Entity\Node;

use Drupal\node\Entity\Node;

/**
 * @Bundle(
 *   entity_type = "node",
 *   bundle = "article",
 *   label = @Translation("Article"),
 * )
 */
class Article extends Node {}
```

## How registration happens
1. `plugin.manager.bca.bundle` (`Drupal\bca\BundlePluginManager`) collects one definition per
   discovered class. Each plugin ID is `"<entityType>:<bundle>"` (built in `Bundle::__construct()` /
   `Bundle::getId()`), so two declarations for the same entity type + bundle would collide.
2. `bca_entity_bundle_info_alter(array &$bundles)` (`bca.module`) iterates
   `$manager->getDefinitions()`. For each it resolves `$entityType = $definition['entityType'] ??
   $definition['entity_type']` (the `??` bridges the attribute vs annotation key difference) and
   `$bundle = $definition['bundle']`, then — **only if `$bundles[$entityType][$bundle]` already
   exists** — sets `['class'] = $definition['class']` and `['label']` (declared label, else existing
   label, else the class name).

Consequences to know:
- The bundle must already exist (created the usual way — content type, vocabulary, `entity_test`
  bundle, etc.). bca does **not** create bundles; it only attaches the class/label to an existing one.
- If the declared entity type/bundle pair doesn't match an existing bundle, the declaration is
  silently ignored.
- bca and a hand-written `hook_entity_bundle_info_alter()` can coexist, so you can migrate a
  codebase to attributes incrementally.

## The plugin manager service (if you need it in code)
```php
$manager = \Drupal::service('plugin.manager.bca.bundle'); // Drupal\bca\BundlePluginManager
$defs = $manager->getDefinitions(); // keyed by "<entityType>:<bundle>"
```
Runtime-verified on this site (bca 1.1.1, Drupal 11.4.5): the service resolves to
`Drupal\bca\BundlePluginManager`; `getDefinitions()` returns 0 here because no enabled module ships a
`Bundle`-annotated class under `src/Entity/`.

## Migrating off bca (core 11.4+)
Since Drupal 11.4.0 the same capability is in core as `Drupal\Core\Entity\Attribute\Bundle`. To move
off this module, swap the `use` statement from `Drupal\bca\Attribute\Bundle` to
`Drupal\Core\Entity\Attribute\Bundle` (the attribute shape matches). The 1.1.x branch supports both
attributes and annotations; the 2.x branch drops annotations and is attributes-only.
