# Typed Entity — agent index

Attach OOP classes to existing Drupal entities: a **wrapped entity** holds an entity's business
logic, a **typed repository** plugin maps an entity-type/bundle to its wrapper + renderer.
No config, no permissions, no Drush in the base module (a submodule adds each). Entry point is
the `Drupal\typed_entity\RepositoryManager` service.

- **Define a repository plugin (`#[TypedRepository]` attribute, wrappers/renderers, alter hook)** →
  [plugins/typed-repository.md](plugins/typed-repository.md)
- **`RepositoryManager` service + repository query/create helpers (`wrap`, `repository`, `getQuery`, `wrapAll`, `createEntity`)** →
  [api/repository-manager.md](api/repository-manager.md)
- **Write a wrapped entity (`WrappedEntityBase`: `owner`, `wrapReference`, `label`) and a renderer (`TypedEntityRendererBase`)** →
  [api/wrapped-entities-and-renderers.md](api/wrapped-entities-and-renderers.md)
- **Wrapper/renderer variants: `ClassWithVariants`, `applies()`, field-value conditions** →
  [api/variants.md](api/variants.md)

Key facts:
- Repository plugins live in `Plugin/TypedRepositories/`, plugin type `typed_entity_repository`,
  declared with `#[TypedRepository(entity_type_id: 'node', bundle: 'article', wrappers: new
  ClassWithVariants(Article::class, [BakingArticle::class]), renderers: new ClassWithVariants(...))]`.
- Repository id = `entity_type_id` + `.` + `bundle` (bundle-less types are just `entity_type_id`,
  e.g. `user`).
- Get a wrapped entity: `\Drupal::service(RepositoryManager::class)->wrap($entity)` or
  `typed_entity_repository_manager()->wrap($entity)`.
- Submodules: `typed_entity_example` (Article/User demo) and `typed_entity_ui` (admin explorer
  at `/admin/config/development/typed-entity`, permission `explore typed entity classes`) — each
  documented under `modules/`.
