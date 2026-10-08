<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View mode page — AliasType plugin type

The module defines a plugin type used by each pattern's `type` field.

- **Annotation:** `@AliasType` (`Drupal\view_mode_page\Annotation\AliasType`) with `id`, `label`,
  `types` (token types).
- **Interface:** `Drupal\view_mode_page\AliasTypeInterface` — extends `ContextAwarePluginInterface`
  and `DerivativeInspectionInterface`; methods `getLabel()`, `getTokenTypes()`, `applies($object)`.
- **Manager service:** `view_mode_page.manager.alias_type` (class `AliasTypeManager`,
  extends `default_plugin_manager`). Discovery dir: `src/Plugin/view_mode_page/AliasType/`.

## Shipped plugin

`canonical_entities` (`src/Plugin/view_mode_page/AliasType/EntityAliasTypeBase.php`) uses the
deriver `EntityAliasTypeDeriver`, which produces one derivative **per entity type that has a
canonical link template** — e.g. `canonical_entities:node`, `canonical_entities:user`,
`canonical_entities:taxonomy_term`. That derivative id is what you put in a pattern's `type`.
A `Broken` fallback plugin covers missing definitions.

List the available alias-type plugin ids:
```bash
drush php:eval 'print implode(",", array_keys(\Drupal::service("view_mode_page.manager.alias_type")->getDefinitions()));'
```

## Adding your own alias type

Only needed for non-canonical or non-entity patterns. Create
`src/Plugin/view_mode_page/AliasType/MyAliasType.php`:

```php
namespace Drupal\my_module\Plugin\view_mode_page\AliasType;

use Drupal\Core\Plugin\PluginBase;
use Drupal\Core\Plugin\ContextAwarePluginTrait;
use Drupal\view_mode_page\AliasTypeInterface;

/**
 * @AliasType(
 *   id = "my_alias_type",
 *   label = @Translation("My alias type"),
 *   types = { "node" }
 * )
 */
class MyAliasType extends PluginBase implements AliasTypeInterface {
  use ContextAwarePluginTrait;
  public function getLabel() { return $this->pluginDefinition['label']; }
  public function getTokenTypes() { return $this->pluginDefinition['types'] ?? []; }
  public function applies($object) { return TRUE; }
}
```

Most sites never need this — the derived `canonical_entities:*` plugins already cover every entity
type with a canonical route.
