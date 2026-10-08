# Typed Entity Example — agent index

Reference implementation of the [Typed Entity](../../../../4.1.x/agent/start.md) pattern for the
core **Article** content type and the **User** entity. Read it to learn the API; it has no
config, permissions, or plugin types of its own. Depends on `typed_entity`.

- **The example classes: repositories, wrapped entities, variant, renderer, access hook** →
  [api/example-classes.md](api/example-classes.md)

Key facts:
- Registers two repositories: `node.article` (wrapper `Article`, variant `BakingArticle`,
  renderer `Full`) and bundle-less `user` (wrapper `User`).
- `ArticleRepository` implements `AccessibleInterface` (forbids access when >8 articles are
  published) and demonstrates `findByTags()` / a scoped `getQuery()`.
- `Article::owner()` returns the author wrapped as a `User`; `User::nickname()` is the email
  local-part; `BakingArticle` adds `yeastOrBakingSoda()`.
- `Full` renderer sets a cyan background via `preprocess()`.
- `typed_entity_example.module` delegates `hook_entity_access` to the repository/wrapper access
  methods (marked as a demo pattern, not a recommendation).
- Once enabled, `RepositoryManager::wrap($node)` on an article returns a
  `Drupal\typed_entity_example\WrappedEntities\Article`.
