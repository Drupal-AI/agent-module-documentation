# The example classes

All namespaced under `Drupal\typed_entity_example\`. This is a read-and-copy reference; see the
base module's [plugins/typed-repository.md](../../../../4.1.x/agent/plugins/typed-repository.md)
and [api/*](../../../../4.1.x/agent/api/repository-manager.md) for the API these use.

## Repositories (`src/Plugin/TypedRepositories/`)

- **`ArticleRepository`** — `#[TypedRepository(entity_type_id: 'node', bundle: 'article',
  wrappers: new ClassWithVariants(Article::class, [BakingArticle::class]),
  renderers: new ClassWithVariants(variants: [Full::class]))]`. Implements `AccessibleInterface`.
  - `const FIELD_TAGS_NAME = 'field_tags'`.
  - `findByTags(array $tags): Article[]` — builds a scoped `getQuery()` with an
    `orConditionGroup()` matching `field_tags.entity.name` (LIKE), wraps the results, keeps only
    `Article` instances.
  - `access()` — returns `AccessResult::forbidden()` when more than 8 published articles exist,
    else neutral (demo of repository-level access).
- **`UserRepository`** — `#[TypedRepository(entity_type_id: 'user', wrappers: new
  ClassWithVariants(User::class))]`. Bundle-less; repository id is just `user`.

## Wrapped entities (`src/WrappedEntities/`)

- **`Article`** (extends `WrappedEntityBase`, implements `AccessibleInterface`) — constructor
  injects the messenger via `create()`. `owner()` returns the author as a wrapped `User` (and
  adds a status message); `access()` forbids when the author nickname contains a forbidden word
  (`synergy`, `disruption`) via `checkInappropriateLanguage()`.
- **`BakingArticle`** (extends `Article`) — variant wrapper. Overrides the forbidden-word list
  (`flat`, `unfluffy`) and adds `yeastOrBakingSoda(): string`. NB: its `applies()` here is only
  illustrative (it never returns TRUE for a real entity), so in practice the `Article` fallback
  is used unless you fix the condition.
- **`User`** (extends `WrappedEntityBase`, final) — `nickname(): string` returns the part of the
  registration email before the `@`.

## Renderer (`src/Render/Article/`)

- **`Full`** (extends `TypedEntityRendererBase`, `const VIEW_MODE = 'full'`) — `preprocess()`
  sets `$variables['attributes']['style'] = 'background-color: cyan;'`. Visible on an article's
  full page once enabled.

## Access hook (`typed_entity_example.module`)

`hook_entity_access` fetches the repository for the entity, calls its `access()` if it is
`AccessibleInterface`, then the wrapped entity's `access()` — returning the first non-neutral
result. The file's own docblock notes this is a demonstration, not a recommended production
pattern.

## Trying it

```php
$node = \Drupal\node\Entity\Node::load($nid);            // an article
$wrapped = \Drupal::service(\Drupal\typed_entity\RepositoryManager::class)->wrap($node);
// $wrapped instanceof Drupal\typed_entity_example\WrappedEntities\Article
$author = $wrapped->owner();                              // wrapped User
$nick   = $author?->nickname();
```
