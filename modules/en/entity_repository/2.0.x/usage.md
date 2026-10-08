<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Repository provides abstract base repository classes and parent services you extend, so entity queries live in named, injectable services (`NewsRepository::findByTags()`) instead of being copied ad hoc through controllers, blocks and forms.

---

This is a developer-only module with no UI, no routes, no permissions and no configuration — its own README states it "won't do much by itself." It ships one abstract base class, `Drupal\entity_repository\Repository\EntityRepository`, plus three concrete subclasses — `NodeRepository`, `TaxonomyTermRepository` and `CommentRepository` — each registered as a service (`entity_repository.repository.node`, `.taxonomy_term`, `.comment`) that injects the database connection, entity type manager, language manager and pager manager. You build a repository by declaring your own service with `parent: entity_repository.repository.node` and either extending the subclass (setting `protected array $bundles = ['news'];`) or, for the no-custom-class path, using `calls: - [setBundles, [['news']]]`. The base class supplies `findAll(?int $pager, array $sort)`, `findBy(array $criteria, ?int $pager, array $sort)`, `countBy(array $criteria)`, `countBaseQuery()` and `loadByIds(array $ids)`; subclasses implement the abstract `getBaseQuery()` which builds an entity query constrained to the bundle(s), the current content language and `status = published`, adds the relevant access tag (`node_access`, `comment_access`, `taxonomy_term_access`) and calls `accessCheck()` (defaulting to TRUE), so results respect entity access. `TaxonomyTermRepository` filters by vocabulary via `setVocabularies()`/`getVocabularies()`. `CommentRepository` adds `findByCommentedEntity()` and `countByCommentedEntity()`. Sorting is expressed as `['field' => ..., 'dir' => 'ASC'|'DESC', 'langcode' => ...]` (single or list), and `SORT_ASCENDING`/`SORT_DESCENDING` constants live on the interface. The `entity_repository_example` submodule shows the full shape (news repository + news-category taxonomy repository + a controller rendering teasers). One thing to be deliberate about: centralising queries is the place to get access checking right once — the shipped base queries enable it, but any custom raw-database query you add (the example submodule includes one) bypasses it, so decide per method whether it returns *what this user may see* or *what exists* and put that in the method name.

---

- Centralise entity queries behind named services instead of inline `getStorage()->getQuery()` calls.
- Stop repeating (and diverging) query code across controllers, blocks and forms.
- Give a domain query a documented, testable name (`findByNewsCategory()`).
- Constrain a repository to one or more content-type bundles via `$bundles`.
- Constrain a taxonomy repository to specific vocabularies via `setVocabularies()`.
- Create a repository with no custom class using a service `parent:` plus a `setBundles` call.
- Query published nodes of a bundle in the current content language with `findAll()`.
- Filter entities by arbitrary field criteria with `findBy(['field_x' => $value])`.
- Count matching entities without loading them via `countBy()` / `countBaseQuery()`.
- Load specific entities by ID through `loadByIds()`.
- Add a pager to a listing by passing the per-page limit to `findAll()`/`findBy()`.
- Apply single or multi-field sorting with a `['field' => ..., 'dir' => ...]` array.
- Fetch published comments on a given entity/field with `findByCommentedEntity()`.
- Inject a repository into a controller or plugin instead of the entity storage handler.
- Keep entity-access checking (`accessCheck()` + access tag) consistent in one place.
- Unit/kernel-test query logic in isolation (the module ships kernel tests as a model).
- Build a thin domain layer over nodes, taxonomy terms and comments.
- Share one query between a block plugin and a controller.
- Standardise query conventions across a team or across a large codebase.
- Extend the base with custom raw-database queries when the entity query API is insufficient.
- Use the `entity_repository_example` submodule as a copy-paste starting template.
