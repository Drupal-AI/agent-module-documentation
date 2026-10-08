Typed Entity lets you attach real OOP classes (wrapped entities and repositories) to your existing Drupal entities, so business logic lives in typed, testable objects instead of scattered hooks. You define a repository plugin per entity-type/bundle and wrap any entity into a domain class.

---

Typed Entity provides two core abstractions. A **wrapped entity** (`WrappedEntityBase`) is a plain PHP object that decorates a Drupal entity and holds the business logic that applies to it — methods like `label()`, `owner()`, `wrapReference()`, and anything domain-specific you add. A **typed repository** is a plugin (discovered from `Plugin/TypedRepositories`, declared with the `#[TypedRepository(entity_type_id, bundle, wrappers, renderers)]` attribute) that maps an entity-type/bundle pair to its wrapper and renderer classes and offers query helpers (`getQuery()`, `wrapAll()`, `wrapMultipleById()`, `createEntity()`). The `RepositoryManager` service (`Drupal\typed_entity\RepositoryManager`) is the entry point: `wrap($entity)` returns the right wrapped object, and `repository($entity_type, $bundle)` returns the repository. Wrappers and renderers can have **variants** via `ClassWithVariants(fallback, [variants])`: each variant implements a static `applies(TypedEntityContext $context): bool`, and configurable conditions like `FieldValueVariantCondition` / `EmptyFieldVariantCondition` let you pick, say, a `BakingArticle` wrapper for articles tagged "Baking" while other articles fall back to `Article`. On the render side, a repository's renderer (extending `TypedEntityRendererBase`) is invoked automatically from `hook_entity_view_alter`, `hook_preprocess`, and related hooks, so a wrapped entity can alter its own build/preprocess output. The module ships no configuration, permissions, or Drush of its own; the `typed_entity_example` submodule demonstrates the pattern (Article/User repositories) and `typed_entity_ui` adds an admin explorer. The design is documented in Lullabot's "maintainable code with wrapped entities" article.

---

- Move entity business logic out of procedural hooks into a testable `WrappedEntityBase` subclass.
- Define a repository for the Article content type that exposes `findByTags()` and other domain queries.
- Wrap any entity with `RepositoryManager::wrap($entity)` and call typed methods on it.
- Give a bundle a domain class (e.g. `Product`, `Event`, `Article`) with methods that express its rules.
- Select a specialized wrapper variant (e.g. `BakingArticle`) when a field has a given value, via `ClassWithVariants`.
- Use `FieldValueVariantCondition` to switch wrapper/renderer based on a field's value.
- Use `EmptyFieldVariantCondition` to branch behavior when a field is empty or populated.
- Centralize access logic per bundle by implementing `AccessibleInterface` on the repository or wrapper.
- Build an entity query scoped to a bundle with the repository's `getQuery()` helper.
- Load and wrap every entity of a bundle with `wrapAll()` (access-checked) for batch domain operations.
- Wrap a set of IDs at once with `wrapMultipleById()`.
- Create a new, already-typed entity with `$repository->createEntity(['title' => ...])` (bundle auto-set).
- Follow an entity reference and get the referenced entity already wrapped via `wrapReference()`.
- Wrap a multi-value reference field into an array of wrapped entities with `wrapReferences()`.
- Get a node's author as a wrapped `User` object through `owner()`.
- Alter an entity's render array from its wrapper's renderer (`viewAlter`, `preprocess`) instead of a global hook.
- Provide a per-bundle renderer that only applies in a specific view mode (`TypedEntityRendererBase::VIEW_MODE`).
- Register a repository purely by adding a `#[TypedRepository(...)]` attribute to a class in `Plugin/TypedRepositories`.
- Alter or add repository definitions from another module via the `typed_repository_info` alter hook.
- Model a bundle-less entity type (e.g. `user`) with a repository that omits the `bundle` argument.
- Explore which wrapper/renderer classes apply to each entity-type/bundle pair using the Typed Entity UI submodule.
- Write unit tests against wrapped-entity methods by injecting mocked services via `setRepositoryManager()` / `setViewBuilder()`.
- Keep controllers and services thin by delegating entity logic to wrapped objects.
- Replace repeated `$node->get('field_x')->value` access with intention-revealing wrapper methods.
