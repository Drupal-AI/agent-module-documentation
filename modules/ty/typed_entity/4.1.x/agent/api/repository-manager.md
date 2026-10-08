# RepositoryManager service

Service id / class: **`Drupal\typed_entity\RepositoryManager`** (autowired by class name).
Implements `EntityWrapperInterface`. This is the entry point to typed entities.

```php
$manager = \Drupal::service(\Drupal\typed_entity\RepositoryManager::class);
// or, in a .module file:
$manager = typed_entity_repository_manager();
```

## Methods

| Method | Returns | Purpose |
|---|---|---|
| `wrap(EntityInterface $entity)` | `?WrappedEntityInterface` | Wrap one entity into its domain object (NULL if no repository matches). |
| `wrapMultiple(array $entities)` | `WrappedEntityInterface[]` | Wrap many; unmatched entities are filtered out. |
| `repository(string $entity_type_id, string $bundle = '')` | `?TypedRepositoryInterface` | Get the repository for a type/bundle pair. |
| `repositoryFromEntity(EntityInterface $entity)` | `?TypedRepositoryInterface` | Same, derived from an entity instance. |
| `get(string $repository_id)` | `?TypedRepositoryInterface` | Get a repository by id (`node.article`, `user`). Falls back from `type.bundle` to `type` when no bundle-specific repo exists. |
| `getAll()` | `TypedRepositoryInterface[]` | Every registered repository. |

## Common patterns

```php
// Wrap a node and call domain logic:
$wrapped = $manager->wrap($node);            // e.g. an Article object
$author  = $wrapped->owner();                // wrapped User (see wrapped-entities doc)

// Get a repository and run a scoped query:
$repo = $manager->repository('node', 'article');
$ids  = $repo->getQuery()->condition('status', 1)->execute();
$articles = $repo->wrapMultipleById($ids);

// Create a new, already-typed entity (bundle auto-set) and save it:
$wrapped = $manager->repository('node', 'article')->createEntity(['title' => 'Hello']);
$wrapped->getEntity()->save();

// Bundle-less type (no bundle argument):
$userRepo = $manager->repository('user');    // id is just "user"
```

Repository ids use `.` as the separator (`TypedRepositoryInterface::ID_PARTS_SEPARATOR`), so a
node/article repository has id `node.article` and a bundle-less user repository has id `user`.
Deriver-based repositories are also resolved by `get()`.
