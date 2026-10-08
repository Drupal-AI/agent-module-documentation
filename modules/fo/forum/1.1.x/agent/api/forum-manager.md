# Forum API — services

Two services let you read the board programmatically instead of querying taxonomy/node
tables yourself.

## `forum_manager` (`\Drupal\forum\ForumManagerInterface`)

Autowire the interface or `\Drupal::service('forum_manager')`. Tagged
`backend_overridable`. Methods:

| Method | Returns / does |
|---|---|
| `getIndex()` | Root forum term tree with per-forum topic/post counts and last-post data (the `/forum` index). |
| `getChildren($vid, $tid)` | Child forums/containers of term `$tid` in vocabulary `$vid`. |
| `getTopics($tid, AccountInterface $account)` | `[topics, header]` for one forum: the topic nodes (paged by `forum.settings:topics.page_limit`, sorted by `topics.order`) plus a table header, with read/new state for `$account`. |
| `checkNodeType(NodeInterface $node)` | TRUE if the node is of the forum node type (`forum`). |
| `unreadTopics($term, $uid)` | Count of unread topics in forum `$term` for user `$uid` (uses core History). |
| `resetCache()` | Clear the manager's static caches. |

```php
$manager = \Drupal::service('forum_manager');
[$topics, $header] = $manager->getTopics($forum_tid, \Drupal::currentUser());
$index = $manager->getIndex();          // forums with counts + last post
$kids  = $manager->getChildren('forums', $container_tid);
```

## `forum.index_storage` (`\Drupal\forum\ForumIndexStorageInterface`)

Low-level `{forum_index}` / `{forum}` table access (also `backend_overridable`). Used
internally by node/comment entity hooks to keep the index in sync; call it when you build
custom forum queries. Key methods: `createIndex(NodeInterface)`, `updateIndex(NodeInterface)`,
`deleteIndex(NodeInterface)`, `updateIndexEntityComment(CommentInterface)`,
`readComment($tids, $vid, AccountInterface)`, `getOriginalTermId(NodeInterface)`.

## Data model reminders

- A topic is a `forum` node; its forum is the single value of the `taxonomy_forums`
  term-reference field.
- Containers vs forums are told apart by the `forum_container` field on the term (`1` vs
  `0`), not by a separate entity type.
- The `forum.settings:vocabulary` key names the vocabulary the manager reads; do not assume
  `forums` if the site changed it.
