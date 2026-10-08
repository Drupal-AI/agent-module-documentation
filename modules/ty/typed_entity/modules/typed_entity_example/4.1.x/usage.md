Typed Entity Example is a reference implementation of the Typed Entity pattern: it ships working typed repositories, wrapped entities, a renderer, and an access hook for the core Article content type and the User entity, meant to be read and copied rather than used in production.

---

The submodule registers two typed repository plugins. `ArticleRepository` (`#[TypedRepository(entity_type_id: 'node', bundle: 'article', ...)]`) maps the Article content type to the `Article` wrapper with a `BakingArticle` variant, and to a `Full` renderer; it also demonstrates domain queries (`findByTags()`, a private published-count) and per-bundle access by implementing `AccessibleInterface` (it forbids access once more than eight articles are published). `UserRepository` maps the bundle-less `user` entity to the `User` wrapper. The wrapped entities show what business logic looks like in one place: `Article::owner()` returns the author as a wrapped `User` and messages a note, `Article::access()` blocks the entity when the author's nickname contains "inappropriate" words, `BakingArticle` overrides that word list and adds a `yeastOrBakingSoda()` method, and `User::nickname()` derives a nickname from the part of the email before the `@`. The `Full` renderer sets a cyan background via `preprocess()` to show how a wrapped entity can alter its own render output. `typed_entity_example.module` wires `hook_entity_access` to the repository/wrapper access methods (explicitly noted as a demonstration, not a recommended pattern). Enable it (best on an Umami install) to explore or unit-test the strategy; it defines no configuration, permissions, or plugin types of its own.

---

- Read a complete, working `#[TypedRepository]` plugin (`ArticleRepository`) to learn the attribute syntax.
- Copy the `UserRepository` as a template for a bundle-less entity type repository.
- See how a repository declares wrapper variants: `new ClassWithVariants(Article::class, [BakingArticle::class])`.
- Study `Article::owner()` for returning a referenced entity already wrapped as a `User`.
- Learn per-bundle access control from `ArticleRepository::access()` (forbid when >8 published articles).
- Learn per-entity access from `Article::access()` (block on an author's inappropriate nickname).
- See how a variant wrapper (`BakingArticle`) overrides a base method and adds its own (`yeastOrBakingSoda()`).
- Learn a computed accessor pattern from `User::nickname()` (email local-part).
- See a renderer (`Full`) alter render output via `preprocess()` (cyan background) for a view mode.
- Understand how `hook_entity_access` can delegate to typed repositories/wrappers (with the caveat noted).
- Use it as the fixture for unit tests of wrapped-entity methods (`UserTest`, `FullTest`).
- Enable it on Umami to visually confirm the renderer change on an article page.
- Reference `findByTags()` for building an entity query through a repository (`getQuery()` + orConditionGroup).
- Copy its directory layout (`Plugin/TypedRepositories`, `WrappedEntities`, `Render`) into your own module.
- Demonstrate to a team how business logic moves from hooks into wrapped entities.
- Provide live `node.article` and `user` repositories for experimenting with the `RepositoryManager` API.
- Use it as the data source when exploring repositories in the Typed Entity UI submodule.
- Learn how `createEntity()` returns a ready-wrapped entity for the Article/User types.
- See dependency injection into a wrapper via `Article::create()` (injects the messenger).
- Model your own "specialized subtype by field value" using the Baking-article example as a starting point.
