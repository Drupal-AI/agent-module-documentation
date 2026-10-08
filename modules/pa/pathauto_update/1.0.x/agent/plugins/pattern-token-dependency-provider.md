# Plugin type: PatternTokenDependencyProvider

The one extension point. A provider maps a **token type** (the segment before the first `:` in a
Pathauto token — e.g. `node` in `[node:title]`, `site` in `[site:name]`) to the entities/configs
that token's value is derived from, so the alias can be tracked and regenerated when they change.

- Annotation: `@PatternTokenDependencyProvider(type = "<token-type>")`
  (`src/Annotation/PatternTokenDependencyProvider.php`; the plugin **ID is the `type`**).
- Directory: `src/Plugin/PatternTokenDependencyProvider/`.
- Interface: `PatternTokenDependencyProviderInterface` — one method:
  `addDependencies(array $tokens, array $data, array $options, PathAliasDependencyCollectionInterface $dependencies): void`.
- Base class: `PatternTokenDependencyProviderBase` (extends `PluginBase`, implements
  `ContainerFactoryPluginInterface`). Gives you `$this->tokens`, `$this->entityTypeManager`,
  `$this->aliases` (pathauto alias storage helper), `$this->manager`, plus helpers
  `addDependenciesByType()`, `getPathAlias()`, `getPathAliasByEntity()`.
- Manager: `plugin.manager.pattern_token_dependency_provider`
  (`PatternTokenDependencyProviderManager`). Cache key
  `pathauto_update_pattern_token_dependency_providers`.
- Alter hook: `hook_pathauto_update_pattern_token_dependency_provider_info_alter(array &$info)` —
  add/override/remove provider definitions.

The resolver only calls a provider when `token->scan()` finds that token type in the pattern and
`manager->hasDefinition($type)` is TRUE; unrecognised token types are silently skipped (their
aliases just won't auto-update).

## Collecting dependencies

Inside `addDependencies()`, add to the passed collection:

```php
$dependencies->addEntity($someEntity);   // regenerate when this entity changes
$dependencies->addConfig($config);       // regenerate when this config object changes
```

`$data` carries the object for the token type (e.g. `['node' => $node]`, `['site' => ...]`,
`['url' => $urlObject]`), and `$options['langcode']` is the alias language. Delegate to another
provider with `$this->addDependenciesByType('<type>', $tokens, $data, $options, $dependencies)`.

## Built-in providers

| `type` | Class | Tracks (examples) |
|---|---|---|
| `entity` | `Entity` | Entity/reference field tokens (`[node:field_x:entity:name]`); adds referenced entities and image styles. |
| `node` | `Node` | `[node:author]`→user, `[node:created]`→`medium` date format, `[node:menu-link:*]`, plus field tokens via `entity`. |
| `menu-link` | `MenuLink` | `[…:menu-link:title|url|parent|parents|root]` → `menu_link_content` entities and linked-entity aliases. |
| `array` | `ArrayTokenDependencyProvider` | `[…:join-path]` over a menu parent path. |
| `url` | `Url` | `[…:path]` → the resolved `path_alias` entity. |
| `site` | `SystemSite` | `[site:name|slogan|mail]` → `system.site` config. |
| `date` | `SystemDate` | `[date:short|medium|long]` → the matching `date_format` config entity. |
| `node_singles` | `NodeSingles` | `[node_singles:*]` — only active when the `node_singles` module is installed (`provider = "node_singles"`). |

## Add a provider (skeleton)

```php
namespace Drupal\my_module\Plugin\PatternTokenDependencyProvider;

use Drupal\pathauto_update\PathAliasDependencyCollectionInterface;
use Drupal\pathauto_update\PatternTokenDependencyProviderBase;

/**
 * @PatternTokenDependencyProvider(type = "my_token_type")
 */
class MyProvider extends PatternTokenDependencyProviderBase {

  public function addDependencies(array $tokens, array $data, array $options, PathAliasDependencyCollectionInterface $dependencies): void {
    // $data['my_token_type'] holds the object for this token type.
    foreach ($tokens as $name => $original) {
      // Inspect $name (token minus the "my_token_type:" prefix) and add deps:
      // $dependencies->addEntity($entity);  or  $dependencies->addConfig($config);
    }
  }
}
```

Set `provider = "<module>"` in the annotation if the plugin should only load when another module
is enabled (as `NodeSingles` does). No service registration needed — discovery is by directory +
annotation.
