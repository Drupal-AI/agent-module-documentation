# Typed Entity — manual setup guide

**Typed Entity** (`typed_entity`) is a developer tool for writing cleaner,
more maintainable Drupal code. It lets you attach real object-oriented classes to
your existing entities, so business logic lives in typed, testable objects instead
of being scattered across procedural hooks. Instead of repeating
`$node->get('field_x')->value` everywhere, you call intention-revealing methods on
a domain object like `$article->isFeatured()` or `$article->owner()`.

It has no user interface of its own and nothing for a site builder to configure —
it's a coding framework. The design is documented in Lullabot's "maintainable code
with wrapped entities" article, and the module builds on two ideas:

- A **wrapped entity** (`WrappedEntityBase`) is a plain PHP object that decorates a
  Drupal entity and holds the business logic that applies to it — `label()`,
  `owner()`, `wrapReference()`, and any domain-specific methods you add.
- A **typed repository** is a plugin that maps an entity-type/bundle pair to its
  wrapper and renderer classes and offers query helpers (`getQuery()`,
  `wrapAll()`, `wrapMultipleById()`, `createEntity()`). You declare one with a
  `#[TypedRepository(...)]` PHP attribute on a class in your module's
  `Plugin/TypedRepositories/` directory.

The `RepositoryManager` service is the entry point: `wrap($entity)` returns the
right wrapped object for any entity, and `repository($entity_type, $bundle)`
returns the repository. Wrappers and renderers can also have **variants** — for
example a `BakingArticle` wrapper that applies only to articles tagged "Baking",
with everything else falling back to a plain `Article` wrapper. On the render side,
a repository's renderer is invoked automatically from the entity view/preprocess
hooks, so a wrapped entity can alter its own render output without a global hook.

The base module ships no configuration, permissions, or Drush commands. Two
optional submodules help: **Typed Entity Example** demonstrates the pattern with
Article and User repositories, and **Typed Entity UI** adds an admin explorer that
shows which wrapper/renderer classes apply to each entity-type/bundle pair.

This guide is written for a **human**. Because Typed Entity is a developer
framework, the working detail lives in the sibling [`agent/`](../agent/start.md)
docs — the repository attribute, the `RepositoryManager` service, wrappers,
renderers, and variants.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.

## Where it lives in the admin menu

The base module has **no admin pages**. If you enable the **Typed Entity UI**
submodule, it adds an explorer at **Configuration → Development → Typed Entity**
(`/admin/config/development/typed-entity`), gated by the **Explore typed entity
classes** permission.

## How to use it

Typed Entity is used from code, not the admin UI. The typical shape is:

1. **Write a wrapped entity** — a class extending `WrappedEntityBase` that holds
   your bundle's domain methods.
2. **Declare a repository** — a class in `src/Plugin/TypedRepositories/` with the
   `#[TypedRepository(...)]` attribute mapping an entity type and bundle to your
   wrapper (and optionally a renderer):

   ```php
   #[TypedRepository(
     entity_type_id: 'node',
     bundle: 'article',
     wrappers: new ClassWithVariants(Article::class, [BakingArticle::class]),
   )]
   final class ArticleRepository extends TypedRepositoryBase {
     // Domain query methods, e.g. findByTags()...
   }
   ```

3. **Wrap and use entities** from your own services and controllers:

   ```php
   $article = \Drupal::service(RepositoryManager::class)->wrap($node);
   $author  = $article->owner();   // a wrapped User object
   ```

The quickest way to learn the pattern is to enable the **Typed Entity Example**
submodule and read its Article/User repositories, then browse your own site's
classes with the **Typed Entity UI** explorer. See the
[`agent/`](../agent/start.md) docs for the full API, variant conditions, renderers,
and the `hook_typed_repository_info()` alter hook.
