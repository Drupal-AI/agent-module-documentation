<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & manage actions

## What this module owns

The `action` config entity type is defined by **core System** (`Drupal\system\Entity\Action`).
This module (`action_entity_type_build()` in `action.module`) attaches to it: the list
builder, the add/edit/delete forms, and link templates — i.e. the whole UI. It adds
nothing to the config entity schema itself; it adds schema only for the three configurable
plugins it ships.

## UI routes (all require permission `administer actions`)

| Route | Path | Purpose |
|---|---|---|
| `entity.action.collection` | `/admin/config/system/actions` | list simple + advanced actions; "Create an advanced action" select |
| `action.admin_add` | `/admin/config/system/actions/add/{action_id}` | add form for a chosen action plugin |
| `entity.action.edit_form` | `/admin/config/system/actions/configure/{action}` | configure an advanced action |
| `entity.action.delete_form` | `/admin/config/system/actions/configure/{action}/delete` | delete |

`configure` in info.yml → `entity.action.collection`. Menu link under
*Configuration › System › Actions*.

## The `action` config entity

Stored as `action.action.{id}`. Fields: `id`, `label`, `type` (the target entity type id,
e.g. `node`/`comment`/`user`), `plugin` (the Action plugin id), `configuration` (plugin
settings map). **Simple** actions have empty `configuration` and are auto-listed;
**advanced** actions are user-created and carry `configuration`.

## The three configurable "advanced" action plugins this module ships

| Plugin id | `type` | Label | `configuration` keys |
|---|---|---|---|
| `node_assign_owner_action` | `node` | Change the author of content | `owner_uid` (uid string) |
| `node_unpublish_by_keyword_action` | `node` | Unpublish content containing keyword(s) | `keywords` (list of strings) |
| `comment_unpublish_by_keyword_action` | `comment` | Unpublish comment containing keyword(s) | `keywords` (list of strings) |

Config schema for these is in `config/schema/action.schema.yml`
(`action.configuration.<plugin_id>`). Keyword matching is **case-sensitive**; the
comma-separated form value is parsed with `Tags::explode()` into the `keywords` sequence.
The unpublish plugins render the entity and unpublish it if any keyword appears in the
rendered output or (for nodes) the title. Assign-owner uses a user select for <200 users,
otherwise an autocomplete.

Other modules provide many more (simple) Action plugins that also show up here — anything
registered with the `plugin.manager.action` manager (core's `entity:*_action:*`,
`node_promote_action`, etc.).

## Create an advanced action without the UI

Drush / PHP (an `action` config entity):

```php
\Drupal::entityTypeManager()->getStorage('action')->create([
  'id' => 'unpublish_banned_words',
  'label' => 'Unpublish content containing banned words',
  'type' => 'node',
  'plugin' => 'node_unpublish_by_keyword_action',
  'configuration' => ['keywords' => ['spam', 'casino']],
])->save();
```

As exported config (`action.action.unpublish_banned_words.yml`):

```yaml
langcode: en
status: true
dependencies:
  module: [node]
id: unpublish_banned_words
label: 'Unpublish content containing banned words'
type: node
plugin: node_unpublish_by_keyword_action
configuration:
  keywords: [spam, casino]
```

List / inspect:

```bash
drush config:status                       # see action.action.* changes
drush php:eval '$a=\Drupal::entityTypeManager()->getStorage("action")->loadMultiple();
foreach($a as $id=>$e){print "$id | ".$e->getType()." | ".$e->get("plugin")." | ".json_encode($e->get("configuration"))."\n";}'
```

Execute an action in code (actions are executed by whatever integrates them — VBO, ECA,
Rules, cron sweeps):

```php
$action = \Drupal::entityTypeManager()->getStorage('action')->load('unpublish_banned_words');
$action->getPlugin()->execute($node);   // or ->executeMultiple([$node1, $node2])
```
