<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration and tokens

## The join

`HistoryViewsHooks::viewsData()` registers the `history` table in the **Content** group and
joins it to `node_field_data`:

```php
$data['history']['table']['join']['node_field_data'] = [
  'table' => 'history',
  'left_field' => 'nid',
  'field' => 'nid',
  'extra' => [['field' => 'uid', 'value' => '***CURRENT_USER***', 'numeric' => TRUE]],
];
```

So every history handler is implicitly scoped to the **current user** — there is no way to
report on another user's read state through these handlers.

## Handlers

| Id | Kind | Views label | Class |
|---|---|---|---|
| `history_user_timestamp` | field | *Has new content* — "Show a marker if the content is new or updated." | `Drupal\history\Plugin\views\field\HistoryUserTimestamp` |
| `history_user_timestamp` | filter | "Show only content that is new or updated." | `Drupal\history\Plugin\views\filter\HistoryUserTimestamp` |
| `node_new_comments` | field | *New comments* — "The number of new comments on the node." (`no group by`) | `Drupal\history\Plugin\views\field\NodeNewComments` |

`node_new_comments` is added by `hook_views_data_alter()` on the `node` table and only when
the `comment` module is installed.

## Adding them to a view

In the UI: add the field/filter from the **Content** group — search for
*"Has new content"* or *"New comments"*.

In config (`views.view.<id>.yml`), inside a display's `display_options`:

```yaml
fields:
  history_user_timestamp:
    id: history_user_timestamp
    table: history
    field: history_user_timestamp
    plugin_id: history_user_timestamp
    entity_type: node
    comments: false          # also mark when there are new comments
filters:
  history_user_timestamp:
    id: history_user_timestamp
    table: history
    field: history_user_timestamp
    plugin_id: history_user_timestamp
    value: 1                 # 1 = "New content"
```

A "New comments" field:

```yaml
fields:
  new_comments:
    id: new_comments
    table: node
    field: new_comments
    plugin_id: node_new_comments
    entity_type: node
```

Check what a live view already uses:

```bash
drush cget views.view.frontpage display.default.display_options.fields
drush php:eval '
  $ids = \Drupal::entityQuery("view")->accessCheck(FALSE)->execute();
  foreach (\Drupal::entityTypeManager()->getStorage("view")->loadMultiple($ids) as $v) {
    foreach ($v->get("display") as $d) {
      foreach (($d["display_options"]["filters"] ?? []) + ($d["display_options"]["fields"] ?? []) as $h) {
        if (($h["plugin_id"] ?? "") === "history_user_timestamp") { print $v->id() . "\n"; break 2; }
      }
    }
  }'
```

The module ships `config/schema/history.views.schema.yml` for these handlers' options — that
is the only config schema it provides.

## Token

`HistoryTokensHooks::tokenInfo()` adds **`comment-count-new`** ("New comment count" — "The
number of comments posted on an entity since the reader last viewed it") to every content
entity type that has at least one comment field, *except* `comment` itself. `taxonomy_term`
is registered under the token type `term`.

```
[node:comment-count-new]
[term:comment-count-new]
```

`HistoryTokensHooks::tokens()` resolves it with
`\Drupal::service(HistoryManager::class)->getCountNewComments($entity)`, i.e. it is
per-current-user and returns FALSE (rendering as empty) for anonymous users.

```bash
drush php:eval '
  $n = \Drupal\node\Entity\Node::load(1);
  print \Drupal::token()->replace("[node:comment-count-new]", ["node" => $n]);'
```
