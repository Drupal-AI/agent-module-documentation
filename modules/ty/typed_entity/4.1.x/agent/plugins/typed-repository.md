# Define a typed repository plugin

Plugin type id: **`typed_entity_repository`** (manager service
`plugin.manager.typed_entity_repository`, class `TypedRepositoryPluginManager`). Plugins are
discovered from any module's `src/Plugin/TypedRepositories/` directory and declared with the
`#[TypedRepository]` PHP attribute (legacy `@TypedRepository` annotation also supported).

## The attribute

`Drupal\typed_entity\Attribute\TypedRepository` constructor arguments:

| Arg | Type | Meaning |
|---|---|---|
| `entity_type_id` | `string` (required) | Entity type the repository is for, e.g. `node`, `user`. |
| `bundle` | `?string` | Bundle machine name. Omit for bundle-less entity types (e.g. `user`). Must be a valid bundle of the type or instantiation throws. |
| `description` | `?TranslatableMarkup` | Human description (shown in the UI explorer). |
| `wrappers` | `?ClassWithVariants` | Wrapper class(es): `new ClassWithVariants(FallbackWrapper::class, [VariantWrapper::class])`. Fallback must extend `WrappedEntityBase`. |
| `renderers` | `?ClassWithVariants` | Renderer class(es): variants must extend `TypedEntityRendererBase`. |

The plugin id is auto-generated as `entity_type_id` + `.` + `bundle` (bundle-less → just
`entity_type_id`). Extend `TypedRepositoryBase` (which is `ContainerFactoryPluginInterface`).

```php
namespace Drupal\my_module\Plugin\TypedRepositories;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\typed_entity\Attribute\TypedRepository;
use Drupal\typed_entity\ClassWithVariants;
use Drupal\typed_entity\TypedRepositories\TypedRepositoryBase;
use Drupal\my_module\WrappedEntities\Article;
use Drupal\my_module\WrappedEntities\BakingArticle;

#[TypedRepository(
  entity_type_id: 'node',
  bundle: 'article',
  description: new TranslatableMarkup('Business logic for articles.'),
  wrappers: new ClassWithVariants(Article::class, [BakingArticle::class]),
  renderers: new ClassWithVariants(variants: [\Drupal\my_module\Render\Article\Full::class]),
)]
final class ArticleRepository extends TypedRepositoryBase {
  // Add domain query methods here, e.g. findByTags(), countPublished()...
}
```

The repository can implement `AccessibleInterface` to centralize per-bundle access logic
(see `typed_entity_example`'s `ArticleRepository::access()`).

## Query & helper methods you inherit (`TypedRepositoryBase`)

- `getQuery(): QueryInterface` — an access-checked entity query already scoped to the bundle.
- `wrapAll(string $operation = 'view'): array` — load + wrap every (accessible) entity of the bundle.
- `wrapMultipleById(array $ids): array` — load and wrap entities by ID.
- `createEntity(array $values = []): WrappedEntityInterface` — create a new entity (bundle key
  auto-set) and return it already wrapped. Call `->getEntity()->save()` to persist.
- `wrap(EntityInterface $entity): ?WrappedEntityInterface` — wrap one entity (returns NULL on
  entity-type/bundle mismatch).

## Alter hook

`hook_typed_repository_info(array &$definitions)` — alter or add discovered repository
definitions from another module (the manager calls `alterInfo('typed_repository_info')`).

For wrappers/renderers and variant selection see
[api/wrapped-entities-and-renderers.md](../api/wrapped-entities-and-renderers.md) and
[api/variants.md](../api/variants.md).
