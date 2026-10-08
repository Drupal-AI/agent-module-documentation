<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Repository services — extend & register recipe

Entity Repository exposes four services. The base is abstract in spirit (`EntityRepository` has an
abstract `getBaseQuery()`), so you consume the module through the three concrete parent services.

```yaml
# entity_repository.services.yml (shipped)
services:
  entity_repository.repository.content:      # base plumbing (DI only)
    class: Drupal\entity_repository\Repository\EntityRepository
    arguments: ['@database', '@entity_type.manager', '@language_manager', '@pager.manager']
  entity_repository.repository.taxonomy_term:
    class: Drupal\entity_repository\Repository\TaxonomyTermRepository
    parent: entity_repository.repository.content
  entity_repository.repository.node:
    class: Drupal\entity_repository\Repository\NodeRepository
    parent: entity_repository.repository.content
  entity_repository.repository.comment:
    class: Drupal\entity_repository\Repository\CommentRepository
    parent: entity_repository.repository.content
```

`parent:` makes your service inherit the four constructor arguments — you never re-list them.

## Pattern A — subclass with custom queries

```php
namespace Drupal\news\Repository;

use Drupal\entity_repository\Repository\NodeRepository;

class NewsRepository extends NodeRepository {

  protected array $bundles = ['news'];

  public function findByTags(array $tags = [], ?int $pager = NULL, array $sort = []) : array {
    $query = $this->getBaseQuery();                 // published + bundle + langcode + node_access
    if (!empty($tags)) {
      $query->condition('field_news_tags', $tags, 'IN');
    }
    if ($pager) {
      $query->pager($pager);
    }
    $this->addEntityQuerySort($query, $sort);
    return $this->getResults($query);               // loadMultiple of matched IDs
  }
}
```

```yaml
news.repository.news:
  class: Drupal\news\Repository\NewsRepository
  parent: entity_repository.repository.node
```

## Pattern B — no custom class

```yaml
news.repository.news:
  class: Drupal\entity_repository\Repository\NodeRepository
  parent: entity_repository.repository.node
  calls:
    - [setBundles, [['news']]]
```

For taxonomy use `entity_repository.repository.taxonomy_term` and `setVocabularies([...])`.

## Calling it

```php
$repo  = \Drupal::service('news.repository.news');   // prefer constructor injection
$all   = $repo->findAll(12, ['field' => 'created', 'dir' => 'DESC']);
$byCat = $repo->findBy(['field_news_category' => 3]);
$count = $repo->countBy(['field_news_category' => 3]);
$one   = $repo->loadByIds([42]);
```

## Base query semantics per subclass

| Subclass | `getBaseQuery()` conditions | Access |
| --- | --- | --- |
| `NodeRepository` | `status = PUBLISHED`, `type IN $bundles`, `langcode = current`, meta `langcode` | tag `node_access` + `accessCheck()` |
| `TaxonomyTermRepository` | `status = TRUE`, `vid IN $vocabularies`, `langcode = current` | tag `taxonomy_term_access` + `accessCheck()` |
| `CommentRepository` | `status = PUBLISHED`, `comment_type IN $bundles`, `langcode = current` | tag `comment_access` + `accessCheck()` |

`CommentRepository` extras: `findByCommentedEntity($entity_type, $entity_id, $field_name, $pager, $sort)`
and `countByCommentedEntity(...)`, both thin wrappers over `findBy()`/`countBy()`.

## Notes
- `accessCheck()` is called with no argument, which defaults to `TRUE` — the shipped entity queries
  respect view access. Custom **raw-database** queries you add do not; add access logic yourself.
- `getCurrentDate()` returns `date('Y-m-dTh:i:s')` — note the literal `T`/12-hour `h`; treat it as a
  loose helper, not an ISO-8601 timestamp.
- Sort accepts a single `['field'=>..,'dir'=>..]` or a list of them; `langcode` defaults to the
  current content language when omitted.
