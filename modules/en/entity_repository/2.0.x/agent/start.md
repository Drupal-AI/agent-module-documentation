<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Repository (entity_repository) — agent index

Developer-only module. Provides abstract/base **repository** classes registered as parent services,
so entity queries live in named, injectable services rather than being copied through controllers,
blocks and forms. No routes, no permissions, no configuration, no plugin types. Version **2.0.5**,
core `^8.8 || ^9 || ^10 || ^11`, license GPL-2.0-or-later. Depends on nothing; the `comment`,
`node`, `taxonomy` entity types are referenced by the respective subclasses.

## What it actually ships
- `src/Repository/EntityRepository.php` — abstract base implementing `EntityRepositoryInterface`.
  Constructor injects `@database`, `@entity_type.manager`, `@language_manager`, `@pager.manager`.
- `src/Repository/EntityRepositoryInterface.php` — the public contract + `SORT_ASCENDING` /
  `SORT_DESCENDING` constants.
- `src/Repository/NodeRepository.php` — `$entityType = 'node'`, base query = published + bundle +
  current langcode, tag `node_access`, `accessCheck()`.
- `src/Repository/TaxonomyTermRepository.php` — `$entityType = 'taxonomy_term'`, filters by
  vocabulary (`setVocabularies()`/`getVocabularies()`), tag `taxonomy_term_access`.
- `src/Repository/CommentRepository.php` — `$entityType = 'comment'`, tag `comment_access`, adds
  `findByCommentedEntity()` / `countByCommentedEntity()`.
- `entity_repository.services.yml` — registers `entity_repository.repository.content` (base) and the
  three concrete parent services `.node`, `.taxonomy_term`, `.comment`.
- `modules/entity_repository_example/` — submodule demonstrating the pattern (news repo, news
  category taxonomy repo, a controller + route `/entity_repository/example/news`, `access content`).

## Base API (defined on EntityRepository / interface)
| Method | Purpose |
| --- | --- |
| `findAll(?int $pager = NULL, array $sort = [])` | All published, bundle-constrained entities; optional pager + sort. |
| `findBy(array $criteria, ?int $pager = NULL, array $sort = [])` | Filter by field ⇒ value (`IN` when value is array). |
| `countBy(array $criteria)` | Count matches for criteria. |
| `countBaseQuery()` | Count the base query. |
| `loadByIds(array $ids)` | `loadMultiple()` of the entity type. |
| `setBundles(array)` / `setEntityType(string)` | Configure a base instance without a subclass. |
| `getBaseQuery()` *(abstract, protected)* | Subclass implements the constrained entity query. |
| helpers | `getResults()`, `getLangCode()`, `addEntityQuerySort()`, `initializeQueryPager()`. |

## How you use it
Declare a service with `parent: entity_repository.repository.node` and either subclass the base
(set `protected array $bundles = [...]`) or use `calls: - [setBundles, [['news']]]` with no custom
class. `sort` is `['field' => ..., 'dir' => 'ASC'|'DESC', 'langcode' => ...]` (single or list).

## Key facts / gotchas
- **Its README states the scope plainly:** *"This module won't do much by itself."* It is a pattern
  plus plumbing, not a feature.
- **Shipped base queries enforce entity access** (`accessCheck()` default TRUE + access tag). If you
  add a custom **raw-database** query (`$this->connection->select(...)`) it does NOT — that path
  bypasses entity access, so gate/verify it yourself. The example submodule includes one such raw
  query (`NewsCategoryRepository::findAllCoupledToNewsItem()`, which also has a bug: it joins alias
  `e` that is never defined).
- The example submodule's `NewsRepository` uses `$bundles = ['vacancy']` and references fields
  `field_news_category` / `field_news_tags` that only exist if you create them — it is illustrative.

See `agent/services/repositories.md` for the full extend-and-register recipe.
