# Wrapped entities and renderers

## Wrapped entities

Extend `Drupal\typed_entity\WrappedEntities\WrappedEntityBase` (implements
`WrappedEntityInterface`). One class per bundle (or a variant of it). Put the bundle's business
logic here instead of in hooks.

Inherited API:

- `getEntity(): EntityInterface` — the underlying Drupal entity.
- `label(): string` — the entity label.
- `owner(): ?WrappedEntityInterface` — the entity's owner (from the `owner` entity key), already
  wrapped.
- `wrapReference(string $field_name): ?WrappedEntityInterface` — the first entity referenced by a
  field, wrapped.
- `wrapReferences(string $field_name): array` — all entities referenced by a field, wrapped.
- `static applies(TypedEntityContext $context): bool` — returns FALSE by default; override in a
  **variant** wrapper so the repository can pick it (see [variants.md](variants.md)).
- `static create(ContainerInterface $container, EntityInterface $entity)` — factory; override to
  inject services (call `parent::__construct($entity)` first).
- Testing helpers: `setRepositoryManager()`, `setViewBuilder()`.

```php
namespace Drupal\my_module\WrappedEntities;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Messenger\MessengerInterface;
use Drupal\typed_entity\WrappedEntities\WrappedEntityBase;
use Symfony\Component\DependencyInjection\ContainerInterface;

class Article extends WrappedEntityBase {
  public function __construct(EntityInterface $entity, private MessengerInterface $messenger) {
    parent::__construct($entity);
  }
  public static function create(ContainerInterface $container, EntityInterface $entity): self {
    return new static($entity, $container->get('messenger'));
  }
  public function isPromoted(): bool {
    return (bool) $this->getEntity()->get('promote')->value;
  }
}
```

The wrapper is instantiated by the repository's `wrapperFactory()`, which negotiates the wrapper
variant (falling back to the `ClassWithVariants` fallback) and calls `$class::create()`.

## Renderers

A repository can declare renderers (extending
`Drupal\typed_entity\Render\TypedEntityRendererBase`). When an entity is viewed, the base
module's `hook_entity_view_alter`, `hook_preprocess`, `hook_entity_display_build_alter`, and
`hook_entity_build_defaults_alter` implementations find the repository, negotiate a renderer,
and call the matching method — so a bundle can alter its own render output without a global hook.

Overridable methods (all no-ops by default):

- `build(WrappedEntityInterface $wrapped, TypedEntityContext $context): array`
- `preprocess(array &$variables, WrappedEntityInterface $wrapped): void`
- `viewAlter(array &$build, WrappedEntityInterface $wrapped, EntityViewDisplayInterface $display): void`
- `displayBuildAlter(array &$build, WrappedEntityInterface $wrapped, array $context): void`
- `buildDefaultsAlter(array &$build, WrappedEntityInterface $wrapped, string $view_mode): void`
- `static applies(TypedEntityContext $context): bool` — by default matches when the render
  `view_mode` equals the renderer's `const VIEW_MODE` (default `'full'`).

```php
class Full extends TypedEntityRendererBase {
  const VIEW_MODE = 'full';
  public function preprocess(array &$variables, WrappedEntityInterface $wrapped): void {
    $variables['attributes']['class'][] = 'is-typed';
  }
}
```

Renderer variants are chosen the same way as wrappers (see [variants.md](variants.md)); if none
applies, `TypedEntityRendererBase` itself is used.
