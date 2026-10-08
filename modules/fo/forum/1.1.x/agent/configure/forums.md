# Configure forums

The whole board structure is **taxonomy terms** in the `forums` vocabulary (config key
`forum.settings:vocabulary`, default `forums`). A term is a **container** when its
`forum_container` boolean field is `1` (grouping only, cannot hold topics) and a **forum**
(leaf) when `0` (holds topics). Parent/child nesting is the normal taxonomy term hierarchy.

## Admin UI routes

| Route | Path | Purpose |
|---|---|---|
| `forum.overview` (configure) | `/admin/structure/forum` | drag-and-drop tree of containers + forums |
| `forum.add_container` | `/admin/structure/forum/add/container` | add a container term |
| `forum.add_forum` | `/admin/structure/forum/add/forum` | add a forum term |
| `entity.taxonomy_term.forum_edit_container_form` | `/admin/structure/forum/edit/container/{term}` | edit container |
| `entity.taxonomy_term.forum_edit_form` | `/admin/structure/forum/edit/forum/{term}` | edit forum |
| `entity.taxonomy_term.forum_delete_form` | `/admin/structure/forum/delete/forum/{term}` | delete forum |
| `forum.settings` | `/admin/structure/forum/settings` | global settings form |
| `forum.index` | `/forum` | public forum index |
| `forum.page` | `/forum/{term}` | one forum's topic listing |

## Create containers and forums (drush)

Containers/forums are just terms with the `forum_container` flag set. There is no drush
command; use `drush php:eval`. A forum's parent is a container via the taxonomy `parent`.

```php
$storage = \Drupal::entityTypeManager()->getStorage('taxonomy_term');
// Container (grouping only):
$c = $storage->create(['vid' => 'forums', 'name' => 'General', 'forum_container' => 1]);
$c->save();
// Forum (a leaf, nested under the container):
$f = $storage->create([
  'vid' => 'forums',
  'name' => 'Announcements',
  'forum_container' => 0,
  'parent' => $c->id(),
]);
$f->save();
```

Read them back: every forum term carries the `forum_container` field, so
`$term->forum_container->value` distinguishes forums (`0`) from containers (`1`). List all:
`\Drupal::entityTypeManager()->getStorage('taxonomy_term')->loadByProperties(['vid' => 'forums'])`.

## Global settings — `forum.settings`

Config object (schema in `config/schema/forum.schema.yml`); edit with
`drush cset forum.settings <key> <value> -y` or the settings form.

| Key | Default | Meaning |
|---|---|---|
| `topics.page_limit` | `25` | topics shown per forum page |
| `topics.hot_threshold` | `15` | replies before a topic is flagged "hot" |
| `topics.order` | `1` | default topic sort (1=Date-newest post, 2=Date-newest topic, 3=Posts-most, 4=Posts-least) |
| `block.active.limit` | `5` | rows in the Active forum topics block |
| `block.new.limit` | `5` | rows in the New forum topics block |
| `vocabulary` | `forums` | machine name of the taxonomy vocabulary that backs the board |

```bash
drush cset forum.settings topics.page_limit 50 -y
drush cget forum.settings --format=yaml
```

## Blocks

Two block plugins ship with the module (place at Admin → Structure → Block layout, or via a
`block` config entity):

- `forum_active_block` — **Active forum topics** (threads with the most recent replies).
- `forum_new_block` — **New forum topics** (most recently created topics).

Each block's own `block_count` setting overrides the `block.active.limit` /
`block.new.limit` defaults above. (There is no dedicated "forum navigation" block — the
container/forum tree renders on the `/forum` index page itself.)

## What install creates

Enabling the module installs: the `forums` vocabulary, the `forum` ("Forum topic") node
type, the `taxonomy_forums` term-reference field on `forum` nodes (one forum per topic),
the `comment_forum` comment type + field, the `forum_container` boolean field on `forums`
terms, and `forum.settings`. Uninstall is blocked by `ForumUninstallValidator` while forum
terms or topics still exist.
