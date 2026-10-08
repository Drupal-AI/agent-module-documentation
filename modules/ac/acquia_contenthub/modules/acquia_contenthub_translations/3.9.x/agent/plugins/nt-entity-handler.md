# Extension point — non-translatable entity handlers (`nt_entity_handler`)

Not an annotation plugin type — it is a **tagged-service collector**. When selective language
import prunes languages from a CDF, entities that are **not translatable** (e.g. `file`,
`redirect`, `path_alias`) cannot simply have translations removed; each needs bespoke handling.
Those handlers are ordinary services tagged `nt_entity_handler` and collected into the
`NonTranslatableEntityHandlerContext`.

## Wiring
- Compiler pass `NonTranslatableEntityHandlerCompilerPass` (registered by
  `AcquiaContenthubTranslationsServiceProvider::register()`) finds all services tagged
  `nt_entity_handler` and calls `context->addHandler($service, $id)` for each. A tag **without an
  `id`** throws `NonTranslatableEntityHandlerException`.
- `HandlerRegistry` (`acquia_contenthub_translations.nt_entity_handler.registry`) resolves an
  `entity_type:bundle` to a handler id, consulting (in order) its built-in defaults, the config
  `nt_entity_registry.unspecified`, then `nt_entity_registry.handler_mapping`; falls back to
  `unspecified`. Built-in defaults: `file:file ⇒ flexible`, `redirect:redirect ⇒ removable`,
  `path_alias:path_alias ⇒ removable`.
- `NonTranslatableEntityHandlerContext` dispatches a CDF object to the resolved handler.

## Shipped handlers (`src/EntityHandler/`)
| Service id | Class | Tag id |
|---|---|---|
| `...nt_entity_handler.removable` | `Removable` | `removable` |
| `...nt_entity_handler.language_flexible` | `LanguageFlexible` | `flexible` |
| `...nt_entity_handler.undefined` | `Unspecified` | `unspecified` |

## Interface

```php
namespace Drupal\acquia_contenthub_translations\EntityHandler;

use Acquia\ContentHubClient\CDF\CDFObject;

interface NonTranslatableEntityHandlerInterface {
  public function handleEntity(CDFObject $cdf, Context $context): void;
}
```

## Add your own handler

```yaml
# mymodule.services.yml
mymodule.nt_entity_handler.my_type:
  class: Drupal\mymodule\EntityHandler\MyTypeHandler
  tags:
    - { name: nt_entity_handler, id: my_handler }
```

Implement `NonTranslatableEntityHandlerInterface::handleEntity()`, then map an entity to it via
`HandlerRegistry::addEntityToRegistry($entity_type, $bundle, 'my_handler')` (or
`addToUnspecified()` / `addEntityToOverriddenRegistry()`), which persist into
`acquia_contenthub_translations.settings` under `nt_entity_registry` / `nt_override_registry`.
